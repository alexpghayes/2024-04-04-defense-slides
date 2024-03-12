library(tidyverse)
library(here)
library(fastRG)

dense_to_long_tidy <- function(dense) {
  dense |>
    as.matrix() |>
    dplyr::as_tibble(rownames = "row") |>
    tidyr::gather(col, value, -row) |>
    dplyr::mutate_all(as.numeric)
}

make_matrix_figures <- function() {

  k <- 5

  B <- matrix(0.1, k, k)
  diag(B) <- 0.8

  theta <- runif(100, min = 1, max = 10)

  model <- dcsbm(theta = theta, B = B, k = k, expected_density = 0.2, sort_nodes = TRUE)
  model

  P <- expectation(model)

  # note that color scales aren't going to match across these guys

  P_plot <- P |>
    dense_to_long_tidy() |>
    ggplot(aes(x = col, y = row, fill = value)) +
    geom_raster() +
    scale_y_reverse() +
    scale_fill_gradient2(high = "black") +
    theme_void() +
    theme(
      legend.position = "none"
    )

  P_path <- here::here("figures", "matrices", "P.png")

  ggsave(
    P_path,
    height = 5,
    width = 5,
    dpi = 500
  )

  A <- sample_sparse(model)

  A_plot <- plot_sparse_matrix(A) +
    theme(
      legend.position = "none"
    )

  A_path <- here::here("figures", "matrices", "A.png")

  ggsave(
    A_path,
    height = 5,
    width = 5,
    dpi = 500
  )

  s <- irlba::irlba(A, k = k)
  Phat <- tcrossprod(s$u, rowScale(s$v, s$d))
  rownames(Phat) <- rownames(P)
  colnames(Phat) <- colnames(P)

  Phat_plot <- Phat |>
    dense_to_long_tidy() |>
    ggplot(aes(x = col, y = row, fill = value)) +
    geom_raster() +
    scale_y_reverse() +
    scale_fill_gradient2(high = "black") +
    theme_void() +
    theme(
      legend.position = "none"
    )

  Phat_path <- here::here("figures", "matrices", "Phat.png")

  ggsave(
    Phat_path,
    height = 5,
    width = 5,
    dpi = 500
  )

  c(P_path, A_path, Phat_path)

}
