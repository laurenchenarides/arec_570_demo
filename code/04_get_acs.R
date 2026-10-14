# 04_get_acs.R
# ACS 2020-2024 five-year median household income by census tract, Larimer County.
# Inputs:  none (API); requires CENSUS_API_KEY in your user .Renviron
# Outputs: data/raw/acs_larimer_tracts_2024.gpkg  estimate, margin of error, tract geometry

library(tidycensus)

acs_file <- sprintf("data/raw/acs_larimer_tracts_%s.gpkg", data_year)

has_key <- nzchar(Sys.getenv("CENSUS_API_KEY"))
if (!has_key && !file.exists(acs_file)) {
  warning("Skipping ACS: set CENSUS_API_KEY with usethis::edit_r_environ(), then restart R.")
}

if (has_key && (refresh || !file.exists(acs_file))) {
  larimer_income <- get_acs(
    geography = "tract",
    variables = c(median_income = "B19013_001"),
    state = substr(county_fips, 1, 2),
    county = substr(county_fips, 3, 5),
    year = data_year,
    survey = "acs5",
    geometry = TRUE,
    key = Sys.getenv("CENSUS_API_KEY")
  )
  sf::st_write(larimer_income, acs_file, delete_dsn = TRUE, quiet = TRUE)

  log_retrieval(
    source  = "Census ACS 5-year, table B19013",
    request = sprintf("get_acs(geography = 'tract', variables = 'B19013_001', county = '%s', year = %s, survey = 'acs5')",
                      county_fips, data_year),
    file    = acs_file,
    rows    = nrow(larimer_income),
    package = "tidycensus"
  )
}
