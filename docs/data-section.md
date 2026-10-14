# Draft data section

Companion to Lecture 5.5. Every number below comes from a file in this
repository (`output/tables/`, `data/retrieval_log.csv`), so the text can be
checked against the code that produced it.

---

## Data

**Sources.** We combine four public sources retrieved through their
application programming interfaces in October 2026 (`data/retrieval_log.csv`
records each request, date, and package version). Daily streamflow comes from
the U.S. Geological Survey Water Data API for monitoring location 06752260,
the Cache la Poudre River at Fort Collins, Colorado (parameter 00060, daily
mean discharge). Daily maximum and minimum temperature and precipitation come
from NASA's Prediction Of Worldwide Energy Resources (POWER) service, which
reports MERRA-2 reanalysis values for a grid cell of about 0.5° × 0.625°
containing Fort Collins. Land cover comes from the USDA National Agricultural
Statistics Service 2024 Cropland Data Layer (CDL) for Larimer County. Tract
median household income comes from the American Community Survey 2020-2024
five-year estimates (table B19013).

**Unit of observation and sample.** The analysis file has one row per day
from April 1 to September 30, 2024, and the date is the key. Both the streamflow
and the weather series return all 183 days; a one-to-one join on date retains
all 183, with no missing values (Table 1). The streamflow series describes one
point on the river. The weather series describes a grid cell, and the same
values apply to every location within it.

*Table 1. Sample construction*

| Step | Days |
|---|---:|
| Streamflow days returned (daily mean) | 183 |
| Weather days returned | 183 |
| Days in either source (full join) | 183 |
| Days in both sources | 183 |
| Days with no missing flow or weather values | 183 |

*Source: `output/tables/sample_construction.csv`.*

**Variables.** We define a heat day as a maximum temperature of at least
35 °C, a low-flow day as mean discharge below 20 cubic feet per second
(roughly the 20th percentile of the season), and growing degree days with a
base of 10 °C and a cap of 30 °C. The season had 21 heat days, 37 low-flow
days, 206.8 mm of precipitation, and 1,747 growing degree days. Mean discharge
was 138.1 cubic feet per second, ranging from 2.1 to 987
(`output/tables/daily_summary.csv`). Definitions and source fields are listed
in `docs/codebook.md`.

**Land cover.** Evergreen forest (34.7 percent), grass and pasture
(28.8 percent), and shrubland (24.4 percent) account for most of the county's
area; corn, the largest cultivated class, covers 0.8 percent
(`output/tables/cdl_top_classes.csv`). CDL classes are modeled from satellite
imagery, and accuracy varies by crop and region.

**Limitations.** First, USGS revised 72 of the 183 daily discharge values
after first publishing them. All values are now approved, and a download made
during the 2024 season would differ from ours. We therefore archive the raw
responses with their retrieval date. Second, the gauge lies downstream of
irrigation diversions, so low flow reflects water use as well as weather.
Third, grid-cell weather averages over variation within the cell. Fourth,
ACS estimates describe a five-year period, carry margins of error, and are
reported for 2020 tract boundaries.

---

## Checklist used for this draft

- [x] Provider, dataset, and retrieval date for every source
- [x] Unit of observation and key
- [x] Sample construction with counts at each step
- [x] Variable definitions, units, and thresholds
- [x] Missing values coded separately from zeros
- [x] Merges: identifiers, expected relationship, unmatched records
- [x] Limitations a reader could not infer from the tables
