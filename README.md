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

- [hot100_archive.csv](data-out/hot100_archive.csv) has data from the chart's inception through the end of "last" year.
- Some day I'll have "current" data.

This project has been ... an adventure. Details below.

## The Hot 100 Update

All Notebooks (Python or R) are stored in the `notebooks/` folder.

Where the data comes from:

- We download this [kaggle](https://www.kaggle.com/dhruvildave/billboard-the-hot-100-songs) data straight from the web page. It is saved as `hot100_kaggle_195808_20211106.csv`. It has charts into November 2021. There are some missing records (at least 13).
- Since kaggle data is stale, some gap data was collected with a Data Miner Chrome plugin and [saved as a Google Sheet](https://docs.google.com/spreadsheets/d/1in--HfDYfijzQha8PSP4ItaKND9_rzx8pFPVHaZi-hE/edit?usp=sharing). It's possible this will replaced in the future.
- Another source of Billboard Hot 100 data is on  [data.world](https://data.world/kcmillersean/billboard-hot-100-1958-2017) and it is used to fill in the missing data. It only goes through June 2021 and also has gaps, but not the same gaps as the kaggle data.
- **notebooks/01-scrape-hot100**: A single scrape notebook using rvest to pull current or specific data.
- To Come: A cron scrape notebook to use github actions to pull future charts.

How it comes together:

- **notebooks/01-hot100-archive**: Combines different data sources to create the complete archive.

New folder structure:

- data-download: Where to download collected data from sources.
- data-out: This is "finished" data
- data-process: Where mid-process data is written.

## Billboard 200

> Mothballed but perhaps could come back

I've built a Billboard 200 archive through 2020?

-  01-build-archive-billboard200 is a python Jupyter Notebook that downloads the files one year at a time. The resulting files are saved in `data`. **This will no longer work because the python package is broken. It no longer understands previousDate.**
  - The resulting data has been moved to `data-download/py-billboard-200`.
- [02-billboard200-combine](https://utdata.github.io/rwd-billboard-data/02-billboard200-combine.html) is an R notebook used to combine the data. I used this notebook to find problems and then manually cleaned files, which are stored in `data-process/billboard200/`. Combined data is in `data-out/billboard200.csv`.

At some point I should use R to scrape the gap data, and then enhance to continue scraping through Github actions?

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
