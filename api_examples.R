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
library(readr)

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)

# 1. Land use: Cropland Data Layer, Larimer County, 2024 -----------------------

larimer_cdl <- GetCDLData(
  aoi = "08069",
  year = 2024,
  type = "f",
  save_path = "data/raw/cdl_larimer_2024.tif"
)
raster::plot(larimer_cdl)

cdl_acres <- GetCDLStat(aoi = "08069", year = 2024, type = "f")
write_csv(cdl_acres, "data/raw/cdl_larimer_2024_acres.csv")

# 2. Water: daily discharge, Cache la Poudre River at Fort Collins -------------

poudre_flow <- read_waterdata_daily(
  monitoring_location_id = "USGS-06752260",
  parameter_code = "00060",
  time = c("2024-04-01", "2024-09-30")
)
names(poudre_flow)
write_csv(sf::st_drop_geometry(poudre_flow), "data/raw/usgs_poudre_flow_2024.csv")

# 3. Weather: NASA POWER near Fort Collins -------------------------------------

fort_collins_weather <- get_power(
  community = "AG",
  lonlat = c(-105.08, 40.58),
  pars = c("T2M_MAX", "T2M_MIN", "PRECTOTCORR"),
  temporal_api = "daily",
  dates = c("2024-04-01", "2024-09-30")
)
write_csv(fort_collins_weather, "data/raw/power_fort_collins_2024.csv")

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
sf::st_write(larimer_income, "data/raw/acs_larimer_tracts_2024.gpkg", delete_dsn = TRUE)

ggplot(larimer_income) +
  geom_sf(aes(fill = estimate), color = NA) +
  labs(fill = "Median income", title = "Median household income by census tract")
