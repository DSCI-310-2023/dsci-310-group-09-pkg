
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ln.knn.regression

<!-- badges: start -->
# codecov badge for test coverage
<a href="https://codecov.io/gh/DSCI-310/dsci-310-group-09-pkg" > 
 <img src="https://codecov.io/gh/DSCI-310/dsci-310-group-09-pkg/branch/main/graph/badge.svg?token=gOMgyT71QL"/> 
 </a>
<!-- badges: end -->

The goal of ln.knn.regression is to assist in creating a regression
analysis project. It includes functions that help to explore and
summarize the data. It also includes functions that directly build
linear and k-nn models. Additionally, it contains functions that can
test the model’s error and accuracy.

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

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.

Another useful function in this package is `scatter_plot()`. It takes in
the variables `var1`,`var2`, the labels of the x-axis `xlab` and for the
y-axis `ylab`, a title of the scatter plot `title`, and `text_size` to
specify the size of text of the labels and title.

The useful function allows you to generate a simple scatter plot with
the essential parameters to aid the visualization of your analysis. It
makes sure that each parameter is the right type whether it is a data
frame, numeric value, or string and produces an error if one does not
have the right type of input.
