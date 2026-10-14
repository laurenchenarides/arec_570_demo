# 02_get_streamflow.R
# Daily mean discharge for the Cache la Poudre River at Fort Collins, USGS Water Data API.
# Inputs:  none (API)
# Outputs: data/raw/usgs_poudre_flow_2024.csv  one row per day

library(dataRetrieval)

flow_file <- sprintf("data/raw/usgs_poudre_flow_%s.csv", data_year)

if (refresh || !file.exists(flow_file)) {
  poudre_flow <- read_waterdata_daily(
    monitoring_location_id = gauge_id,
    parameter_code = "00060",            # discharge, cubic feet per second
    time = season
  )
  write_csv(sf::st_drop_geometry(poudre_flow), flow_file)

  log_retrieval(
    source  = "USGS Water Data API, daily values",
    request = sprintf("read_waterdata_daily('%s', parameter_code = '00060', time = %s to %s)",
                      gauge_id, season[1], season[2]),
    file    = flow_file,
    rows    = nrow(poudre_flow),
    package = "dataRetrieval"
  )
}
