# Billboard scrape

# Setup
library(tidyverse)
library(rvest)
library(lubridate)
library(here)

# Scraping
scrape_url <- "https://www.billboard.com/charts/hot-100/"

# Scrape the page
first_scrape <- read_html(scrape_url)

# Get the date of the current chart
data_date <- first_scrape %>% 
  html_element("div#chart-date-picker") %>% 
  html_attr("data-date")

# Get the chart year for write directory
chart_year <- ymd(data_date) %>% year()

# gets the billboard list
second_scrape <- first_scrape %>% 
  html_elements("ul.o-chart-results-list-row")

# gets the text from within the list items
all_lines <- second_scrape %>% 
  html_text2()

# converts that text from a list to a tibble
lines_tibble <- all_lines %>% as_tibble()

# clean out some words that get added
# when song is new or reentering the chart
lines_cleaned <- lines_tibble %>% 
  mutate(
    data_cleaned = str_remove_all(value, " NEW\n|NEW"),
    data_cleaned = str_remove_all(data_cleaned, " RE- ENTRY\n|RE- ENTRY")
  ) %>% 
  select(data_cleaned, value)

# Separate the data into columns.
lines_separated <- lines_cleaned %>% separate(
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
) %>% 
  select(-value)

# Add a date column
dated_data <- lines_separated %>% 
  mutate(chart_week = data_date) %>% 
  select(chart_week, everything())

# Export the data
folder_path <- paste("data-download/hot100-scraped/", chart_year, "/", sep = "")
# Make sure write path exists
if (!dir.exists(here(folder_path))) {dir.create(here(folder_path))}
# Write the data
dated_data %>% write_csv(paste(folder_path, data_date, ".csv", sep = ""))
