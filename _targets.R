library(targets)

tar_option_set(
  packages = c("glue", "ggdag", "ggraph", "here", "tidygraph", "tidyverse")
)

data(glasgow, package = "netmediate")

options(clustermq.scheduler = "multicore")

tar_source()

list(

  tar_target(
    contagion_figure,
    make_contagion_figure(),
    format = "file"
  ),

  tar_target(
    mediating_figure,
    make_mediating_figure(),
    format = "file"
  ),

  tar_target(
    homophily_mediating_figure,
    make_homophily_mediating_figure(),
    format = "file"
  ),

  tar_target(
    homophily_mediating_contagion_peer_figur,
    make_homophily_mediating_contagion_peer_figure(),
    format = "file"
  ),

  tar_target(
    homophily_mediating_interference_peer_figure,
    make_homophily_mediating_interference_peer_figure(),
    format = "file"
  ),

  tar_target(
    homophily_confounding_contagion_peer_figur,
    make_homophily_confounding_contagion_peer_figure(),
    format = "file"
  ),

  tar_target(
    matrix_figures,
    make_matrix_figures(),
    format = "file"
  )
)
