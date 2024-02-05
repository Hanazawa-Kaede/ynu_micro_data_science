library(fixest)

# 自然対数をとるデータ用に、0を除外したサブセットを作成する
df_not0 <- df_new |> 
  filter(costs != 0, instatetuition !=0)


# 時点固定効果+大学固有効果+コントロール変数を加えて回帰分析
model_list <- list(
  OLS = lm(gradrate4yr ~ treated, data = df_new),
  Multi_OLS = lm(gradrate4yr ~ treated + totcohortsize + costs + instatetuition, data = df_new),
  Multi_ln = lm(gradrate4yr ~ treated + log(totcohortsize) + log(costs) + log(instatetuition), data = df_not0),
  TFE = feols(gradrate4yr ~ treated + totcohortsize + costs + instatetuition | unitid + year,
    data = df_new),
  TFE_ln = feols(
    gradrate4yr ~ treated + log(totcohortsize) + log(costs) + log(instatetuition) | unitid + year,
    data = df_not0)
)

# 回帰表の作成
modelsummary(model_list, 
             output = "latex_tabular",
             fmt = 3,
             stars = TRUE,
             gof_omit = 'R2 Adj.|R2 Within Adj.|F|RMSE|Log.Lik.|AIC|BIC')
