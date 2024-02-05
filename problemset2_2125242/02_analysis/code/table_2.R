library(tidyverse)
library(modelsummary)

# Balanced Tableの作成

df <- read_csv(paste0(here::here(),"/01_data/raw/master.csv"))

# 注釈
notes <- "0が4学期制、1が2学期制を表す。また、6年で卒業のデータがないため、Bostwick, V., Fischer, S., & Lang, M. (2022) Table1と異なる部分がある。"

df |>
  select(
    gradrate4yr, men_gradrate_4yr, women_gradrate_4yr, costs,
    totcohortsize, semester
  ) |> 
  rename(
    "Four-year graduation rate" = gradrate4yr,
    "Four-year women graduation rate" = women_gradrate_4yr,
    "Four-year men graduation rate" = men_gradrate_4yr,
    "Total expenditures ($/million)" = costs,
    "Cohort size" = totcohortsize
  ) %>%
  datasummary_balance(~semester,
                      data = .,
                      stars = TRUE,
                      fmt = 2,
                      notes = notes,
                      title = "Balance Table",
                      output = "latex_tabular")
