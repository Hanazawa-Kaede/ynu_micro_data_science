# preparation
library(tidyverse)

# semester_dummy_tidy, covariates_ready, outcome_data(i.e., gradrate_ready)を適切に結合
# outcome_data$unitidとoutcome_data$yearを文字列に変換
outcome_data$unitid <- as.character(outcome_data$unitid)
outcome_data$year <- as.character(outcome_data$year)

# unitidとyearをkeyにしてleft_join
master <- semester_dummy_tidy |> 
  left_join(covariates_ready, by = c("unitid", "year")) |> 
  left_join(outcome_data, by = c("unitid", "year")) |> 
  mutate(white_cohortsize = as.numeric(white_cohortsize))

# 白人学生が学生全体に占める割合を計算し、有効数字3桁に調整した上で、新たな列として追加
master <- master |> 
  mutate(white_rate = round(white_cohortsize / totcohortsize, 3))

# 不要な変数を削除（Enviromentの見やすさのため）
keep <- c("master", "semester_dummy_tidy", "covariates_ready", "outcome_data")
rm(list = setdiff(ls(), keep))
