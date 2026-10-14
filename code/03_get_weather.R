# 03_get_weather.R
# Daily temperature and precipitation near Fort Collins from NASA POWER.
# Inputs:  none (API)
# Outputs: data/raw/power_fort_collins_2024.csv  one row per day for one grid cell

library(nasapower)

weather_file <- sprintf("data/raw/power_fort_collins_%s.csv", data_year)

if (refresh || !file.exists(weather_file)) {
  weather <- get_power(
    community = "AG",
    lonlat = weather_point,
    pars = c("T2M_MAX", "T2M_MIN", "PRECTOTCORR"),
    temporal_api = "daily",
    dates = season
  )
  write_csv(weather, weather_file)

  log_retrieval(
    source  = "NASA POWER, daily, AG community",
    request = sprintf("get_power(lonlat = c(%s, %s), pars = T2M_MAX, T2M_MIN, PRECTOTCORR, %s to %s)",
                      weather_point[1], weather_point[2], season[1], season[2]),
    file    = weather_file,
    rows    = nrow(weather),
    package = "nasapower"
  )
}
