# 06_outputs.R
# Figures and tables from the derived data.
# Inputs:  data/derived/daily_flow_weather_2024.csv
#          data/raw/cdl_larimer_2024_acres.csv
#          data/raw/acs_larimer_tracts_2024.gpkg (optional; needs a Census key)
# Outputs: output/figures/flow_and_temperature_2024.png
#          output/tables/daily_summary.csv
#          output/tables/cdl_top_classes.csv
#          output/figures/acs_income_tracts.png, output/tables/acs_uncertainty.csv

daily <- read_csv(sprintf("data/derived/daily_flow_weather_%s.csv", data_year),
                  show_col_types = FALSE)

# Daily flow and temperature, one panel each -----------------------------------
daily_long <- bind_rows(
  daily |> transmute(date, panel = "Discharge (cubic feet per second)", value = flow_cfs),
  daily |> transmute(date, panel = "Maximum temperature (C)", value = tmax_c)
)

flow_temp_plot <- ggplot(daily_long, aes(date, value)) +
  geom_line(color = "#1e4d2b") +
  facet_wrap(~panel, ncol = 1, scales = "free_y") +
  labs(x = NULL, y = NULL,
       title = "Cache la Poudre River and Fort Collins weather, 2024 growing season",
       caption = "Sources: USGS 06752260 daily mean discharge; NASA POWER grid cell at 40.58 N, 105.08 W.") +
  theme_minimal(base_size = 11)
ggsave(sprintf("output/figures/flow_and_temperature_%s.png", data_year), flow_temp_plot,
       width = 7, height = 5, dpi = 200)

# Season summary -----------------------------------------------------------------
daily_summary <- daily |>
  summarise(
    days            = n(),
    mean_flow_cfs   = round(mean(flow_cfs, na.rm = TRUE), 1),
    min_flow_cfs    = round(min(flow_cfs, na.rm = TRUE), 1),
    max_flow_cfs    = round(max(flow_cfs, na.rm = TRUE), 1),
    low_flow_days   = sum(low_flow, na.rm = TRUE),
    heat_days       = sum(heat_day, na.rm = TRUE),
    total_precip_mm = round(sum(precip_mm, na.rm = TRUE), 1),
    total_gdd       = round(sum(gdd, na.rm = TRUE)),
    revised_flow_days = sum(revised, na.rm = TRUE)
  )
write_csv(daily_summary, "output/tables/daily_summary.csv")

# Land cover: ten largest classes ------------------------------------------------
cdl_acres <- read_csv(sprintf("data/raw/cdl_larimer_%s_acres.csv", data_year),
                      show_col_types = FALSE)
cdl_top <- cdl_acres |>
  mutate(share = round(Acreage / sum(Acreage), 3)) |>
  arrange(desc(Acreage)) |>
  slice_head(n = 10) |>
  select(class = Category, acres = Acreage, share)
write_csv(cdl_top, "output/tables/cdl_top_classes.csv")

# ACS: map and margin of error (skipped without the raw file) --------------------
acs_file <- sprintf("data/raw/acs_larimer_tracts_%s.gpkg", data_year)
if (file.exists(acs_file)) {
  acs <- sf::st_read(acs_file, quiet = TRUE)

  acs_map <- ggplot(acs) +
    geom_sf(aes(fill = estimate), color = NA) +
    scale_fill_viridis_c(labels = scales::label_dollar(), na.value = "grey85") +
    labs(fill = "Median household\nincome",
         title = "Median household income by census tract, Larimer County",
         caption = "Source: ACS 2020-2024 five-year estimates, table B19013. Grey: no estimate.") +
    theme_void(base_size = 11)
  ggsave("output/figures/acs_income_tracts.png", acs_map, width = 7, height = 5, dpi = 200)

  acs_uncertainty <- sf::st_drop_geometry(acs) |>
    mutate(relative_moe = moe / estimate) |>
    summarise(
      tracts               = n(),
      missing_estimate     = sum(is.na(estimate)),
      median_relative_moe  = round(median(relative_moe, na.rm = TRUE), 3),
      tracts_moe_above_15p = sum(relative_moe > 0.15, na.rm = TRUE)
    )
  write_csv(acs_uncertainty, "output/tables/acs_uncertainty.csv")
} else {
  message("ACS outputs skipped: ", acs_file, " not found.")
}
