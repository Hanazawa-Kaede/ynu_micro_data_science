# 各散布図を作成する

make_scatter <- function(xlab, x, y, df){
  ylab <- as.character(substitute(y))[3]
  res <- df |> ggplot() +
    geom_point(aes(x = x, y = y)) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major.x = element_blank()) +
    labs(x = xlab, y = ylab, title = paste(xlab, ylab, sep = " and "))
  return(res)
}


# 4年卒業率と男子学生比率
## 男子学生比率を表す変数を作成する
df <- df |> 
  mutate(
    per_men_cohort = m_cohortsize/totcohortsize
  )


title_list <- list(
  "4yearGraduateRate_MenCohortRate.pdf",
  "4yearGraduateRate_WomonCohortRate.pdf",
  "4yearGraduateRate_WhiteCohortRate.pdf",
  "4yearGraduateRate_Costs.pdf",
  "4yearGraduateRate_TuitionFee.pdf"
)
x_list <- list(
  df$per_men_cohort,
  df$per_women_cohort,
  df$per_white_cohort,
  df$costs,
  df$instatetuition
)

xlab_list <- list(
  "per_men_cohort",
  "per_women_cohort",
  "per_white_cohort",
  "costs",
  "instatetuition"
)
# 表の作成
setwd("02_analysis/output")
for (i in 1:5) {
  gplot <- make_scatter(xlab_list[[i]], x_list[[i]],df$gradrate4yr, df)
  ggsave(title_list[[i]], device = "pdf")
}
setwd(here::here())





