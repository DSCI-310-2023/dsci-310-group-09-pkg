
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ln.knn.regression

<!-- badges: start -->

# codecov badge for code coverage

[![codecov](https://codecov.io/gh/DSCI-310/dsci-310-group-09-pkg/branch/main/graph/badge.svg?token=gOMgyT71QL)](https://codecov.io/gh/DSCI-310/dsci-310-group-09-pkg)
<!-- badges: end -->

The goal of ln.knn.regression is to assist in creating a regression
analysis project from start to finish. It includes functions that help
to explore, summarize and visualize the data. It also includes functions
that directly build and visualize linear and k-nn models. Additionally,
it contains functions that can test the model’s error and accuracy.

## Installation

You can install the development version of ln.knn.regression from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DSCI-310/dsci-310-group-09-pkg")
```

## Example

This is a basic example which shows you how to use the functions for
EDA:

``` r
library(ln.knn.regression)

summarize_column(mtcars, mtcars$mpg)
#>       mean  med       sd
#> 1 20.09062 19.2 6.026948

hist_plot(mtcars, mpg, "MPG", "Count", "Histogram for MPG of Cars", 10)
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="man/figures/README-example1-1.png" width="100%" />

Here is an example of how to build a linear regression model:

``` r
mtcars_model <- linearmodel(recipes::recipe(mpg ~ hp, mtcars_training), mtcars_training)
mtcars_model
#> ══ Workflow [trained] ══════════════════════════════════════════════════════════
#> Preprocessor: Recipe
#> Model: linear_reg()
#> 
#> ── Preprocessor ────────────────────────────────────────────────────────────────
#> 0 Recipe Steps
#> 
#> ── Model ───────────────────────────────────────────────────────────────────────
#> 
#> Call:
#> stats::lm(formula = ..y ~ ., data = data)
#> 
#> Coefficients:
#> (Intercept)           hp  
#>    28.36292     -0.05863
```

Now we can create a scatter plot that shows the best fit line from the
model:

``` r
scatter_plot(mtcars_training, 
             hp, 
             mpg, 
             "Horse Power (HP)", 
             "Miles Per Gallon (mpg)",
             "Best Fit Line for MPG vs HP", 
             15,
             "lm") 
#> `geom_smooth()` using formula = 'y ~ x'
```

<img src="man/figures/README-example3-1.png" width="100%" />

Finally, we can test the model’s error by finding the RMSPE value:

``` r
mtcars_rmspe <- model_rmspe(mtcars_model, mtcars_testing, "mpg")
mtcars_rmspe
#> [1] 4.99694
```

This tells us that the model has a prediction error of around 5 miles
per gallon when tested on data it has not seen before.

## Conclusion

Overall, `ln.knn.regression` is a package than can help you perform a
linear and k-nn regression analysis from beginning to end.
