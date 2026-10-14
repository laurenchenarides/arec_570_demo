# run_all.R
# Reproduce the project from start to finish. Run from the project root:
#   source("run_all.R")
#
# Set refresh <- TRUE to download every source again. Otherwise each script
# reuses the raw file already in data/raw/.

refresh <- FALSE

source("code/00_setup.R")
source("code/01_get_cdl.R")
source("code/02_get_streamflow.R")
source("code/03_get_weather.R")
source("code/04_get_acs.R")

sessionInfo()
