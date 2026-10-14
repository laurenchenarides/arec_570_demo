# data/

| Folder or file | Contents | In Git? |
|---|---|---|
| `raw/` | Files exactly as returned by each API. Never edited by hand. | No |
| `derived/` | Files built from `raw/` by code. Delete and rerun to rebuild. | No |
| `retrieval_log.csv` | One row per API request: date, request, file, rows, package version | Yes |

Raw and derived data are excluded by `.gitignore`. The land-cover raster alone
is about 10 MB, and many research datasets are confidential or licensed.
`run_all.R` recreates both folders from the APIs.

APIs change, so keep a dated copy of `raw/` outside Git: a lab drive, or a
public archive such as Zenodo or ICPSR when the license allows.

## Sources

| File | Source | Unit of observation |
|---|---|---|
| `cdl_larimer_2024.tif` | USDA NASS Cropland Data Layer, 2024 | 30 m raster cell |
| `cdl_larimer_2024_acres.csv` | CropScape statistics for the same layer | Land-cover class in the county |
| `usgs_poudre_flow_2024.csv` | USGS monitoring location 06752260, parameter 00060 | Gauge-day |
| `power_fort_collins_2024.csv` | NASA POWER, AG community, MERRA-2 | Grid cell-day |
| `acs_larimer_tracts_2024.gpkg` | ACS 2020-2024 five-year, table B19013 | Census tract (five-year period) |
