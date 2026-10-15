# Lecture 5.2: retrieve four secondary datasets through APIs
#
# First draft, written the way most projects start: one script, top to bottom.
# Lecture 5.3 reorganizes it into a reproducible project.
#
# Install once:
# install.packages(c("CropScapeR", "dataRetrieval", "nasapower", "tidycensus",
#                    "ggplot2", "dplyr", "readr", "sf"))

library(CropScapeR)
library(dataRetrieval)
library(nasapower)
library(tidycensus)
library(ggplot2)
library(dplyr)
library(readr)
library(sf)

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

# Larimer County boundary, used in the maps below (Census TIGER/Line, no key needed)
larimer <- tigris::counties(state = "CO", cb = TRUE, year = 2024, progress_bar = FALSE) |>
  filter(GEOID == "08069")

# 1. Land use: Cropland Data Layer, Larimer County, 2024 -----------------------

larimer_cdl <- GetCDLData(
  aoi = "08069",
  year = 2024,
  type = "f",
  save_path = "data/raw/cdl_larimer_2024.tif"
)
if (!file.exists("data/raw/cdl_larimer_2024.tif")) {
  stop("CropScape did not respond. Wait a minute, then run GetCDLData() again.")
}

# Map: the GeoTIFF carries the standard CDL colors (forest green, grassland tan, corn yellow).
# Code 0 marks cells outside the county; make it transparent.
cdl_map <- terra::rast("data/raw/cdl_larimer_2024.tif")
cdl_colors <- terra::coltab(cdl_map)[[1]]
cdl_colors$alpha[cdl_colors$value == 0] <- 0
terra::coltab(cdl_map) <- cdl_colors
terra::plot(cdl_map, legend = FALSE, axes = FALSE,
            main = "Cropland Data Layer, Larimer County, 2024")

# Acreage by land-cover class
cdl_acres <- GetCDLStat(aoi = "08069", year = 2024, type = "f")
write_csv(cdl_acres, "data/raw/cdl_larimer_2024_acres.csv")

cdl_acres |>
  slice_max(Acreage, n = 10) |>
  ggplot(aes(x = Acreage / 1000, y = reorder(Category, Acreage))) +
  geom_col(fill = "#1e4d2b") +
  labs(x = "Thousand acres", y = NULL,
       title = "Ten largest land-cover classes, Larimer County, 2024") +
  theme_minimal()

# 2. Water: daily discharge, Cache la Poudre River at Fort Collins -------------

poudre_flow <- read_waterdata_daily(
  monitoring_location_id = "USGS-06752260",
  parameter_code = "00060",
  time = c("2024-04-01", "2024-09-30")
)
names(poudre_flow)
write_csv(st_drop_geometry(poudre_flow), "data/raw/usgs_poudre_flow_2024.csv")

# Map: the gauge and the river upstream of it
gauge <- read_waterdata_monitoring_location(monitoring_location_id = "USGS-06752260")
upstream <- findNLDI(nwis = "06752260", nav = "UM", find = "flowlines",
                     distance_km = 150)$UM_flowlines

ggplot() +
  geom_sf(data = larimer, fill = "grey95", color = "grey40") +
  geom_sf(data = upstream, color = "#2c7fb8", linewidth = 0.8) +
  geom_sf(data = gauge, color = "#C4513A", size = 3) +
  labs(title = "Cache la Poudre River upstream of the Fort Collins gauge",
       caption = "Red point: USGS 06752260. Blue line: main stem upstream (USGS NLDI).") +
  theme_void()

# Daily discharge across the growing season
ggplot(poudre_flow, aes(x = as.Date(time), y = value)) +
  geom_line(color = "#2c7fb8") +
  labs(x = NULL, y = "Daily mean discharge (cubic feet per second)",
       title = "Cache la Poudre River at Fort Collins, April to September 2024") +
  theme_minimal()

# 3. Weather: NASA POWER near Fort Collins -------------------------------------

fort_collins_weather <- get_power(
  community = "AG",
  lonlat = c(-105.08, 40.58),
  pars = c("T2M_MAX", "T2M_MIN", "PRECTOTCORR"),
  temporal_api = "daily",
  dates = c("2024-04-01", "2024-09-30")
)
write_csv(fort_collins_weather, "data/raw/power_fort_collins_2024.csv")

# Map: POWER reports one value for a grid cell of 0.5 by 0.625 degrees.
# The cell containing the request point spans 40.25 to 40.75 N and 105.3125 to 104.6875 W.
power_cell <- st_as_sfc(st_bbox(c(xmin = -105.3125, ymin = 40.25, xmax = -104.6875, ymax = 40.75),
                                crs = st_crs(4326)))

ggplot() +
  geom_sf(data = larimer, fill = "grey95", color = "grey40") +
  geom_sf(data = power_cell, fill = "#fdae61", alpha = 0.4, color = "#d7301f") +
  geom_sf(data = upstream, color = "#2c7fb8", linewidth = 0.8) +
  geom_sf(data = gauge, color = "#C4513A", size = 3) +
  labs(title = "One weather grid cell covers Fort Collins and the surrounding area",
       caption = "Orange: NASA POWER grid cell (approximate). Red point: USGS gauge.") +
  theme_void()

# Daily precipitation (top) and temperature range (bottom)
weather_panels <- bind_rows(
  fort_collins_weather |>
    transmute(date = YYYYMMDD, panel = "Temperature range (C)", low = T2M_MIN, high = T2M_MAX),
  fort_collins_weather |>
    transmute(date = YYYYMMDD, panel = "Precipitation (mm)", low = 0, high = PRECTOTCORR)
)

ggplot(weather_panels, aes(x = date, ymin = low, ymax = high, color = panel)) +
  geom_linerange(linewidth = 0.8, show.legend = FALSE) +
  facet_wrap(~panel, ncol = 1, scales = "free_y") +
  scale_color_manual(values = c("Temperature range (C)" = "#C4513A",
                                "Precipitation (mm)" = "#2c7fb8")) +
  labs(x = NULL, y = NULL,
       title = "Daily weather, Fort Collins grid cell, April to September 2024") +
  theme_minimal()

# 4. Population: ACS median household income by tract -------------------------
# Requires CENSUS_API_KEY in your user .Renviron (usethis::edit_r_environ())

larimer_income <- get_acs(
  geography = "tract",
  variables = c(median_income = "B19013_001"),
  state = "CO",
  county = "Larimer",
  year = 2024,
  survey = "acs5",
  geometry = TRUE,
  key = Sys.getenv("CENSUS_API_KEY")
)
st_write(larimer_income, "data/raw/acs_larimer_tracts_2024.gpkg", delete_dsn = TRUE)

ggplot(larimer_income) +
  geom_sf(aes(fill = estimate), color = NA) +
  scale_fill_viridis_c(labels = scales::label_dollar()) +
  labs(fill = "Median income", title = "Median household income by census tract") +
  theme_void()
