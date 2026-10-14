# Data APIs for economic research

Companion to Lecture 5.2. **R** names a maintained package; `httr2` means the
request is written directly against the documented endpoint. **Key**: *No* =
open access; *Yes* = free key from that agency; *api.data.gov* = one shared
key from <https://api.data.gov/signup/>; *Account* = free login.

R packages were checked against CRAN in October 2026. Services change: confirm
the current documentation before relying on an entry.

## Census Bureau

One key from <https://api.census.gov/data/key_signup.html>. Full dataset list:
<https://api.census.gov/data.html>.

| Source | Economists use it for | R | Key |
|---|---|---|---|
| American Community Survey (1- and 5-year) | Income, poverty, housing, commuting by tract or county | `tidycensus` | Yes |
| ACS Public Use Microdata (PUMS) | Person and household records | `tidycensus` | Yes |
| Decennial Census | Population counts and demographics | `tidycensus` | Yes |
| Population Estimates | Annual population, births, deaths, migration | `tidycensus` | Yes |
| SAIPE and SAHIE | County poverty, median income, uninsured rates | `censusapi` | Yes |
| County and ZIP Business Patterns | Establishments, employment, payroll by industry | `censusapi` | Yes |
| Nonemployer Statistics | Self-employment and small businesses by industry | `censusapi` | Yes |
| Economic Census; Annual Business Survey | Sales, ownership, firm characteristics | `censusapi` | Yes |
| Quarterly Workforce Indicators (LEHD) | Hires, separations, earnings by worker group | `censusapi` | Yes |
| LEHD Origin-Destination (LODES) | Where people live and work, by block | `lehdr` | No |
| International Trade | Monthly imports and exports by product and partner | `censusapi` | Yes |
| Economic Indicators | Retail sales, housing starts, manufacturing | `censusapi` | Yes |
| TIGER/Line boundaries | Tract, county, ZCTA geometry | `tigris` | No |
| Census Geocoder | Assign addresses to tracts and blocks | `tidygeocoder` | No |

## Other federal statistical agencies

| Source | Economists use it for | R | Key | Docs |
|---|---|---|---|---|
| Bureau of Labor Statistics | CPI, PPI, employment, wages (QCEW, LAUS, OEWS) | `blsR` | Yes | <https://www.bls.gov/developers/> |
| Bureau of Economic Analysis | GDP and personal income by state and county; input-output | `bea.R` | Yes | <https://apps.bea.gov/api/> |
| FRED and ALFRED | Macro and regional series, including past vintages | `fredr` | Yes | <https://fred.stlouisfed.org/docs/api/fred/> |
| IPUMS | Harmonized Census, ACS, CPS, ATUS microdata; NHGIS tables | `ipumsr` | Yes | <https://developer.ipums.org/> |
| HUD User | USPS ZIP crosswalks, Fair Market Rents | `httr2` | Yes | <https://www.huduser.gov/portal/dataset/api.html> |
| Energy Information Administration | Energy prices, production, consumption | `eia` | Yes | <https://www.eia.gov/opendata/> |
| CFPB HMDA | Mortgage applications and lending | `httr2` | No | <https://ffiec.cfpb.gov/> |
| USAspending | Federal grants, contracts, payments by place | `httr2` | No | <https://api.usaspending.gov/> |
| Treasury Fiscal Data | Federal debt, receipts, interest rates | `httr2` | No | <https://fiscaldata.treasury.gov/api-documentation/> |
| FDIC BankFind | Bank branches and financial reports | `httr2` | No | <https://banks.data.fdic.gov/docs/> |

## USDA

| Source | Economists use it for | R | Key | Docs |
|---|---|---|---|---|
| NASS Quick Stats | Acreage, yields, prices, inventories; Census of Agriculture | `rnassqs` | Yes | <https://quickstats.nass.usda.gov/api> |
| NASS Cropland Data Layer | Annual 30 m crop and land-cover map | `CropScapeR` | No | <https://nassgeodata.gmu.edu/CropScape/devhelp/cropscapews.html> |
| AMS Market News (MyMarketNews) | Cash grain, livestock, dairy, specialty crop prices | `httr2` | Yes | <https://mymarketnews.ams.usda.gov/> |
| FAS Open Data | Global supply and use (PSD), trade (GATS), export sales | `httr2` | Varies | <https://apps.fas.usda.gov/opendataweb/home> |
| ERS ARMS | Farm finances, costs of production, practices | `httr2` | api.data.gov | <https://www.ers.usda.gov/developer/data-apis> |
| FoodData Central | Nutrient composition of foods | `httr2` | api.data.gov | <https://fdc.nal.usda.gov/> |
| NRCS Soil Data Access | Soil properties and productivity (SSURGO) | `soilDB` | No | <https://sdmdataaccess.nrcs.usda.gov/> |
| NRCS Air and Water Database | Snowpack and soil moisture (SNOTEL, SCAN) | `soilDB` | No | <https://wcc.sc.egov.usda.gov/awdbRestApi/swagger-ui/index.html> |
| Forest Inventory and Analysis | Forest area, volume, growth, removals | `rFIA` | No | <https://research.fs.usda.gov/programs/fia> |

Older community packages: `rarms` (ARMS) and `usdampr` (AMS mandatory price
reporting) have not been updated in several years. ERS publishes R snippets for
the ARMS API.

## Environment and natural resources

| Source | Economists use it for | R | Key | Docs |
|---|---|---|---|---|
| USGS Water Data | Streamflow and groundwater levels | `dataRetrieval` | No | <https://api.waterdata.usgs.gov/> |
| Water Quality Portal | Samples from federal, state, tribal monitoring | `dataRetrieval` | No | <https://www.waterqualitydata.us/> |
| U.S. Drought Monitor | Weekly drought categories by county | `httr2` | No | <https://droughtmonitor.unl.edu/DmData/DataDownload/WebServiceInfo.aspx> |
| OpenFEMA | Disaster declarations, flood insurance claims, assistance | `httr2` | No | <https://www.fema.gov/about/openfema/api> |
| NOAA NCEI | Daily station weather (GHCN-Daily) | `httr2` | No | <https://www.ncei.noaa.gov/access/search/documentation/data-service/> |
| PRISM | Gridded U.S. temperature and precipitation | `prism` | No | <https://prism.oregonstate.edu/> |
| gridMET and Daymet | Daily gridded weather for exposure measures | `climateR` (GitHub), `daymetr` | No | <https://www.climatologylab.org/gridmet.html> |
| NASA POWER | Global daily weather and solar radiation | `nasapower` | No | <https://power.larc.nasa.gov/docs/services/api/> |
| NASA Earthdata | MODIS and Landsat: vegetation, land cover, fire | `earthdatalogin`, `rstac` | Account | <https://www.earthdata.nasa.gov/> |
| Google Earth Engine | Processing large satellite archives | `rgee` | Account | <https://earthengine.google.com/> |
| EPA Air Quality System | Monitor-level air pollution | `RAQSAPI` | Yes | <https://aqs.epa.gov/aqsweb/documents/data_api.html> |
| EPA ECHO | Facility permits, inspections, enforcement | `echor` | No | <https://echo.epa.gov/tools/web-services> |
| EPA Envirofacts | Toxic releases (TRI), greenhouse gas reporting | `httr2` | No | <https://www.epa.gov/enviro/envirofacts-data-service-api> |
| NREL developer APIs | Solar resource, utility rates, fueling stations | `httr2` | api.data.gov | <https://developer.nrel.gov/> |

## International

| Source | Economists use it for | R | Key |
|---|---|---|---|
| World Bank Indicators | Development indicators by country and year | `WDI` | No |
| FAOSTAT | Agricultural production, trade, prices, land use | `FAOSTAT` | Varies |
| UN Comtrade | Bilateral trade by product | `comtradr` | Yes |
| OECD Data Explorer | Country statistics, including agricultural support | `rsdmx` | No |
| IMF | Financial statistics and commodity prices | `imf.data` | No |
| Eurostat | EU regional and sectoral statistics | `eurostat` | No |
| ILOSTAT | Employment and wages across countries | `Rilostat` | No |

## No API: bulk download or license

- RMA Summary of Business: crop insurance by county and crop
- IRS Statistics of Income: income by ZIP code; county-to-county migration
- ERS data products such as the Food Environment Atlas
- State agencies: water rights, land records, licensing
- Commercial scanner and point-of-sale data, under license

A download script should still record the URL, the file, and the download date.

## Services that changed recently

- NOAA moved station data from the Climate Data Online API to the NCEI data
  service; the `rnoaa` package was removed from CRAN in 2024.
- EPA removed EJScreen and its map services in February 2025. Reconstructions
  are hosted outside EPA.
- USGS plans to retire the services behind `dataRetrieval`'s `readNWIS`
  functions in 2027. Use the `read_waterdata_*` functions.

Save raw responses and retrieval dates. A script alone may not reproduce the
data next year.
