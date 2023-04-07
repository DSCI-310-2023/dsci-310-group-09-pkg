#helper functions

test_data <- data.frame(x = c("a", "a", "c", "b"), y = c(5, 6, 7, 8))
test_data$x <- as.factor(test_data$x)


expected_bar_graph <- ggplot2::ggplot(test_data, ggplot2::aes(x = x, y = y, fill = x)) +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::labs(x = "x", y = "y", fill = "x") +
    ggplot2::ggtitle("Bar Graph Test") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1),
          text = ggplot2::element_text(size = 15),
          panel.background = ggplot2::element_rect(fill = 'darkgrey', color = 'purple'),
          plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::scale_fill_brewer(palette = 'GnBu')
expected_bar_graph

#test for input variables
testthat::test_that("Function can only accept certain data types for arguments", {
    expect_error(bar_graph(c(1,0,0), c(2,1), c(1,2), "x", "y", "x", "title"))
    expect_error(bar_graph(test_data, y, y, "x", "y", "x", "title"))
    expect_error(bar_graph(test_data, x, x, "x", "y", "x", "title"))
    expect_error(bar_graph(test_data, x, y, 100, "y", "x","title"))
    expect_error(bar_graph(test_data, x, y, "x", 100, "x","title"))
    expect_error(bar_graph(test_data, x, y, "x", "y", 100,"title"))
    expect_error(bar_graph(test_data, x, y, "x", "y", "x",100))
})

#test for output variables
testthat::test_that("Checks the output of the graph", {
    plot <- bar_graph(test_data, test_data$x, test_data$y, "x", "y", "x", "Bar Graph Test")
    expect_true(ggplot2::is.ggplot(plot))
    expect_equal(ggplot2::xlab(plot)$label, ggplot2::xlab(test_data)$label)
    expect_equal(ggplot2::ylab(plot)$label, ggplot2::ylab(test_data)$label)
    expect_equal(ggplot2::ggtitle(plot)$label, ggplot2::ggtitle(test_data)$label)

})

