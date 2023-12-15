# preparation
library(tidyverse)

# path
dir_path_semester_dummy_1 <- paste0(dir_path_raw, "semester_dummy/semester_data_1.csv")
dir_path_semester_dummy_2 <- paste0(dir_path_raw, "semester_dummy/semester_data_2.csv")

# Load data
semester_dummy_1_data <- read_csv(dir_path_semester_dummy_1)
semester_dummy_2_data <- read_csv(dir_path_semester_dummy_2)

# 2行目を削除
semester_dummy_1_data <- semester_dummy_1_data[-1, ] 

# 全ての列のクラスをcharacterに統一
semester_dummy_2_data <- semester_dummy_2_data |> 
  mutate_all(as.character)

# 2つのデータを統合、x6列（'Y'列）を削除
data <- semester_dummy_1_data |> 
  rbind(semester_dummy_2_data) |>
  select(-"x6")
