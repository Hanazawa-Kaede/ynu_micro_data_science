# preparation
library(tidyverse)

str(df_outcome)


df_outcome <- df_outcome |>
  mutate(m_4yrgrads = as.numeric(m_4yrgrads)*0.01) 
  
# calculate gross graduation rate
df_outcome <- df_outcome |>
  mutate(m_4yrgrads = as.numeric(m_4yrgrads)) |>
  summarise(
    mean_gradrate_between_male_and_female = mean(m_4yrgrads+w_4yrgrads, na.rm = TRUE)
  )

