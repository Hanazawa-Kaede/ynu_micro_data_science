# preparation
library(tidyverse)

# calculate gross graduation rate
outcome_data <- outcome_data |>
  mutate(
    m_4yrgrads = as.numeric(m_4yrgrads),
    men_gradrate_4yr = m_4yrgrads / m_cohortsize,
    totcohortsize = as.numeric(totcohortsize),
    total_4yrgrads = m_4yrgrads + w_4yrgrads,
    total_gradrate_4yr = total_4yrgrads / totcohortsize,
    men_gradrate_4yr = round(men_gradrate_4yr, 3),
    women_gradrate_4yr = round(women_gradrate_4yr, 3),
    total_gradrate_4yr = round(total_gradrate_4yr, 3)
    ) |> 
  filter(!is.na(men_gradrate_4yr) & !is.na(women_gradrate_4yr) & !is.na(total_gradrate_4yr))
