# helper data
test_data_hist <- data.frame(x= c(5, 6, 7, 8, 5, 5, 6, 7, 7, 7, 7, 7, 8))
test_data_hist_2 <- data.frame(x= c("5","6","6","7"))

helper_hist <- ggplot2::ggplot(test_data_hist, ggplot2::aes(x = x)) +
  ggplot2::geom_histogram() +
  ggplot2::labs(x = "x", y = "count") +
  ggplot2::ggtitle("Histogram Test")

#test for input variables
testthat::test_that("Data parameter can only accept a dataframe as input", {
  expect_error(hist_plot(c(3,2,1), c(1,1), "x", "y", "title", 10))
  expect_error(hist_plot(5, c(1,1), "x", "y", "title", 10))
  expect_error(hist_plot("hello", c(1,1), "x", "y", "title", 10))
  expect_error(hist_plot(list(3,4,5), c(1,1), "x", "y", "title", 10))
})

testthat::test_that("var1 parameter can only accept a numerical column variable as input", {
  expect_error(hist_plot(test_data_hist, "abc", "x", "y", "title", 10))
  expect_error(hist_plot(test_data_hist, 5, "x", "y", "title", 10))
  expect_error(hist_plot(test_data_hist_2, x, "x", "y", "title", 10))
})

testthat::test_that("xlab parameter can only accept a string as input", {
  expect_error(hist_plot(test_data_hist, x, 10, "y", "title", 10))
  expect_error(hist_plot(test_data_hist, x, c(10,2,4), "y", "title", 10))
  expect_error(hist_plot(test_data_hist, x, list(1,2,3), "y", "title", 10))
})

testthat::test_that("ylab parameter can only accept a string as input", {
  expect_error(hist_plot(test_data_hist, x, "x", 10, "title", 10))
  expect_error(hist_plot(test_data_hist, x, "x", c(10,2,4), "title", 10))
  expect_error(hist_plot(test_data_hist, x, "x", list(10,2,4), "title", 10))
})

testthat::test_that("title parameter can only accept a string as input", {
  expect_error(hist_plot(test_data_hist, x, "x", "y", 10, 10))
  expect_error(hist_plot(test_data_hist, x, "x", "y", c(1,2,3), 10))
  expect_error(hist_plot(test_data_hist, x, "x", "y", list(1,2,3), 10))
})

testthat::test_that("text_size parameter can only accept a number as input", {
  expect_error(hist_plot(test_data_hist, x, "x", "y", "title", "10"))
  expect_error(hist_plot(test_data_hist, x, "x", "y", "title", list(1,2,3)))
})


#test for output variables
testthat::test_that("Checks the output of the graph", {
  plot <- hist_plot(test_data_hist, x, "x", "y", "Histogram Test", 10)
  expect_true(ggplot2::is.ggplot(plot))
  expect_equal(ggplot2::xlab(plot)$label, ggplot2::xlab(helper_hist)$label)
  expect_equal(ggplot2::ylab(plot)$label, ggplot2::ylab(helper_hist)$label)
  expect_equal(ggplot2::ggtitle(plot)$labels, ggplot2::ggtitle(helper_hist)$labels)

})
