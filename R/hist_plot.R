hist_plot <- function(data, var, xlab, ylab, title, text_size){
  x = dplyr::pull(data, {{var}})
  if (!is.data.frame(data)){
    stop("Parameter data must be a dataframe")
  }

  else if (!is.numeric(x)){
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
    return(
      ggplot(data, aes(x = x)) +
        geom_histogram() +
        labs(x = xlab, y = ylab) +
        ggtitle(title) +
        theme(text = element_text(size = text_size))
    )
  }
}
