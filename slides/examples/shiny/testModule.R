library(testthat)
library(shiny)

test_that("my module works", {
  library(shinytest2)
  app <- AppDriver$new(
    app_dir = "module",
    load_timeout = 1e5,
    variant = platform_variant()
  )
  app$get_logs()

  # Here we use the namespace that is used in the app for the module.
  ns <- NS("hist1")
  app$set_inputs(!!ns("bins") := 20)

  # For interactive development of the test often helpful:
  app$get_screenshot()
  app$get_values()$input
  # Here we see the namespace being used!

  # We can also take screenshots of specific elements e.g. the plot.
  app$get_screenshot(
    "histplot.png", 
    selector = paste0("#", ns("hist"))
  )
  # But note that comparing these via testthat::expect_snapshot_file
  # can be tricky - as different computers will produce slightly different
  # graphs.

  # Release memory:
  app$stop()
})

# For a starting point to code the tests run:
record_test(app = "module")
