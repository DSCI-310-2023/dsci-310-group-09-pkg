#helper functions

test_data_scatter <- data.frame(x = c(1, 2, 3, 4), y = c(2, 4, 5, 7))

test_data_scatter2 <- data.frame(x = c("blue", "red", "yellow"), y = c(3,2,1))

test_data_scatter3 <- data.frame(x = c(1,1,1), y = c("yes", "no", "yes"))

test_data_iris <- data.frame(iris) %>% select(Sepal.Length, Sepal.Width)

iris_recipe <- recipes::recipe(Sepal.Length ~ Sepal.Width, iris)
knn_iris <- knn_model(iris_recipe, iris, "Sepal.Length")

knn_prediction <- knn_iris |>
  stats::predict(iris) |>
  dplyr::bind_cols(iris)

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
  ggplot2::geom_smooth(method = "lm", se = FALSE)
helper_scatter_lm_type

helper_scatter_knn_type <- ggplot2::ggplot(knn_prediction,ggplot2::aes(x=Sepal.Width,y=Sepal.Length)) +
  ggplot2::geom_point()+
  ggplot2::labs(x="Sepal Width",y="Sepal Length")+
  ggplot2::ggtitle("Scatterplot Test")+
  ggplot2::theme(text=ggplot2::element_text(size=10))+
  ggplot2::geom_line(knn_prediction,
                     mapping = ggplot2::aes(x = Sepal.Width, y = .pred),
                     color = "blue")
helper_scatter_knn_type

#test for input variables
testthat::test_that("Function can only accept certain data types for arguments", {
  expect_error(scatter_plot(c(1,0), c(1,0), c(0,1), "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter2, x, y, "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter2, x, y, "x", "y", "title", 10, type ="lm"))
  expect_error(scatter_plot(test_data_scatter3, x, y, "x", "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, c(1,2), "y", "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", c(2,3), "title", 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", 10, 10))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", "title", "10"))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", "title", 10, "NULL"))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", "title", 10, type="asdf"))
  expect_error(scatter_plot(test_data_scatter, x, y, "x", "y", "title", 10, type=c(1,2)))
})




#test for output variables for function with type=NULL
testthat::test_that("Checks the output of the graph", {
  plot1 <- scatter_plot(test_data_scatter, x, y, "x", "y", "Scatterplot Test", 10)
  expect_true(ggplot2::is.ggplot(plot1))
  expect_equal(ggplot2::xlab(plot1)$label, ggplot2::xlab(test_data_scatter)$label)
  expect_equal(ggplot2::ylab(plot1)$label, ggplot2::ylab(test_data_scatter)$label)
  expect_equal(ggplot2::ggtitle(plot1)$label, ggplot2::ggtitle(test_data_scatter)$label)

})

#test for output variables for function with type="lm"
testthat::test_that("Checks the output of the graph", {
  plot2 <- scatter_plot(test_data_scatter, x, y, "x", "y", "Scatterplot Test", 10, type="lm")
  expect_true(ggplot2::is.ggplot(plot2))
  expect_equal(ggplot2::xlab(plot2)$label, ggplot2::xlab(test_data_scatter)$label)
  expect_equal(ggplot2::ylab(plot2)$label, ggplot2::ylab(test_data_scatter)$label)
  expect_equal(ggplot2::ggtitle(plot2)$label, ggplot2::ggtitle(test_data_scatter)$label)
})

#test for output variables for function with type="knn"
testthat::test_that("Checks the output of the graph", {
  plot3 <- scatter_plot(test_data_scatter, x, y, "x", "y", "Scatterplot Test", 10, type="knn")
  expect_true(ggplot2::is.ggplot(plot3))
  expect_equal(ggplot2::xlab(plot3)$label, ggplot2::xlab(test_data_scatter)$label)
  expect_equal(ggplot2::ylab(plot3)$label, ggplot2::ylab(test_data_scatter)$label)
  expect_equal(ggplot2::ggtitle(plot3)$label, ggplot2::ggtitle(test_data_scatter)$label)
})


#test type output of scatter_plot
#testthat::test_that("Function has the right type", {
#   plot4 <- scatter_plot(test_data_scatter, x, y, "x", "y", "Scatterplot Test", 10, type="knn")
#  expect_true(ggplot2::is.type(plot4) ,'list')
#})

