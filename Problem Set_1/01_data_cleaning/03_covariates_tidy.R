# preparation
library(tidyverse)
library(readxl)
library(stringr)

# path
dir_path_covariates_data <- paste0(dir_path_raw, "covariates/covariates.xlsx")

# Load data
df_covariates <- read_excel(dir_path_covariates_data)

# change the name of the column
df_covariates <- df_covariates |> 
  rename(
    unitid = university_id
  )

# delete "aaaa" from unitid
df_covariates$unitid <- str_remove(df_covariates$unitid, "aaaa")

# make df wider
df_covariates_wide <- df_covariates |> 
  pivot_wider(
    names_from = category,
    values_from = value
  )
