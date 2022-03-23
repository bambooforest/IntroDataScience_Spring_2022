Data visualization II
================
Steven Moran & Alena Witzlack-Makarevich

23 March, 2022

-   [Visualizing data](#visualizing-data)
    -   [Recap](#recap)
        -   [Data](#data)
        -   [Geometries](#geometries)
        -   [Facets](#facets)
        -   [Statistics](#statistics)
        -   [Coordinates](#coordinates)
        -   [Theme](#theme)
    -   [Which plot to use?](#which-plot-to-use)

------------------------------------------------------------------------

This report uses the [R programming
language](https://cran.r-project.org/doc/FAQ/R-FAQ.html) (R Core Team
2021) and the following [R libraries](https://r-pkgs.org/intro.html)
(Hadley Wickham et al. 2019; Xie 2021; Hadley Wickham 2016).

``` r
library(tidyverse)
library(knitr)
library(ggplot2) # we do not actually need to load this because it comes with the tidyverse library
```

------------------------------------------------------------------------

# Visualizing data

## Recap

Recall the discussions on [visualizing
data](https://github.com/bambooforest/IntroDataScience/tree/main/5_data_visualization#visualizing-data)
and the [layered graphics
principles](https://github.com/bambooforest/IntroDataScience/tree/main/5_data_visualization#layered-graphics)
of [data
visualization](https://en.wikipedia.org/wiki/Data_visualization).

The basic idea is that you can build data visualizations from data and
mappings between the data’s variables and aesthetic attributes by
plotting them on a [coordinate
system](https://en.wikipedia.org/wiki/Coordinate_system).

Here is a cheat sheet describing the process:

-   <https://github.com/rstudio/cheatsheets/blob/main/data-visualization-2.1.pdf>

------------------------------------------------------------------------

In this course we are using the tidyverse visualization library
`ggplot2` (Hadley Wickham 2016).

The book on using the `ggplot2` library is [*ggplot2: Elegant Graphics
for Data Analysis*](https://ggplot2-book.org/index.html).

A simple plot with `ggplot()` needs minimally:

-   Data to visualize – a data frame or tibble!
-   Aesthetics – mappings from aesthetic attributes (e.g., color, shape,
    size) to geometric objects (e.g., points, lines, bars)
-   Geometries – e.g., dots, lines, boxes

These essential ingredients (bordered in red) for creating a plot with
`ggplot()` are illustrated below in a visualization within the layered
grammar of graphics (H. Wickham 2009).

![Essentials.](../5_data_visualization/figures/essential_ingredients.png)

But let’s go through each in detail – but from bottom up.

### Data

A plot is the information you wish to visualized from some source of
data. Recall our discussion about the difference between [data and
information](https://github.com/bambooforest/IntroDataScience/tree/main/3_data#what-is-data).

Let’s use the integrated `diamonds` data set in R. What does a data
scientist do? First have a look at the data!

``` r
?diamonds
str(diamonds)
```

    ## tibble [53,940 × 10] (S3: tbl_df/tbl/data.frame)
    ##  $ carat  : num [1:53940] 0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
    ##  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
    ##  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
    ##  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
    ##  $ depth  : num [1:53940] 61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
    ##  $ table  : num [1:53940] 55 61 65 58 58 57 57 55 61 61 ...
    ##  $ price  : int [1:53940] 326 326 327 334 335 336 336 337 337 338 ...
    ##  $ x      : num [1:53940] 3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
    ##  $ y      : num [1:53940] 3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
    ##  $ z      : num [1:53940] 2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...

``` r
head(diamonds) %>% kable()
```

| carat | cut       | color | clarity | depth | table | price |    x |    y |    z |
|------:|:----------|:------|:--------|------:|------:|------:|-----:|-----:|-----:|
|  0.23 | Ideal     | E     | SI2     |  61.5 |    55 |   326 | 3.95 | 3.98 | 2.43 |
|  0.21 | Premium   | E     | SI1     |  59.8 |    61 |   326 | 3.89 | 3.84 | 2.31 |
|  0.23 | Good      | E     | VS1     |  56.9 |    65 |   327 | 4.05 | 4.07 | 2.31 |
|  0.29 | Premium   | I     | VS2     |  62.4 |    58 |   334 | 4.20 | 4.23 | 2.63 |
|  0.31 | Good      | J     | SI2     |  63.3 |    58 |   335 | 4.34 | 4.35 | 2.75 |
|  0.24 | Very Good | J     | VVS2    |  62.8 |    57 |   336 | 3.94 | 3.96 | 2.48 |

Now one way forward is to ask:

-   Which kinds of visualizations can we produce?
-   Which kind of research questions can be answered on the basis of
    this data set?

### Geometries

Geometries – or “geoms” for short – are fundamental to building
visualizations with `ggplot2`. Geoms determine the type of the plot and
are labeled like There are [several basic plot
types](https://ggplot2-book.org/individual-geoms.html), e.g., but
definitely not limited to:

-   geom_point() – produces a scatterplot
-   geom_line() – makes a line plot
-   geom_bar(stat = “identity”) – makes a bar chart

<!--
Here is a more comprehensive list:
geom functions  Description
geom_bar    bars with bases on the x axis
geom_boxplot    a box-and-whiskers plot
geom_density    a smooth density estimate calculated by stat_density
geom_histogram  a histogram
geom_line   connects observations ordered by the x value
geom_point  represents observations as points, as in a scatterplot
geom_jitter points jittered (usually to reduce overplotting)
geom_smooth adds a smoothed conditional mean
geom_text   adds textual annotations
geom_tile   a tile plane with rectangles
-->

Let’s have a look. What are we plotting?

``` r
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

Now, each geom function has mandatory and optional aesthetics. This
reference table is taken from (**Teutonico2015?**):

![Geoms and their aesthetics.](figures/geoms.png)

It is important to note that function names may change in programming
languages – so always reference the latest version of the programming
language or library that you are using!

The `geom_point()` function requires the `x` and `y` aesthetic, but can
additionally take the optional aethestics: `alpha`, `color`, `fill`,
`shape`, and `size`. You can use these aesthetics to visualize your data
in other ways.

Color? What does it do?

``` r
ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + 
  geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

Each point is colored according to values in the variable `clarity`.
Change the variable, change the color’s attribute.

``` r
ggplot(diamonds, aes(x=carat, y=price, color=color)) + 
  geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

Some aesthetics can be combined. What’s happening here?

``` r
ggplot(diamonds, aes(x=carat, y=price, color=clarity, size=cut)) + 
  geom_point()
```

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- --> What’s
happening here?

``` r
ggplot(diamonds, aes(x=carat, y=price, color=clarity, shape=cut)) + 
  geom_point()
```

    ## Warning: Using shapes for an ordinal variable is not advised

![](README_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Geoms can be stacked on top of each other – one reason they are so
powerful. What if you want to visualize a general trend in the data? How
about the default [smoothed conditional
means](https://ggplot2.tidyverse.org/reference/geom_smooth.html) of the
response values of the explanatory variables (aka predictors) (see also
[linear regression](https://en.wikipedia.org/wiki/Linear_regression)?

What trend do we see?

``` r
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point() + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](README_files/figure-gfm/unnamed-chunk-9-1.png)<!-- --> Geoms in
`ggplot2` have sensible defaults. Above the gray area encompassing the
curve is the [confidence
interval](https://en.wikipedia.org/wiki/Confidence_interval), which
visualized how much uncertainty is in smoothed curve.

Again, we can begin to explore the data from various angles by using
combinations of geoms and their aesthetics. For example, so that we can
compare multiple trends within the same data set.

``` r
ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + 
  geom_point() + 
  geom_smooth(se=FALSE)
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](README_files/figure-gfm/unnamed-chunk-10-1.png)<!-- --> Sometimes
the combinations of geoms and their aesthetics can make the picture more
or less clear. Data visualization is about achieving clarity (and style)
in how you communicate information gleaned from data. Sometimes less is
more.

``` r
ggplot(diamonds, aes(x=carat, y=price, color=clarity)) + 
  geom_smooth(se=FALSE)
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

An important way of making your visualizations clear to your audience is
to annotate (aka label) them!

``` r
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  ggtitle("Number of carets vsrsus their price") +
  xlab("Weight of the dimaon (carats)") +
  ylab("Price in US dollars")
```

![](README_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

And as we’ve noted before, there are often many different ways to write
code that it creates the same output. Keep this in mind when reading
other people’s code!

### Facets

A powerful tool for exploratory data analysis is
[faceting](https://ggplot2-book.org/facet.html) with `ggplot`.

What happens here?

``` r
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  facet_wrap(~ clarity)
```

![](README_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

And here? Note the tilde `~` basically means “explained by.”

``` r
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  facet_grid(color ~ clarity)
```

![](README_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

### Statistics

A visualization may also contain **statistical information**, e.g., a
regression line, from the data, which is drawn on a specific coordinate
system.

We saw an example above.

``` r
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point() + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](README_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

### Coordinates

### Theme

[Themes](https://ggplot2-book.org/polishing.html) are a way to finely
tune your plots. They give you control of things like the background,
fonts, text orientation.

## Which plot to use?

It depends on your data.

Additionally, **faceting** can be used to generate different subplots of
a plot by some number of one or more discrete variables.

Let’s look at some examples.

------------------------------------------------------------------------

``` r
library(tidyverse)
library(dslabs)
data(murders)
head(murders)
```

    ##        state abb region population total
    ## 1    Alabama  AL  South    4779736   135
    ## 2     Alaska  AK   West     710231    19
    ## 3    Arizona  AZ   West    6392017   232
    ## 4   Arkansas  AR  South    2915918    93
    ## 5 California  CA   West   37253956  1257
    ## 6   Colorado  CO   West    5029196    65

![](README_files/figure-gfm/first-example,%20ggplot-example-plot-0-1.png)<!-- -->

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-R" class="csl-entry">

R Core Team. 2021. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-Wickham2009" class="csl-entry">

Wickham, H. 2009. *Ggplot: Using the Grammar of Graphics with r*.

</div>

<div id="ref-Wickham2016" class="csl-entry">

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

</div>

<div id="ref-tidyverse" class="csl-entry">

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy
D’Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019.
“Welcome to the <span class="nocase">tidyverse</span>.” *Journal of Open
Source Software* 4 (43): 1686. <https://doi.org/10.21105/joss.01686>.

</div>

<div id="ref-knitr" class="csl-entry">

Xie, Yihui. 2021. *Knitr: A General-Purpose Package for Dynamic Report
Generation in r*. <https://yihui.org/knitr/>.

</div>

</div>
