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
  
}