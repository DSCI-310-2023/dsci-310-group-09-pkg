#' Summarize columns of data
#'
#' Create a new data frame with 3 columns (mean, med, sd)
#'
#' @param data_frame A data frame or data frame extension
#' @param column unnamed column preparing to summarize
#'
#' @return A data frame with 3 columns (mean, med, sd). Given
#' if input is an empty df, then return an empty df
#'
#' @examples
#' # summarize_column(mtcars, mtcars$mpg)
#'
#' @export
#'

summarize_column <- function(data_frame, column) {
  if(!is.data.frame(data_frame)){
    stop("input data_frame needs to be a data frame or extension")
  } else if(!is.numeric(column)) {
    stop("input column needs to be a numeric")
  } else if(nrow(data_frame) < 1) {
    return(data.frame(mean = numeric(0),
                      med = numeric(0),
                      sd = numeric(0)))
  } else {
    return (
      data_frame |>
        dplyr::summarize(mean = mean(column),
                         med = stats::median(column),
                         sd = stats::sd(column))
    )
  }
}


#mpg <- print(mtcars[, c("mpg")])



