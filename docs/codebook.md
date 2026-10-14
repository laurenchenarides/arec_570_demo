# Codebook: `data/derived/daily_flow_weather_2024.csv`

**Unit of observation:** one calendar day, April 1 to September 30, 2024.
**Key:** `date` (unique, no missing values; checked by `check_key()`).
**Rows:** 183. Built by `code/05_build_daily.R`.

| Variable | Type | Units | Definition | Source field |
|---|---|---|---|---|
| `date` | date | YYYY-MM-DD | Calendar day (local time) | USGS `time`; POWER `YYYYMMDD` |
| `flow_cfs` | numeric | ft³/s | Daily mean discharge, Cache la Poudre River at Fort Collins (USGS 06752260) | USGS `value`, parameter 00060, statistic 00003 |
| `approval` | text | | USGS review status: Approved or Provisional | USGS `approval_status` |
| `revised` | logical | | TRUE if USGS revised the value after first publication | USGS `qualifier` = REVISED |
| `tmax_c` | numeric | °C | Maximum air temperature at 2 m, grid cell containing 40.58 N, 105.08 W | POWER `T2M_MAX` |
| `tmin_c` | numeric | °C | Minimum air temperature at 2 m, same grid cell | POWER `T2M_MIN` |
| `precip_mm` | numeric | mm/day | Bias-corrected precipitation, same grid cell | POWER `PRECTOTCORR` |
| `heat_day` | logical | | `tmax_c` ≥ 35 | constructed |
| `low_flow` | logical | | `flow_cfs` < 20 | constructed |
| `gdd` | numeric | °C-days | Growing degree days: (min(`tmax_c`, 30) + max(`tmin_c`, 10)) / 2 − 10, floored at 0 | constructed |

**Missing values:** none in 2024. A missing `flow_cfs` would mean USGS
reported no daily value (for example, ice or equipment failure), not zero
flow. Missing values are left as `NA`, never replaced with 0.

**Thresholds** are set at the top of `05_build_daily.R` and are illustrative.

# Codebook: `data/raw/acs_larimer_tracts_2024.gpkg`

**Unit:** census tract (2020 boundaries), Larimer County, for the five-year
period 2020–2024. **Key:** `GEOID` (11-character text: state, county, tract).

| Variable | Definition |
|---|---|
| `GEOID` | Tract identifier; keep as text to preserve leading zeros |
| `NAME` | Tract name |
| `variable` | `median_income` (table B19013_001) |
| `estimate` | Median household income, 2024 inflation-adjusted dollars |
| `moe` | Margin of error, 90 percent confidence |
| geometry column | Tract boundary polygon |

# Codebook: `data/raw/cdl_larimer_2024_acres.csv`

**Unit:** land-cover class within Larimer County, 2024. **Key:** `Value`.

| Variable | Definition |
|---|---|
| `Value` | CDL class code |
| `Category` | Class name |
| `Acreage` | Acres classified as this class (30 m pixels × 0.2224 acres) |
