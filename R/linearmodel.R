#' Linear Regression Model

#' Create a linear regression model
#'
#' This function takes in a recipe and a data frame.
#'
#' @param recipe The recipe for the model.
#' @param data The dataset for the model.
#'
#' @return A list that includes the intercept and coefficients for the linear model.
#'
#' @examples
#' linearmodel(recipes::recipe(mpg ~ hp + wt, mtcars), mtcars)
#'
#' @export
#'

linearmodel <- function(recipe, data){

  if (!is.list(recipe)){
    stop("Input parameter must be a recipe (list).")
  }

  else if (!is.data.frame(data)){
    stop("Parameter data must be a dataframe.")
  }

  else {
    return(
      workflows::workflow() |>
        workflows::add_recipe(recipe) |>
        workflows::add_model(parsnip::linear_reg() |>
                               parsnip::set_engine("lm") |>
                               parsnip::set_mode("regression")) |>
        parsnip::fit(data)
    )
  }
}
