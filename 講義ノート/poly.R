n <- 5

set.seed(1)
x <- seq(0, 2*pi, length.out = n)
y <- sin(x) + rnorm(n, sd = 0.2)
plot(x, y)
df <- data.frame(x, y)



# 線形回帰モデルによって当てはめ
OLS_model <- lm(y ~ x, data = df)
OLS_r2 <- summary(OLS_model)$r.squared
OLS <- df |> 
  ggplot(aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = "lm", se=FALSE) +
  ggtitle(paste0("R^2 = ", round(OLS_r2, 3)))

poly_model <- lm(y ~ poly(x, 3), data = df)
poly_r2 <- summary(poly_model)$r.squared
# 多項式（3次）モデルによって当てはめ 
nonlinear <- df |> 
  ggplot(aes(x, y)) + 
  geom_point() + 
  geom_smooth(method = "lm",formula = y ~ poly(x, 3), se=FALSE) +
  ggtitle(paste0("R^2 = ", round(poly_r2, 3)))

# 2つの図を並べて表示
grid.arrange(OLS, nonlinear, ncol=2)

# n-1次多項式モデル
poly_full <- lm(y ~ poly(x, 5, raw = TRUE), data = df)
poly_full_r2 <- summary(poly_full)$r.squared
poly_full_plot <- ggplot(df, aes(x, y)) +
  geom_point() +
  geom_line(aes(y = predict(poly_full)), color = "red") +
  ggtitle(paste0("R^2 = ", round(poly_full_r2, 3)))

# 100次多項式
poly_full_1 <- lm(y ~ poly(x, 100, raw = TRUE), data = df)
poly_full_r2_1 <- summary(poly_full_1)$r.squared
poly_full_plot_1 <- ggplot(df, aes(x, y)) +
  geom_point() +
  geom_line(aes(y = predict(poly_full_1)), color = "red") +
  ggtitle(paste0("R^2 = ", round(poly_full_r2_1, 3)))

grid.arrange(OLS, nonlinear, poly_full_plot, poly_full_plot_1, ncol=2)

# 行列を使ってn次多項式モデルを実装する
polynominal <- function(y, x, degree){
  X <- matrix(NA, nrow = length(x), ncol = degree + 1)
  for(i in 0:degree){
    X[, i + 1] <- x^i
  }
  XT <- t(X)
  beta_hat <- solve(XT %*% X) %*% XT %*% y
  return(beta_hat)
}

model <- polynominal(df$y, df$x, 5)
model

# 予測値を計算
y_hat <- function(x, beta_hat){
  y_hat <- 0
  for(i in 1:length(beta_hat)){
    y_hat <- y_hat + beta_hat[i] * x^(i - 1)
  }
  return(y_hat)
}

y_hat <- y_hat(df$x, model)
y_hat

# 予測値をプロット
ggplot(df, aes(x, y)) +
  geom_point() +
  geom_line(aes(y = y_hat), color = "red")
