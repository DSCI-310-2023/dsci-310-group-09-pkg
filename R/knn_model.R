#' K-NN Regression Model
#'
#' Create a K Nearest Neighbours regression model
#'
#' This function takes in a recipe, a data frame and a column name as a string.
#'
#' @param recipe The recipe for the model
#' @param data The dataset for the model
#' @param y The name (as a string) of the column for the response variable
#'
#' @return A model (list) that includes information on the type of response variable,
#' minimal mean absolute error, minimal mean squared error, best kernel and best k.
#'
#' @examples
#' knn_model(recipes::recipe(Sepal.Length ~ Sepal.Width, iris), iris, "Sepal.Length")
#'
#' @export
#'

knn_model <- function(recipe, data, y){
  if (!is.list(recipe)){
    stop("Input parameter must be a recipe (list).")
  }

  else if (!is.data.frame(data)){
    stop("Parameter data must be a dataframe.")
  }

  else if (!is.character(y)){
    stop("Parameter y must be a string.")
  }

  else {

    spec <- parsnip::nearest_neighbor(weight_func = "rectangular", neighbors = parsnip::tune()) |>
      parsnip::set_engine("kknn") |>
      parsnip::set_mode("regression")

    workflow <- workflows::workflow() |>
      workflows::add_recipe(recipe) |>
      workflows::add_model(spec)

    gridvals <- dplyr::tibble(neighbors = seq(from = 1, to = 100))

    vfold <- rsample::vfold_cv(data, v = 10, strata = y)

    cv_results <- workflow |>
      tune::tune_grid(resamples = vfold, grid = gridvals) |>
      tune::collect_metrics()

    k_min <- cv_results |>
      dplyr::filter(.metric == "rmse") |>
      dplyr::arrange(mean) |>
      dplyr::slice(1) |>
      dplyr::pull(neighbors)

    best_spec <- parsnip::nearest_neighbor(weight_func = "rectangular", neighbors = k_min) |>
      parsnip::set_engine("kknn") |>
      parsnip::set_mode("regression")

    return(
      workflows::workflow() |>
      workflows::add_recipe(recipe) |>
      workflows::add_model(best_spec) |>
      parsnip::fit(data)
    )
  }
}
