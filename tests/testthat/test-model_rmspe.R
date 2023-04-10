#helper data

set.seed(100)
test_split1 <- rsample::initial_split(mtcars)
test_training1 <- rsample::training(test_split1)
test_testing1 <- rsample::testing(test_split1)
test_model1 <- linearmodel(recipes::recipe(mpg ~ hp + wt, test_training1), test_training1)
var1 <- "mpg"

test_rmspe <- test_model1 |>
  stats::predict(test_testing1) |>
  dplyr::bind_cols(test_testing1) |>
  yardstick::metrics(truth = mpg, estimate = .pred) |>
  dplyr::filter(.metric == "rmse") |>
  dplyr::select(.estimate) |>
  dplyr::pull()

#test input data

testthat::test_that("Function can only accept a list for the model parameter", {
  testthat::expect_error(model_rmspe("test_model1", test_training1, var1))
  testthat::expect_error(model_rmspe(5, test_training1, var1))
  testthat::expect_error(model_rmspe(c(1,0), test_training1, var1))
}
)

testthat::test_that("Function can only accept a dataframe for the data parameter", {
  testthat::expect_error(model_rmspe(test_model1, "test_training1", var1))
  testthat::expect_error(model_rmspe(test_model1, 6, var1))
  testthat::expect_error(model_rmspe(test_model1, c(1,2,3), var1))
}
)

testthat::test_that("Function can only accept a string for var parameter", {
  testthat::expect_error(model_rmspe(test_model1, test_training1, mpg))
  testthat::expect_error(model_rmspe(test_model1, test_training1, c(1,2,3)))
  testthat::expect_error(model_rmspe(test_model1, test_training1, list(1,2,3)))
  testthat::expect_error(model_rmspe(test_model1, test_training1, 6))
}
)

#test for output variables
testthat::test_that("Checks that the output is numeric", {
  rmspe1 <- model_rmspe(test_model1, test_training1, var1)
  testthat::expect_true(is.numeric(rmspe1))
  testthat::expect_equal(model_rmspe(test_model1, test_testing1, var1), test_rmspe)
})
