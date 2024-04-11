library(shinytest2)
packageVersion("shinytest2")

# Basic operation.
app <- AppDriver$new("basic")
app$set_inputs(name = "Daniel")
app$get_value(output = "greeting")
app$click("reset")
app$get_value(output = "greeting")
app$get_screenshot()

# Can use then together with testthat.
library(testthat)
# Even better is to make sure to wait long enough.
app$set_inputs(name = "Daniel")
value1 <- app$wait_for_value(output = "greeting")
expect_identical(value1, "Hi Daniel")
app$set_inputs(name = "Ben")
# Make sure that greeting has been changed from old value before we take it.
value2 <- app$wait_for_value(output = "greeting", ignore = list(value1))
expect_identical(value2, "Hi Ben")
app$click("reset")
# Same idea here.
value3 <- app$wait_for_value(output = "greeting", ignore = list(value2))
expect_identical(value3, "")
# Oops - it is not! Why?
value3
# So we can instead e.g. expect this:
expect_identical(value3$message, "")
app$get_screenshot()
app$get_values()

# For Help:
?AppDriver
