library(tidyverse)
library(modelsummary)

df <- read_csv(paste0(here::here(),"/01_data/raw/master.csv"))

# 記述統計の作成
df |> select(
  -...1, -year, -unitid, instnm
) |> 
  datasummary_skim(output = "latex_tabular")  
