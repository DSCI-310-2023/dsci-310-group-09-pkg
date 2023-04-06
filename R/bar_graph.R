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
      ggplot(aes(x = x, y = y, fill = x)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = xlab, y = ylab, fill = fill_lab) +
      ggtitle(title) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1),
            text = element_text(size = 15),
            panel.background = element_rect(fill = 'darkgrey', color = 'purple'),
            plot.title = element_text(hjust = 0.5)) +
      scale_fill_brewer(palette = 'GnBu')
  }
}

