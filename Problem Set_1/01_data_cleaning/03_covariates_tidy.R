# preparation
library(tidyverse)
library(readxl)
library(stringr)

# path
dir_path_covariates_data <- paste0(dir_path_raw, "covariates/covariates.xlsx")

# Load data
covariates_ready <- read_excel(dir_path_covariates_data)

# change the name of the column
covariates_ready <- covariates_ready |> 
  rename(
    unitid = university_id
  )

# delete "aaaa" from unitid
covariates_ready$unitid <- str_remove(covariates_ready$unitid, "aaaa")

# make df wider
covariates_ready <- covariates_ready |> 
  pivot_wider(
    names_from = category,
    values_from = value
  )

