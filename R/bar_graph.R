# Bar Graph Plot

#' Create a bar graph for a given variable
#'
#' This function takes in a dataset, a variable x from the dataset, a variable y from the dataset, an x-axis label, a y-axis label, a fill label, and a title for the plot
#'
#' @param df The dataset that contains the x variable.
#' @param x The name of the discrete variable that will be on the x-axis of the bar graph.
#' @param y The name of the numerical variable that will be on the y-axis of the bar graph.
#' @param xlab The label of the x-axis.
#' @param ylab The label of the y-xis.
#' @param fill_lab The label of the fill variable.
#' @param title The title of the bar graph.
#'
#' @return A bar graph for given discrete variable, x, and numerical variable y
#'
#' @examples
#' # bar_graph(iris, iris$Species, iris$Sepal.Width, "Species", "Sepal Width", "Species", "Iris Graph")
#'
#' @export
#'

bar_graph <- function(df, x, y, xlab, ylab, fill_lab, title) {

  if(!is.data.frame(df)) {
    stop("Parameter df must be a dataframe")
  }

  if(!is.factor(x)) {
    stop("Please pass me a discrete variable")
  } else if (!is.numeric(y)) {
    stop("Please pass me a numerical variable")

  } else if (!is.character(xlab)) {
    stop("Please pass me a string")

  } else if (!is.character(ylab)) {
    stop("Please pass me a string")

  } else if (!is.character(fill_lab)) {
    stop("Please pass me a string")

  } else if (!is.character(title)) {
    stop("Please pass me a string")
  }
  else{
    df |>
      ggplot2::ggplot(ggplot2::aes(x = x, y = y, fill = x)) +
      ggplot2::geom_bar(stat = "identity", position = "dodge") +
      ggplot2::labs(x = xlab, y = ylab, fill = fill_lab) +
      ggplot2::ggtitle(title) +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1),
            text = ggplot2::element_text(size = 15),
            panel.background = ggplot2::element_rect(fill = 'darkgrey', color = 'purple'),
            plot.title = ggplot2::element_text(hjust = 0.5)) +
      ggplot2::scale_fill_brewer(palette = 'GnBu')
  }
}

