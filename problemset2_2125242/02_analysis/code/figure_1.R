# 4年卒業率（tot4yrgrads）の平均推移を計算する
gplot_df <- df |>  
  group_by(semester, year) |> 
  summarise(
  gradrate4yr_mean = mean(gradrate4yr)
)


gplot_df |> ggplot() +
  geom_line(aes(x = year, y = gradrate4yr_mean, color = factor(semester))) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank()) +
  labs(title = "Average 4-year graduation rate") 
