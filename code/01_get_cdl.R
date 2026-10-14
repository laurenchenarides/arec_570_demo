# 01_get_cdl.R
# USDA NASS Cropland Data Layer for Larimer County through the CropScape service.
# Inputs:  none (API)
# Outputs: data/raw/cdl_larimer_2024.tif        30 m land-cover raster
#          data/raw/cdl_larimer_2024_acres.csv  acreage by land-cover class

library(CropScapeR)

raster_file  <- sprintf("data/raw/cdl_larimer_%s.tif", data_year)
acres_file   <- sprintf("data/raw/cdl_larimer_%s_acres.csv", data_year)

if (refresh || !file.exists(acres_file)) {
  GetCDLData(aoi = county_fips, year = data_year, type = "f", save_path = raster_file)

  cdl_acres <- GetCDLStat(aoi = county_fips, year = data_year, type = "f")
  write_csv(cdl_acres, acres_file)

  log_retrieval(
    source  = "USDA NASS Cropland Data Layer (CropScape)",
    request = sprintf("GetCDLStat(aoi = '%s', year = %s, type = 'f')", county_fips, data_year),
    file    = acres_file,
    rows    = nrow(cdl_acres),
    package = "CropScapeR"
  )
}
