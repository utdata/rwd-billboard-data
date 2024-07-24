# Create current assignment data

## Setup
library(tidyverse)

## Import the current data
hot100_current <- read_csv("data-out/hot-100-current.csv")

## Muck the data
hot100_assignment <- hot100_current  |> 
  # muck the date
  mutate(
    chart_week = paste(
      month(chart_week) |> as.character(),
      day(chart_week) |> as.character(),
      year(chart_week) |> as.character(),
      sep = "/"
    )
  ) |>   
  # muck the names
  select(
    `CHART WEEK` = chart_week,
    `THIS WEEK` = current_week,
    `TITLE` = title,
    `PERFORMER` = performer,
    `LAST WEEK` = last_week,
    `PEAK POS.` = peak_pos,
    `WKS ON CHART` = wks_on_chart
  )

# hot100_assignment |> glimpse()

## Export the data
hot100_assignment |> write_csv("data-out/hot100_assignment_current.csv")

