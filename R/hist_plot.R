#' Histogram Plot

#' Create a histogram for a given variable
#'
#' This function takes in a dataset, a variable x from the dataset, an x-axis label, a y-axis label, a title for the plot and the text size.
#'
#' @param data The dataset that contains the x variable.
#' @param var The name of the numerical variable that will be on the x-axis of the histogram.
#' @param xlab The label of the x-axis.
#' @param ylab The label of the y-xis.
#' @param title The title of the histogram plot.
#' @param text_size The size of the plot's text.
#'
#' @return A histogram plot for given numerical variable
#'
#' @examples
#' # hist_plot(mtcars, mpg, "Miles Per Gallon", "Count", "Histogram for MPG of Cars", 10)
#'
#' @export
#'
hist_plot <- function(data, var, xlab, ylab, title, text_size){
  if (!is.data.frame(data)){
    stop("Parameter data must be a dataframe")
  }

  else if (!is.numeric(dplyr::pull(data, {{var}}))){
    stop("Variable x must be a numerical variable.")}

  else if(!is.character(xlab)){
    stop("Parameter xlab must be a string.")
  }

  else if(!is.character(ylab)){
    stop("Parameter ylab must be a string.")
  }

  else if(!is.character(title)){
    stop("Parameter title must be a string.")
  }

  else if(!is.numeric(text_size)){
    stop("Parameter text_size must be a numeric value.")
  }

  else {
    x = dplyr::pull(data, {{var}})
    return(
      ggplot2::ggplot(data, ggplot2::aes(x = x)) +
        ggplot2::geom_histogram() +
        ggplot2::labs(x = xlab, y = ylab) +
        ggplot2::ggtitle(title) +
        ggplot2::theme(text = ggplot2::element_text(size = text_size))
    )
  }
}
