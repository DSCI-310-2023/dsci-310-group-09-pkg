#' Model RMSPE
#'
#' Output the RMPSE value of a linear or k-nn regression model
#'
#' This function takes in a model, a data frame and a column name as a string
#'
#' @param model The linear or k-nn regression model
#' @param testing_data The testing dataset for the model
#' @param var The name (as a string) of the column for the response variable
#'
#' @return RMSPE value as a number
#'
#' @examples
#' split <- rsample::initial_split(iris)
#' iris_train <- rsample::training(split)
#' iris_test <- rsample::testing(split)
#' iris_model <- linearmodel(recipes::recipe(Sepal.Length ~ Sepal.Width, iris_train), iris_train)
#' model_rmspe(iris_model, iris_test, "Sepal.Length")
#'
#' @export
#'
model_rmspe <- function(model, testing_data, var){
  if (!is.list(model)){
    stop("Parameter model must be of type list.")
  }

  else if (!is.data.frame(testing_data) | !is.list(testing_data)){
    stop("Parameter testing_data must be a dataframe or list.")
  }

  else if (!is.character(var)){
    stop("Parameter var must be a string.")
  }

  else {

    .metric <- NULL
    .estimate <- NULL
    .pred <- NULL

    return(
      model|>
        stats::predict(testing_data) |>
        dplyr::bind_cols(testing_data) |>
        yardstick::metrics(truth = var, estimate = .pred) |>
        dplyr::filter(.metric == "rmse") |>
        dplyr::select(.estimate) |>
        dplyr::pull()
    )
  }
}
