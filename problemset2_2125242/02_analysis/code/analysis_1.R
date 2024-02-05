# 回帰分析

## semester制が導入された年を表す変数と、semeter制導入からの相対年数の変数を作成
df_new <- df |> 
  mutate(
    yearofsem = if(any(semester == 1)){
      min(year[semester == 1])
    }else{NA},
    yearstosem = if(any(semester == 1)){
      year - yearofsem
    }else{NA},
    treated = if_else(yearstosem < 0, 0, 1),
    .by = unitid
    ) |> 
  filter(!is.na(treated)) # NAとなっている行はdrop


# 単回帰分析の実行
# 目的変数：gradrate4yr, 説明変数：treated
# 一度もsemester制になっていない大学は除外されている
lm_result <- lm(gradrate4yr ~ treated, data = df_new)

modelsummary(lm_result, 
             output = "latex_tabular", 
             fmt = 2, 
             stars = TRUE,
             gof_map = c("nobs", "r.squared"))
