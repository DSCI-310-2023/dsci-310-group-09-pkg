#helper functions

test_data_scatter <- data.frame(x = c(1, 2, 3, 4), y = c(2, 4, 5, 7))

test_data_scatter2 <- data.frame(x = c("blue", "red", "yellow"), y = c(3,2,1))

test_data_scatter3 <- data.frame(x = c(1,1,1), y = c("yes", "no", "yes"))

helper_scatter_empty_type <- ggplot2::ggplot(test_data_scatter,ggplot2::aes(x=x,y=y)) +
  ggplot2::geom_point()+
  ggplot2::labs(x="xlab",y="ylab")+
  ggplot2::ggtitle("Scatterplot Test")+
  ggplot2::theme(text=ggplot2::element_text(size=10))
helper_scatter_empty_type

helper_scatter_lm_type <- ggplot2::ggplot(test_data_scatter,ggplot2::aes(x=x,y=y)) +
  ggplot2::geom_point()+
  ggplot2::labs(x="xlab",y="ylab")+
  ggplot2::ggtitle("Scatterplot Test")+
  ggplot2::theme(text=ggplot2::element_text(size=10))+
  ggplot2::geom_smooth(method = type, se = FALSE)
helper_scatter_lm_type

#test for input variables
testthat::test_that("Function can only accept certain data types for arguments", {
  expect_error(scatter_plot(c(1,0), c(1,0), c(0,1), "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter2, x, y, "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter3, x, y, "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, x, "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", y, "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", 10, 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", "title", "10"))
  
})

#test type of scatter_plot
testthat::test_that("Function has the right type", {
  expect_true(rlang::is_empty(type), helper_scatter_empty_type)
  expect_true(type == "lm", helper_scatter_lm_type)
})



#test for output variables 
testthat::test_that("Checks the output of the graph", {
  plot <- scatter_plot(test_data_scatter, x, y, "x", "y", "Scatterplot Test", 10)
  expect_true(ggplot2::is.ggplot(plot))
  expect_equal(ggplot2::xlab(plot)$label, ggplot2::xlab(test_data_scatter)$label)
  expect_equal(ggplot2::ylab(plot)$label, ggplot2::ylab(test_data_scatter)$label)
  expect_equal(ggplot2::ggtitle(plot)$label, ggplot2::ggtitle(test_data_scatter)$label)
  
})

