# preparation
library(tidyverse)
library(readxl)

# path
dir_path_outcome <- paste0(dir_path_raw, "outcome")

# make a list of files
list_files_outcome <- list.files(dir_path_outcome, full.names = TRUE)

# make a dataframe of correspondence table of file names
outcome_data <- list_files_outcome |> 
  map_dfr(read_excel)

# 女子学生の4年卒業率に0.01をかけて、0から1のスケールに変更
outcome_data <- outcome_data |> 
  mutate(
    women_gradrate_4yr = women_gradrate_4yr*0.01
  )
