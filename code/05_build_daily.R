# 05_build_daily.R
# Combine streamflow (gauge-day) and weather (grid cell-day) into one daily table.
# Inputs:  data/raw/usgs_poudre_flow_2024.csv
#          data/raw/power_fort_collins_2024.csv
# Outputs: data/derived/daily_flow_weather_2024.csv   key: date
#          output/tables/sample_construction.csv

# Thresholds are illustrative choices for this demo; document yours.
heat_threshold_c <- 35   # daily maximum temperature, degrees C (95 F)
low_flow_cfs     <- 20   # daily mean discharge, cubic feet per second
gdd_base_c       <- 10   # growing degree days: base and cap, degrees C
gdd_cap_c        <- 30

# Read: codes stay text so "00060" does not become 60 ---------------------------
flow_raw <- read_csv(
  sprintf("data/raw/usgs_poudre_flow_%s.csv", data_year),
  col_types = cols(parameter_code = col_character(), statistic_id = col_character())
)
weather_raw <- read_csv(sprintf("data/raw/power_fort_collins_%s.csv", data_year),
                        show_col_types = FALSE)

# One row per day in each source ------------------------------------------------
flow <- flow_raw |>
  filter(statistic_id == "00003") |>                # daily mean
  transmute(
    date      = as.Date(time),
    flow_cfs  = value,
    approval  = approval_status,
    revised   = qualifier %in% "REVISED"
  )

weather <- weather_raw |>
  transmute(
    date      = as.Date(YYYYMMDD),
    tmax_c    = T2M_MAX,
    tmin_c    = T2M_MIN,
    precip_mm = PRECTOTCORR
  )

check_key(flow, "date")
check_key(weather, "date")

# Join: expect one-to-one on date ----------------------------------------------
daily <- full_join(flow, weather, by = "date", relationship = "one-to-one") |>
  arrange(date) |>
  mutate(
    heat_day = tmax_c >= heat_threshold_c,
    low_flow = flow_cfs < low_flow_cfs,
    gdd      = pmax(0, (pmin(tmax_c, gdd_cap_c) + pmax(tmin_c, gdd_base_c)) / 2 - gdd_base_c)
  )

check_key(daily, "date")
write_csv(daily, sprintf("data/derived/daily_flow_weather_%s.csv", data_year))

# Sample construction: report every step -----------------------------------------
complete_days <- daily |> filter(!is.na(flow_cfs), !is.na(tmax_c), !is.na(tmin_c), !is.na(precip_mm))

sample_construction <- tibble::tribble(
  ~step,                                          ~days,
  "Streamflow days returned (daily mean)",         nrow(flow),
  "Weather days returned",                         nrow(weather),
  "Days in either source (full join)",             nrow(daily),
  "Days in both sources",                          nrow(inner_join(flow, weather, by = "date")),
  "Days with no missing flow or weather values",   nrow(complete_days)
)
write_csv(sample_construction, "output/tables/sample_construction.csv")
print(sample_construction)
