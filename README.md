---
output:
  html_document:
    df_print: paged
knit: (function(inputFile, encoding) { rmarkdown::render(
    inputFile,
    encoding = encoding,
    output_dir = "docs",
    output_file='index.html'
  ) })
---

# rwd-billboard-data

> **July 23 2020 UPDATE**: the project was refactored to process both the Hot 100 and Billboard 200 charts. There could be breaking changes: Some obsolete files were removed; the "current" chart files were renamed.

This project archives [Billboard Hot 100](https://www.billboard.com/charts/hot-100/) and [Billboard 200](https://www.billboard.com/charts/billboard-200/) charts data.

If you are here looking for a current archive, here are the files of interest:

- [data-out/hot-100-current.csv](data-out/hot-100-current.csv) has the [Billboard Hot 100](https://www.billboard.com/charts/hot-100/) back to its inception in 1958.
- [data-out/billboard-200-current.csv](data-out/billboard-200-current.csv) is the [Billboard 200](https://www.billboard.com/charts/billboard-200/) from its inception in 1967.

> There are minor data errors in both archives. See details below.

This project has been ... an adventure. Details below.

## Charts scraping and combining

There are two Github Actions that call scripts to scrape a list of charts each week and then combine each chart's files with some processed archives from other sources. I currently collect for the Hot 100 and Billboard 200 charts.

- `.github/workflows/scrap_charts.yml` is a Github Action that is scheduled on a cron to run `action_scrape_charts.R`. That scrapes the current chart and saves it.
- `.github/workflows/combine_charts.yml` is a Github Action that is scheduled on a cron to run `action_combine_charts.R`. This combines scraped charts with any `previous_archives` files, if any.

As of this writing (July 23, 2022) they run each Tuesday and Wednesday. (Wednesday allows for holiday delays or other errors.)

### Exploration and maintenance

There are some RMarkdown notebooks used to explore and maintain those scripts: `01-scrape-charts.Rmd`, `02-combine-charts.Rmd` and `03-check-charts.Rmd`. There are some details recorded there that can help explain what is happening in the scrap/combine charts scripts.

## Hot 100

### 2022 to current

The Github Action script saves data into `data-scraped/hot-100` based on the chart date. These files cover 2022 and forward.

### Archive from before 2022

Where the data comes from:

- We downloaded this [kaggle](https://www.kaggle.com/dhruvildave/billboard-the-hot-100-songs) data straight from the web page. It is saved as `data-download/hot100_kaggle_195808_20211106.csv`. It has charts into November 2021. There are some missing records (at least 13).
- Since the kaggle data is stale, some gap data was collected with a Data Miner Chrome plugin and [saved as a Google Sheet](https://docs.google.com/spreadsheets/d/1in--HfDYfijzQha8PSP4ItaKND9_rzx8pFPVHaZi-hE/edit?usp=sharing). It's possible this will replaced in the future.
- Another source of Billboard Hot 100 data is on  [data.world](https://data.world/kcmillersean/billboard-hot-100-1958-2017) and it is used to fill in the data missing from kaggle. It only goes through June 2021 and also has gaps, but not the same gaps as the kaggle data.

How it comes together:

- **notebooks/02-hot100-archive**: Combines different data sources to create the complete archive, saved into the `data-out` folder. This includes a version of the data for Reporting with Data in R, which is purposely mucked up.

### Known Hot 100 data errors

TLDR: My data matches what is currently online.

- There are a couple of records for "Rainy Night In Georgia/Rubberneckin'" by Brook Benton, which [some think](https://data.world/kcmillersean/billboard-hot-100-1958-2017/discuss/billboard-hot-100-1958-2017/me2tkmbx#kex5mx5n) is a mistake. Elvis' "Rubberneckin'" appears higher in these same weeks. As of 2022-07-23 the data appears this way online for [1970-01-10](https://www.billboard.com/charts/hot-100/1970-01-10/) and [1970-01-17](https://www.billboard.com/charts/hot-100/1970-01-17/) charts.
- [This comment](https://data.world/kcmillersean/billboard-hot-100-1958-2017/discuss/billboard-hot-100-1958-2017/me2tkmbx#emfy2p2n) on the data.world collection: "Just another heads up for anyone using this dataset. The charts for 1961 contain another error. The Pips "Every Beat Of My Heart" is duplicated twice in some of the weekly charts, except the duplicates are credited to Gladys Knight & The Pips. The original 1961 release was credited to only Pips or The Pips, later re-releases of the song in the 70s reflect the band's change of name." I have confirmed the double entries in this data set and currently online at Billboard, but have not researched the possible reasons why.

## Billboard 200

The chart scraping script also collects the [Billboard 200](https://www.billboard.com/charts/billboard-200/) each week in to `data-scraped/billboard-200` stored by date, and the chart combine script builds a current archive saved as [data-out/billboard-200-current.csv](data-out/billboard-200-current.csv).

The combine script taps a processed archive file for charts pre-2020, explained below.

> The following scripts won't work anymore. It would be nice to build the pre-2020 archive from my own R scrapes, but I haven't done that as yet.

-  01-build-archive-billboard200 is a python Jupyter Notebook that downloads the files one year at a time. The resulting files are saved in `data`. 
There are two significant issues to be aware of:
  - The downloaded data had errors dealing with quote escaping (I don't recall exactly). Errors were manually fixed in a text editor as they were discovered.
  - **This process will no longer work because the python package is broken.** It no longer understands previousDate. The original data has been moved to `data-download/py-billboard-200` and the fixed data is in `data-process/billboard200`.
- [02-billboard200-combine](https://utdata.github.io/rwd-billboard-data/02-billboard200-combine.html) is an R notebook used to combine the data. I used this notebook to find problems and then manually cleaned files, which are stored in `data-process/billboard200/`. Combined data is in `data-out/billboard200.csv`.

### Known Billboard 200 data errors

- The first five weeks in the history have only 175 rows but that matches what is online. This is not really an error, but of note.
- There are **only 191 records for 1967-09-16 and that is incorrect**. The chart is correct online, but I haven't decided how to fix my archive yet.

