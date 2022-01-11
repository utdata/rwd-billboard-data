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

This project deals with Billboard charts data in various ways.

## Notebooks

- [01-hot100-clean](https://utdata.github.io/rwd-billboard-data/01-hot100-clean.html) downloads Hot 100 data from data.world and cleans it for use in assignments. As of 2022-01-10 this data hasn't been updated since June 2021 so it may be deprecated.
- `01-hot100-dataminer` downloads some manually scraped data to support this next notebook ...
- [02-hot100-kaggle](https://utdata.github.io/rwd-billboard-data/02-hot100-kaggle.html) is an R notebook that uses data downloaded from Kaggle: [Billboard "The Hot 100" Songs](https://www.kaggle.com/dhruvildave/billboard-the-hot-100-songs). As of 2022-01-10 it was only updated through 2021-11-08 so I manually scraped the last six weeks and append it here. **This makes the data current through 2021**. See notebook for more details.

## Deprecated

I tried to build my own week-by-week archive using the [Billboard Charts](https://github.com/guoguo12/billboard-charts) python package. **The resulting files are problematic. Quoted words within titles and songs are not escaped, breaking csv conventions.**

> January 2022 update: New problems with the python package: Does not include previousDate so loops don't work. So basically this is all crap below.

### Hot 100 Archive

- I tried to pull my own Hot 100 data, but the API quit responding around 1997 and older and there was the quote problem, too.
- 01-build-archive-hot100 is a python Jupyter Notebook that downloads Hot 100 charts from Billboard in an attempt to build my own original data. It stopped working on older years and had other isseus, so I now use the data from 01-hott100-clean instead.

### Billbaord 200 Archive

- I tried to build a Billboard 200 archive. 01-build-archive-billboard200 is a python Jupyter Notebook that downloads the files one year at a time. The resulting files are saved in `data`. **I doubt this will work anymore because of the previousDate problem.**
- [02-billboard200-combine](https://utdata.github.io/rwd-billboard-data/02-billboard200-combine.html) is an R notebook used to combine the data. I used this notebook to find problems and then manually cleaned files, which are stored in `data-clean`. Combined data is in `data-out`.

### Requirements for the Python bits

- [Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/) or maybe [Jupyter](https://jupyter.org/documentation).
- [Billboard Charts](https://github.com/guoguo12/billboard-charts)
- [Pandas](https://pandas.pydata.org/)



