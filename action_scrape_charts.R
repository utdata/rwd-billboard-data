# Scrape billboard charts

## Can scrape current charts based on a list of chart slugs.

# Setup
library(tidyverse)
library(rvest)
library(lubridate)
library(here)

# Charts list
charts_list <- c("hot-100", "billboard-200")

# The loop to pull each chart
for (chart in charts_list) {
  
  # make the url
  scrape_url <- paste(
    "https://www.billboard.com/charts/",
    chart,
    "/",
    sep = ""
  )
  
  # get initial scrape
  scrape_first <- read_html(scrape_url)
  
  # pull date from scrape
  chart_date <- scrape_first |> 
    html_element("div#chart-date-picker") |> 
    html_attr("data-date")
  
  # pull year from scrape
  chart_year <- year(chart_date)
  
  # process results into a tibble
  scrape_tibble <- scrape_first |> 
    html_elements("ul.o-chart-results-list-row") |> 
    html_text2() |> 
    as_tibble()
  
  # clean up the tibble
  scrape_clean <- scrape_tibble |> 
    mutate(
      data_cleaned = str_remove_all(value, " NEW\n|NEW"),
      data_cleaned = str_remove_all(data_cleaned, " RE- ENTRY\n|RE- ENTRY")
    ) |> 
    select(data_cleaned, value) |> 
    separate(
      col = data_cleaned,
      sep = "\n",
      into = c(
        "current_week",
        "title",
        "performer",
        "last_week",
        "peak_pos",
        "wks_on_chart"
      )
    ) |> 
    select(-value) |> 
    mutate(chart_week = chart_date) |> 
    select(chart_week, everything())
  
  # name path to save file
  folder_path <- paste("data-scraped/", chart, "/", chart_year, "/", sep = "")
  
  # create the directory if it doesn't exist
  if (!dir.exists(here(folder_path))) {dir.create(here(folder_path), recursive = TRUE)}
  
  # write the file
  scrape_clean |> write_csv(paste(folder_path, chart_date, ".csv", sep = ""))
  
}
