# Shiny Beginners Training

Shiny training for relatively novice R users.

## Preparation

For the course you can either use the NHS-R Community cloud which has everything
set up or you can download all the course material to your own laptop.
[Instructions for the NHS-R Community introduction to R and R Studio](https://philosopher-analyst.netlify.app/collection/nhsr-intro/prework/) 
are same up to the point of installing packages.

You can also type the following code into the `Console`:

``` r
# install.packages("usethis")
usethis::use_course("ChrisBeeley/shiny_beginners")

```

which downloads the zip from this page, creates a project in a default location 
and unzips the documents ready to use. You will be asked to confirm whether or 
not to delete the zip file.

Note that the {usethis} package must be downloaded first to run and has been 
commented out in this example code.

Other packages that need to be installed for this course are:

```r

install.packages("tidyverse")
install.packages("DiagrammeR")
install.packages("rmarkdown")
install.packages("shiny")
install.packages("DT")
install.packages("lubridate")

```

