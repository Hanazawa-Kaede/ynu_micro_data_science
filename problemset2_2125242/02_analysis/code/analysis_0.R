# semesterの導入と各共変量との関係を分析する
library(fixest)

# 時間固定効果・大学固定効果を入れて分析
models <- list(
  FTE_faculty = feols(faculty ~ treated | unitid + year, data = df_new),
  Costs = feols(costs ~ treated | unitid + year, data = df_new),
  In_state_Tuition = feols(instatetuition ~ treated | unitid + year, data = df_new),
  Cohort_size = feols(totcohortsize ~ treated | unitid + year, data = df_new),
  Percent_white = feols(per_white_cohort ~ treated | unitid + year, data = df_new),
  Percent_female = feols(per_women_cohort ~ treated | unitid + year, data = df_new)
)

modelsummary(models, 
             output = "latex_tabular",
             fmt = 3,
             stars = TRUE,
             gof_omit = 'R2 Adj.|R2 Within Adj.|F|RMSE|Log.Lik.|AIC|BIC')
