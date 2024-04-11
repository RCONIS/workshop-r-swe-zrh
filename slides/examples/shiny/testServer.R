library(shiny)
packageVersion("shiny")

# Our app. ----
ui <- fluidPage(
  numericInput("x", "x", 0),
  numericInput("y", "y", 1),
  numericInput("z", "z", 2),
  h4("What is (x-y) * (z+y)?"),
  textOutput("out")
)
server <- function(input, output, session) {
  xy <- reactive(input$x - input$y)
  yz <- reactive(input$z + input$y)
  xyz <- reactive(xy() * yz())
  output$out <- renderText(paste0("Result: ", xyz()))
}
shinyApp(ui, server)

ui
class(ui)
library(testthat)
expect_s3_class(ui, "shiny.tag.list")

# Test the server. ----
testServer(server, {
  session$setInputs(x = 1, y = 1, z = 1)
  print(xy())
  print(output$out)
})

# Show that inputs are *not* set. (i.e. UI function above has defaults but they
# don't show up here)
testServer(server, {
  print(input$x)
  print(input$y)
  print(input$z)
})

# Inside test_that.
library(testthat)
test_that("reactives and output updates", {
  testServer(server, {
    session$setInputs(x = 1, y = 1, z = 1)
    expect_equal(xy(), 0)
    expect_equal(yz(), 2)
    expect_equal(output$out, "Result: 0")
  })
})
