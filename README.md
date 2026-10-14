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
4. Browse the APIs economists use: [docs/api-catalog.md](docs/api-catalog.md)

## Reproduce the project

1. Install R packages once:

   ```r
   install.packages(c("CropScapeR", "dataRetrieval", "nasapower", "tidycensus",
                      "dplyr", "readr", "ggplot2", "sf", "terra"))
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
│   ├── raw/               API responses, never edited (not in Git)
│   ├── derived/           built by code (not in Git)
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
- Credentials and data stay out of Git; the retrieval log and code stay in.
