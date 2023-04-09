#' Scatter Plot
#'
#' Creates a scatter plot using two variables in data frame
#'
#' This function takes in a data set, a variable x from the data set,
#' a variable y from the data set, an x-axis label, a y-axis label,
#' a title for the plot, the text size, and the model type (optional).
#'
#' @param data A data frame
#' @param var1 the variable x in the relationship
#' @param var2 the variable y in the relationship
#' @param xlab the label of the x-axis
#' @param ylab the label of the y-axis
#' @param title the title of the scatter plot with the regression line
#' @param text_size the size of text of the labels/title
#' @param type specify whether the model is linear with "lm" or k-nn with "knn" (default value = NULL)
#'
#' @return A scatter plot where
#'   The x-axis are for the x variable specified
#'   The y-axis are for the y variable specified
#'
#' @examples
#' scatter_plot(mtcars, mpg, hp, "Miles Per Gallon", "Horse Power",
#' "Scatter Plot for MPG vs HP", 10, "lm")
#'
#' @export
#'

scatter_plot <- function(data,var1,var2,xlab,ylab,title,text_size,type=NULL){
  x = dplyr::pull(data, {{var1}})
  y = dplyr::pull(data, {{var2}})
  if (!is.data.frame(data)){
    stop("Parameter data must be a dataframe.")
  }

  else if(!is.numeric(x)){
    stop("Please put in a numeric variable for x.")
  }
  else if(!is.numeric(y)){
    stop("Please put in a numeric variable for y.")
  }
  else if(!is.character(xlab)){
    stop("Please put in a string parameter for xlab.")
  }
  else if(!is.character(xlab)){
    stop("Please put in a string parameter for ylab.")
  }
  else if(!is.character(title)){
    stop("Please put in a string parameter for title.")
  }
  else if(!is.numeric(text_size)){
    stop("Parameter text_size must be a numeric value.")
  }
  else if(rlang::is_empty(type)){
    return (
      ggplot2::ggplot(data, ggplot2::aes(x=x,y=y)) +
        ggplot2::geom_point()+
        ggplot2::labs(x=xlab,y=ylab)+
        ggplot2::ggtitle(title)+
        ggplot2::theme(text=ggplot2::element_text(size=text_size))
    )
  }

  else if(!is.character(type)){
    stop("Please put in a string parameter for model type i.e. 'lm' or 'knn'.")
  }

  else if(type != "lm" & type != "knn") {
    stop("Please choose model type to be either 'lm', 'knn' or empty by default.")
  }

  else if(type == "lm") {
    return(
      ggplot2::ggplot(data, ggplot2::aes(x=x,y=y)) +
        ggplot2::geom_point()+
        ggplot2::labs(x=xlab,y=ylab)+
        ggplot2::ggtitle(title)+
        ggplot2::theme(text=ggplot2::element_text(size=text_size))+
        ggplot2::geom_smooth(method = type, se = FALSE)
      )

  }

  else if(type == "knn") {
    .pred <- NULL
    return(
      ggplot2::ggplot(data, ggplot2::aes(x=x,y=y)) +
        ggplot2::geom_point()+
        ggplot2::labs(x=xlab,y=ylab)+
        ggplot2::ggtitle(title)+
        ggplot2::theme(text=ggplot2::element_text(size=text_size))+
        ggplot2::geom_line(data,
                           mapping = ggplot2::aes(x = x, y = .pred),
                           color = "blue")
    )

  }

  else {
    return (
      ggplot2::ggplot(data, ggplot2::aes(x=x,y=y)) +
        ggplot2::geom_point()+
        ggplot2::labs(x=xlab,y=ylab)+
        ggplot2::ggtitle(title)+
        ggplot2::theme(text=ggplot2::element_text(size=text_size))
    )
  }
}
