install.packages(c(
    "tidyverse",
    "testthat",
    "covr",
    "shiny",
    "shinytest2",
    "profvis",
    "data.table",
    "usethis",
    "roxygen2",
    "devtools",
    "rlang",
    "checkmate",
    "knitr",
    "rmarkdown",
    "glue",
    "httr",
    "styler",
    "lintr",
    "pkgdown",
    "remotes"
))

# Install using the remotes package
remotes::install_github("rstudio/shinyuieditor")
# For this package, please see https://rstudio.github.io/shinyuieditor/
# for Installation instructions and
# https://rstudio.github.io/shinyuieditor/#trouble-installing
# if you have trouble with the installation.
# It is not super essential for the workshop
# so no worries if it does not install in the end.