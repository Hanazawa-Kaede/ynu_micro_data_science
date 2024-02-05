# semester導入率を計算し、図で示す
N <- nrow(df)
gplot_df <- df |> 
  group_by(year) |> 
  summarise(
    sum_of_semester = sum(semester),
    rate_of_semester = sum(semester)/N
  )


gplot_df |> ggplot()+
  geom_line(aes(x = year, y = rate_of_semester))+
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank()) +
  labs(x = NULL, title = "Trends in semester adoption rate", y = "Percentage of semester introduction")

