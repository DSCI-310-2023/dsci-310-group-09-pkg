scatter_plot <- function(data,var1,var2,xlab,ylab,title,text_size){
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
  else {
    return (
      ggplot(data,aes(x=x,y=y)) +
        geom_point()+
        labs(x=xlab,y=ylab)+
        ggtitle(title)+
        theme(text=element_text(size=text_size)))
  }
}
