# helper data
test_data_hist <- data.frame(x= c(5, 6, 7, 8, 5, 5, 6, 7, 7, 7, 7, 7, 8))

helper_hist <- ggplot2::ggplot(test_data_hist, ggplot2::aes(x = x)) +
  ggplot2::geom_histogram() +
  ggplot2::labs(x = "x", y = "count") +
  ggplot2::ggtitle("Histogram Test")

#test for input variables
testthat::test_that("Function can only accept certain data types for arguments", {
  expect_error(hist_plot(c(3,2,1), c(1,1), "x", "y", "title", 10))
  expect_error(hist_plot(test_data_hist, "abc", "x", "y", "title", 10))
  expect_error(hist_plot(test_data_hist, x, 10, "y", "title", 10))
  expect_error(hist_plot(test_data_hist, x, "x", 10, "title", 10))
  expect_error(hist_plot(test_data_hist, x, "x", "y", 10, 10))
  expect_error(hist_plot(test_data_hist, x, "x", "y", "title", "10"))
})

#test for output variables
testthat::test_that("Checks the output of the graph", {
  plot <- hist_plot(test_data_hist, x, "x", "y", "Histogram Test", 10)
  expect_true(ggplot2::is.ggplot(plot))
  expect_equal(ggplot2::xlab(plot)$label, ggplot2::xlab(helper_hist)$label)
  expect_equal(ggplot2::ylab(plot)$label, ggplot2::ylab(helper_hist)$label)
  expect_equal(ggplot2::ggtitle(plot)$labels, ggplot2::ggtitle(helper_hist)$labels)

})
