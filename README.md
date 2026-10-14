# AREC 570 data workflow demo

A small research project built in stages across Unit 5 of AREC 570 / ECON 530,
*Methodology of Economic Research*, at Colorado State University. It retrieves
land-use, streamflow, weather, and census data for Larimer County, Colorado,
through public APIs.

## Follow along

Each lecture adds one layer. A tag marks the project as it stood after each
class. Open a tag from the branch menu on GitHub, or compare two stages, for
example
<https://github.com/laurenchenarides/arec_570_demo/compare/5.2-retrieve...5.3-structure>.

| Tag | Lecture | What changes |
|---|---|---|
| `5.2-retrieve` | Data collection via APIs | One script retrieves four datasets |
| `5.3-structure` | Project structure and version control | Folders, numbered scripts, `run_all.R`, `.gitignore`, retrieval log |
| `5.4-collaborate` | Collaborating on GitHub | Issue, branch, pull request; joins with key checks |
| `5.5-report` | Reporting data | Codebook, sample construction, draft data section |

## Getting started

1. Set up Git and GitHub in RStudio: [docs/setup-rstudio.md](docs/setup-rstudio.md)
2. Learn the everyday Git loop: [docs/git-in-rstudio.md](docs/git-in-rstudio.md)
   (VS Code users: [docs/vscode.md](docs/vscode.md))
3. Work with others through issues, branches, and pull requests:
   [docs/collaboration.md](docs/collaboration.md)
4. Browse the APIs economists use: [docs/api-catalog.md](docs/api-catalog.md),
   and draft your own [data plan](docs/data-plan.md)
5. Report the data: [docs/codebook.md](docs/codebook.md) and a draft data
   section built from this project's outputs, [docs/data-section.md](docs/data-section.md)

## Reproduce the project

1. Install R packages once:

   ```r
   install.packages(c("CropScapeR", "dataRetrieval", "nasapower", "tidycensus",
                      "ggplot2", "dplyr", "readr", "sf"))
   ```

2. Get a free Census key at <https://api.census.gov/data/key_signup.html>.
   Run `usethis::edit_r_environ()`, add the line `CENSUS_API_KEY=your_key`,
   save, and restart R. Without a key, the ACS step is skipped.
3. Open `arec_570_demo.Rproj` in RStudio and run `source("run_all.R")`.

The first run downloads every source into `data/raw/`. Later runs reuse those
files; set `refresh <- TRUE` in `run_all.R` to download again. Each download is
recorded in `data/retrieval_log.csv`.

## Project structure

```text
arec_570_demo/
├── README.md              start here
├── arec_570_demo.Rproj    opens the project with the right working directory
├── run_all.R              runs every script in order
├── code/                  numbered scripts; see code/README.md
│   ├── 00_setup.R         settings and folders
│   ├── functions.R        log_retrieval(), check_key()
│   ├── 01_get_cdl.R       retrieve
│   ├── 02_get_streamflow.R
│   ├── 03_get_weather.R
│   ├── 04_get_acs.R
│   ├── 05_build_daily.R   join by date, check keys, build measures
│   └── 06_outputs.R       figures and tables
├── data/                  see data/README.md
│   ├── raw/               API responses as returned (excluded from Git)
│   ├── derived/           files built by code (excluded from Git)
│   └── retrieval_log.csv  what was downloaded, when, and how
├── output/
│   ├── figures/
│   └── tables/
├── docs/                  guides and the API catalog
├── .github/               issue template for research tasks
└── lab_diary.md           dated notes on what was tried and why
```

Principles, following Gentzkow and Shapiro, *Code and Data for the Social
Sciences*:

- Raw data are read-only. Everything else is rebuilt by code.
- One script, `run_all.R`, reproduces the project from start to finish.
- Paths are relative to the project root, so the project runs on any computer.
- Numbers show the order of scripts; each folder's README lists inputs and outputs.
- Git tracks code, documentation, and the retrieval log. `.gitignore` excludes credentials and data.

## Data sources

| Source | Provider | Access | Retrieved |
|---|---|---|---|
| Cropland Data Layer, 2024 | USDA National Agricultural Statistics Service | CropScape API via `CropScapeR` | see `data/retrieval_log.csv` |
| Daily discharge, site 06752260 | U.S. Geological Survey | Water Data API via `dataRetrieval` | see log |
| Daily weather, AG community | NASA POWER | POWER API via `nasapower` | see log |
| ACS 2020-2024 five-year, table B19013 | U.S. Census Bureau | Census API via `tidycensus` (key required) | see log |

All four sources are public. `run_all.R` rebuilds the analysis files from
them, so the repository holds code and documentation only.
