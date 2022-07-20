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

This project archives Billboard charts data.

If you are here looking for historical Billboard Hot 100 data, here are the files of interest:

- [data-out/hot100_archive.csv](data-out/hot100_archive.csv) has data from the chart's inception through the end of "last" year.
- [data-out/hot100_current.csv](data-out/hot100_current.csv) has data to the current week (more or less).

NEW: I'm also working on [data-out/billboard200-current.csv](data-out/hot100_current.csv) but there are clearly some issues with the older data that need to be worked out.

This project has been ... an adventure. Details below.

## Current Hot 100 data

There is a Github Action in place to download the most current chart. As of this writing (April 26, 2020) it runs each day to check for a new chart and commits it if there is a new one. The chart typically releases Tuesday mornings, but I'm still adjusting the best time to scrape.

The data is saved into `data-download/hot100-scraped` based on the chart date.

There is another Github Action that combines "recent" scraped data with saved archive data to update the "current" data file listed above. It scheduled to kick off on Tuesday afternoon.

Github Actions sometimes fail, so results may vary.

## Historical Hot 100 data

Some (but not all) notebooks are stored in the `notebooks/` folder.

Where the data comes from:

- We download this [kaggle](https://www.kaggle.com/dhruvildave/billboard-the-hot-100-songs) data straight from the web page. It is saved as `hot100_kaggle_195808_20211106.csv`. It has charts into November 2021. There are some missing records (at least 13).
- Since kaggle data is stale, some gap data was collected with a Data Miner Chrome plugin and [saved as a Google Sheet](https://docs.google.com/spreadsheets/d/1in--HfDYfijzQha8PSP4ItaKND9_rzx8pFPVHaZi-hE/edit?usp=sharing). It's possible this will replaced in the future.
- Another source of Billboard Hot 100 data is on  [data.world](https://data.world/kcmillersean/billboard-hot-100-1958-2017) and it is used to fill in the data missing from kaggle. It only goes through June 2021 and also has gaps, but not the same gaps as the kaggle data.
- **01-scrape-hot100**: A single scrape notebook using rvest to pull current or specific data. This is a manual thing. For automation, see ...
- **action_hot100_scrape.R** is a script that is set to run on a cron through Github actions. It's more-or-less the same at **01-scrape-hot100** but an R script instead of a notebook. It is set to run daily, but only commits when new data is released, once a week.

How it comes together:

- **notebooks/01-hot100-archive**: Combines different data sources to create the complete archive, saved into the `data-out` folder. This includes a version of the data for Reporting with Data in R, which is purposely mucked up.
- **action_hot100_combine.R** is a script that run on an cron once a week on Tuesday afternoon. It combines the archive data with all the "scraped" data in `data-download/hot100-scraped/`. Those files start in 2022.

### Folder structure

- data-download: Where to download collected data from sources.
- data-out: This is "finished" data
- data-process: Where mid-process data is written.

### Known data errors

- [This comment](https://data.world/kcmillersean/billboard-hot-100-1958-2017/discuss/billboard-hot-100-1958-2017/me2tkmbx#emfy2p2n) on the data.world collection: "Just another heads up for anyone using this dataset. The charts for 1961 contain another error. The Pips "Every Beat Of My Heart" is duplicated twice in some of the weekly charts, except the duplicates are credited to Gladys Knight & The Pips. The original 1961 release was credited to only Pips or The Pips, later re-releases of the song in the 70s reflect the band's change of name." I have confirmed the double entries in this data set and currently online at Billboard, but have not researched the possible reasons why.
- There are a couple of records for "Rainy Night In Georgia/Rubberneckin'" by Brook Benton, which [some think](https://data.world/kcmillersean/billboard-hot-100-1958-2017/discuss/billboard-hot-100-1958-2017/me2tkmbx#kex5mx5n) is a mistake. Elvis' "Rubberneckin'" appears higher in these same weeks. It appears this way currently (2022-06-09) online for [1970-01-10](https://www.billboard.com/charts/hot-100/1970-01-10/) and [1970-01-17](https://www.billboard.com/charts/hot-100/1970-01-17/).

## Billboard 200

> Mothballed but perhaps could come back. Since the data was kinda trash, it would be nice to re-scrape this in R to create a new, more accurate archive.

I've built a Billboard 200 archive through 2020?

-  01-build-archive-billboard200 is a python Jupyter Notebook that downloads the files one year at a time. The resulting files are saved in `data`. 
There are two significant issues to be aware of:
  - The downloaded data had errors dealing with quote escaping (I don't recall exactly). Errors were manually fixed in a text editor as they were discovered.
  - **This process will no longer work because the python package is broken.** It no longer understands previousDate. The original data has been moved to `data-download/py-billboard-200` and the fixed data is in `data-process/billboard200`.
- [02-billboard200-combine](https://utdata.github.io/rwd-billboard-data/02-billboard200-combine.html) is an R notebook used to combine the data. I used this notebook to find problems and then manually cleaned files, which are stored in `data-process/billboard200/`. Combined data is in `data-out/billboard200.csv`.

## Deprecated

I tried to build my own week-by-week archive using the [Billboard Charts](https://github.com/guoguo12/billboard-charts) python package. **The resulting files are problematic. Quoted words within titles and songs are not escaped, breaking csv conventions.**

> January 2022 update: New problems with the python package: Does not include previousDate so loops don't work. So basically this is all crap below.

### Hot 100 Archive

- I tried to pull my own Hot 100 data, but the API quit responding around 1997 and older and there was the quote problem, too.
- 01-build-archive-hot100 is a python Jupyter Notebook that downloads Hot 100 charts from Billboard in an attempt to build my own original data. It stopped working on older years and had other isseus, so I now use the data from 01-hott100-clean instead.

### Requirements for the Python bits

- [Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/) or maybe [Jupyter](https://jupyter.org/documentation).
- [Billboard Charts](https://github.com/guoguo12/billboard-charts)
- [Pandas](https://pandas.pydata.org/)
