
library(ggplot2)
library(ggcheck)
#source(here::here("R/bar_graph.R"))
#source(here::here("tests/bar_graph_test_helper.R"))

#helper functionc

test_data <- data.frame(x = c("a", "a", "c", "b"), y = c(5, 6, 7, 8))
test_data$x <- as.factor(test_data$x)


expected_bar_graph <- ggplot2::ggplot(test_data, aes(x = x, y = y, fill = x)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(x = "x", y = "y", fill = "x") +
    ggtitle("Bar Graph Test") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          text = element_text(size = 15),
          panel.background = element_rect(fill = 'darkgrey', color = 'purple'),
          plot.title = element_text(hjust = 0.5)) +
    scale_fill_brewer(palette = 'GnBu')
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
    expect_true(is.ggplot(plot))
    expect_equal(xlab(plot)$label, xlab(test_data)$label)
    expect_equal(ylab(plot)$label, ylab(test_data)$label)
    expect_equal(ggtitle(plot)$label, ggtitle(test_data)$label)

})

