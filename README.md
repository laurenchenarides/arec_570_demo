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
2. Browse the APIs economists use: [docs/api-catalog.md](docs/api-catalog.md)
3. Open `arec_570_demo.Rproj` in RStudio and run `api_examples.R`.

The Census example needs a free key from
<https://api.census.gov/data/key_signup.html>. Store it with
`usethis::edit_r_environ()` as `CENSUS_API_KEY=your_key`, then restart R.
