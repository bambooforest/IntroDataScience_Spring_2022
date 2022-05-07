
# Lecture 7 - Time-Series Practical

For this week’s data practical, please note that you should already have
set up your GitHub account (from [week 1](../1_introduction/README.md)),
which will have an initial README.md file in your repository’s [root
directory](https://en.wikipedia.org/wiki/Root_directory). The example in
this course’s repository is the syllabus file, which is named
[README.md](../README.md).

Now create your Time-series report. You should create the .Rmd file and
edit it in RStudio and then knit the output file into an .md file. You
have to download a dataset that you are interested in (You can find some
link here [README.md](../7_data_modelling/Datasets/README.md)). You have
to use the methods that we discussed in class and done in the two
examples ([Covid-19 cases
EU](../7_data_modelling/Datasets/Covid_19_cases_EU.csv), [Species
presence center
Italy](../7_data_modelling/Datasets/Species_Individuals_center_Italy.csv)).

Here a guideline for your report:

-   Install the packages, for this practical you’ll need these

``` setup
install.packages("tidyverse")
install.packages("tseries")
library(tidyverse)
library(tseries)
```

-   Upload the .csv and check you data
-   Explore the dataset and filter if necessary to have only one object
    (as showed in the Covid or species example)
-   Create your Time-series object

``` ts
data$Date <- as.Date(data$Date) #Format as date

data$Cases <- as.numeric(data$Cases) # Format as number

data.ts <- ts(data$Cases, start = c(2020, 2), end = c(2022, 2), frequency = 365)

is.ts(data.ts)
```

-   Plot your time-series and the Autocorrelation plot
-   Fit your time-series object in the models that we saw in class
-   Now using the Autoregressive and the Simple moving average models
    try to forecast how your time-series will develop in the future.
-   Which is the best model for your data?
-   Evaluate your results, there are limits using time-series models?
    Motivate your answer.

Remember to apply the general suggestion to your report:

-   add an appropriate header (e.g., title, author, date, output format)
-   add some headers and sub-headers
-   Add labels to the axes’ plot and add a title for each plot!
    (i.e. Covid cases Spain WN)

Have fun and try to make the report interesting for the reader!
