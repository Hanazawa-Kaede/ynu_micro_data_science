# preparation
library(tidyverse)

# リスト化
df_list <- list(
  outcome_data,
  semester_dummy_tidy,
  covariates_ready
)

# minとmaxを取得する関数
get_min_max <- function(df) {
  df <- df |> 
    mutate(year = as.numeric(as.character(year))) |> 
    summarise(
      year_max = max(year, na.rm = TRUE),
      year_min = min(year, na.rm = TRUE))
  return(df)
}

# 各dfの最大値と最小値を取得
year_min_max <- map(df_list, get_min_max)

# year_min_maxをlistからdfに変換
df_min_max <- year_min_max[[1]]

for (i in 2:length(df_list)) {
  df_min_max <- bind_rows(df_min_max, year_min_max[[i]])
}

# 各dfの中での最大値と最小値を取得
year_min_max <- df_min_max |> 
  summarise(
    max = max(year_max),
    min = min(year_min))

# covariatesデータの期間を他のデータと揃える
covariates_ready <- covariates_ready |> 
  filter(year >= year_min_max$min & year <= year_min_max$max)


# covariates_readyからoutcome_dataのunitidに合致するものを抽出
covariates_ready <- covariates_ready |> 
  filter(unitid %in% outcome_data$unitid)


