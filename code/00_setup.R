# 00_setup.R
# Packages, study-area settings, folders, and the retrieval log.
# Every other script assumes this file has been run (run_all.R does this).

if (!file.exists("arec_570_demo.Rproj")) {
  stop("Run from the project root: open arec_570_demo.Rproj in RStudio.")
}

library(dplyr)
library(readr)
library(ggplot2)

# Study area and period ---------------------------------------------------------
# Identifiers are text so leading zeros survive.
county_fips   <- "08069"             # Larimer County, Colorado
gauge_id      <- "USGS-06752260"     # Cache la Poudre River at Fort Collins
weather_point <- c(-105.08, 40.58)   # longitude, latitude near Fort Collins
season        <- c("2024-04-01", "2024-09-30")
data_year     <- 2024

# Re-download only when asked. Otherwise the scripts reuse the raw files on disk,
# so a rerun reproduces the archived data rather than whatever the API returns today.
if (!exists("refresh")) refresh <- FALSE

# Folders -----------------------------------------------------------------------
for (d in c("data/raw", "data/derived", "output/figures", "output/tables")) {
  dir.create(d, recursive = TRUE, showWarnings = FALSE)
}

# Retrieval log -----------------------------------------------------------------
# One row per API request. The log is tracked by Git; the raw files are not.
log_retrieval <- function(source, request, file, rows, package) {
  entry <- data.frame(
    retrieved = format(Sys.time(), "%Y-%m-%d %H:%M %Z"),
    source    = source,
    request   = request,
    file      = file,
    rows      = rows,
    package   = paste(package, packageVersion(package)),
    r_version = paste(R.version$major, R.version$minor, sep = ".")
  )
  log_file <- "data/retrieval_log.csv"
  write_csv(entry, log_file, append = file.exists(log_file))
}
