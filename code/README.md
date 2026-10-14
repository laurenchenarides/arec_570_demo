# code/

Run every script through `run_all.R` from the project root. Numbers give the
order; each script reads only files written by earlier scripts.

| Script | Purpose | Inputs | Outputs |
|---|---|---|---|
| `00_setup.R` | Packages, study-area settings, folders, `log_retrieval()` | none | folders |
| `01_get_cdl.R` | Cropland Data Layer, Larimer County | CropScape API | `data/raw/cdl_larimer_2024.tif`, `data/raw/cdl_larimer_2024_acres.csv` |
| `02_get_streamflow.R` | Daily discharge, Poudre River at Fort Collins | USGS Water Data API | `data/raw/usgs_poudre_flow_2024.csv` |
| `03_get_weather.R` | Daily temperature and precipitation | NASA POWER API | `data/raw/power_fort_collins_2024.csv` |
| `04_get_acs.R` | Median household income by tract | Census API (key) | `data/raw/acs_larimer_tracts_2024.gpkg` |

Each retrieval script appends a row to `data/retrieval_log.csv`.
