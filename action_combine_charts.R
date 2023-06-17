# Combine Billboard charts


# Setup
library(tidyverse)
library(fs)

# Charts list
charts_list <- c("hot-100", "billboard-200")

# Combine the files for each chart
for (chart in charts_list) {
  
  # compile a list of files to scrape
  files_list <-  dir_ls(paste("data-scraped", chart, sep = "/"), recurse = TRUE, regexp = ".csv")
  
  # combine all the files
  charts_recent <- map_dfr(files_list, read_csv, col_types = cols("last_week" = col_integer()))
  
  # write the combined file
  charts_recent |> write_csv(paste("data-out/", chart, "-current.csv", sep = ""))
  
  # Create assignment data
  if (chart == "hot-100") {
    hot100_assignment <- charts_recent %>%
      # muck the date
      mutate(
        chart_week = paste(
          month(chart_week) %>% as.character(),
          day(chart_week) %>% as.character(),
          year(chart_week) %>% as.character(),
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
    hot100_assignment |> write_csv("data-out/hot100_assignment.csv")
  }
  
}


