#helper functions 

test_data_frame1 <- data.frame(data = c(1, 2, 3, 4))
test_recipe1 <- c(3, 4, 5, 6)

helper_linear <- workflows::workflow() |>
  workflows::add_recipe(recipe=test_recipe1) |>
  workflows::add_model(parsnip::linear_reg() |>
                         parsnip::set_engine("lm") |>
                         parsnip::set_mode("regression")) |>
  parsnip::fit(data=test_data_frame1)

#test input data
testthat::test_that("Function can only accept certain data types for arguments", {
  expect_error(linearmodel("no", "yes"))
  expect_error(linearmodel(3, "yes"))
  expect_error(linearmodel(3, 4))
  expect_error(linearmodel(c(0,1), 4))
  expect_error(linearmodel(c(0,1), c(1,0)))
  expect_error(linearmodel("no", c(1,0)))
  expect_error(linearmodel("yes", data.frame(c(0,1))))
  expect_error(linearmodel("yes", (c(0,1))))
  expect_error(linearmodel(data.frame(c(0,2)), 3))
  expect_error(linearmodel((c(0,1)), 3))
  expect_error(linearmodel(data.frame(c(0,1)), c(0,2)))
  expect_error(linearmodel(test_data_frame1, test_recipe1))
}
)

testthat::test_that("Function has the right data types", {
  linearmod1 <- linearmodel(test_recipe1, test_data_frame1)
  expect_true(is.list(linearmod1$test_recipe1))
  expect_true(is.data.frame(linearmod1$test_data_frame1))
              })


#test for output variables 
testthat::test_that("Checks the output of the linear model", {
  linearmod1 <- linearmodel(test_recipe1, test_data_frame1)
  expect_true(is.list(linearmod1))
})
  

  