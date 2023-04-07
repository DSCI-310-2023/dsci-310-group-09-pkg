#helper functions

test_data_frame <- iris
test_recipe <- recipes::recipe(Sepal.Length ~ Sepal.Width, test_data_frame)
test_y <- "Sepal.Length"

helper_linear <- workflows::workflow() |>
  workflows::add_recipe(recipe=test_recipe) |>
  workflows::add_model(parsnip::linear_reg() |>
                         parsnip::set_engine("lm") |>
                         parsnip::set_mode("regression")) |>
  parsnip::fit(data=test_data_frame)

#test input data
testthat::test_that("Function can only accept a list for the recipe parameter", {
  expect_error(knn_model("test_recipe", test_data_frame, test_y))
  expect_error(knn_model(5, test_data_frame, test_y))
  expect_error(knn_model(c(1,0), test_data_frame, test_y))
}
)

testthat::test_that("Function can only accept a dataframe for the data parameter", {
  expect_error(knn_model(test_recipe, "test_data_frame", test_y))
  expect_error(knn_model(test_recipe, list(1,2,3), test_y))
  expect_error(knn_model(test_recipe, 6, test_y))
  expect_error(knn_model(test_recipe, c(1,2,3), test_y))
}
)

testthat::test_that("Function can only accept a string for the y parameter", {
  expect_error(knn_model(test_recipe, test_data_frame, Sepal.Length))
  expect_error(knn_model(test_recipe, test_data_frame, c(1,2,3)))
  expect_error(knn_model(test_recipe, test_data_frame, list(1,2,3)))
  expect_error(knn_model(test_recipe, test_data_frame, 6))
}
)


#test for output variables
testthat::test_that("Checks the output of the knn model", {
  knnmod1 <- knn_model(test_recipe, test_data_frame, test_y)
  expect_true(is.list(knnmod1))
})
