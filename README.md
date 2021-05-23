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

This project fetches Billboard charts data using the [Billboard Charts](https://github.com/guoguo12/billboard-charts) python package. **The resulting files are problematic. Quoted words within titles and songs are not escaped, breaking the csv conventions.**

- I tried to pull my own Hot 100 data, but the API quit responding around 1997 and older and there was the quote problem, too.
- When the above failed, I downloaded from data.world and did come cleaning.
- I did pull the Billboard 200 data through the API as far back as possible, but then manually cleaned the quotes while building the R notebook `02-billboard-combine.Rmd`. There is a clean version of the combined files in `data-process`.

## Notebooks

- 01-build-archive-billboard200 is a python Jupyter Notebook that downloads the files one year at a time. The resulting files are saved in `data`.
- [02-billboard200-combine](https://utdata.github.io/rwd-billboard-data/02-billboard200-combine.html) is an R notebook used to combine the data. I used this notebook to find problems and then manually clean files, which are stored in `data-clean`. Combined data is in `data-out`.
- [01-hot100-clean](https://utdata.github.io/rwd-billboard-data/01-hot100-clean.html) is an R notebook that downloads Hot 100 data from data.world and cleans it for use in assignments. It is the data used since the following process did not work.
- 01-build-archive-hot100 is a python Jupyter Notebook that downloads Hot 100 charts from Billboard in an attempt to build my own original data. It stopped working on older years and had other isseus, so I now use the data from 01-hott100-clean instead.

## Requirements for the Python bits

- [Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/) or maybe [Jupyter](https://jupyter.org/documentation).
- [Billboard Charts](https://github.com/guoguo12/billboard-charts)
- [Pandas](https://pandas.pydata.org/)

### Conda environment

I use [conda](https://docs.conda.io/projects/conda/en/latest/index.html) as a python environment manager. If you use conda, you can load my environment (which includes extra stuff beyond what's needed in this repo), with this:

`conda env create -n billboard`

then:

`conda activate billboard`




