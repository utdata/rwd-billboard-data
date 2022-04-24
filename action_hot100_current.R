# Billboard Hot 100: Combine to create current archive

## Setup
library(tidyverse)
library(fs)

## Import archive
charts_archive <- read_csv("data-out/hot100_archive_1958_2021.csv") %>%
  rename(
    chart_week = chart_date,
    current_week = current_position,
    last_week = previous_position,
    peak_pos = peak_position,
    wks_on_chart = weeks_on_chart
  )

## Get scraped files
### Get files list
files_list <-  dir_ls("data-download/hot100-scraped/", recurse = TRUE, regexp = ".csv")

### Read and combine files
charts_recent <- map_dfr(files_list, read_csv, col_types = cols("last_week" = col_integer()))

## Bind archive with current
charts_current <- charts_archive %>% bind_rows(charts_recent)

## Export the result
charts_current %>% write_csv("data-out/hot100_current.csv")

