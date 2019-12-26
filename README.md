# rwd-py-billboard

Fetches Billboard charts data using the [Billboard Charts](https://github.com/guoguo12/billboard-charts) python package.

## Requirements

- [Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/) or maybe [Jupyter](https://jupyter.org/documentation).
- [Billboard Charts](https://github.com/guoguo12/billboard-charts)
- [Pandas](https://pandas.pydata.org/)

### Conda environment

I use [conda](https://docs.conda.io/projects/conda/en/latest/index.html) as a python environment manager. If you use conda, you can load my environment (which includes extra stuff beyond what's needed in this repo), with this:

`conda env create -n billboard`

then:

`conda activate billboard`

## Concept

Idea is to use the billboard api using the python package to create and keep updated various Billboard charts through history.

I'll start with the Billboard Hot 100 as I use that in lessons. Previously I've used a [data.world](https://data.world/kcmillersean/billboard-hot-100-1958-2017) set, but it isn't regularly updated.


