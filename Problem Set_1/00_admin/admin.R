# すべてのRファイルをここで実行する
rm(list=ls())
source(here::here("00_admin","00_dir_path.R"))
source(here::here("01_data_cleaning", "01_semester_dummy_tidy.R"))
source(here::here("01_data_cleaning", "02_gradrate_tidy.R"))
source(here::here("01_data_cleaning", "03_covariates_tidy.R"))
source(here::here("01_data_cleaning", "04_gradrate_ready.R"))
source(here::here("01_data_cleaning", "05_covariates_ready.R"))
source(here::here("01_data_cleaning", "06_master.R"))
