
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cellphaseR

<!-- badges: start -->
<!-- badges: end -->

cellphaseR is an R package for the analysis of cell cycle experiments
generated on the BioTek Cytation platform. It is primarily an
implementation of
[ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
and
[ggridges](https://cran.r-project.org/web/packages/ggridges/index.html)
packages for visualization and analysis of object level DNA content
measurements by propidium iodide (PI) staining. Although not tested
here, this package should be applicable to any other staining methods
that are indicative of relative DNA content.

## Installation

You can install the development version of cellphaseR like so:

``` r
# install.packages("devtools")
devtools::install_github("HGWithers/cellphaseR")
```

## Example Dataset

An example dataset `PIdata` is provided with the package that contains
imaging data for PI stained cells from two different cell types:
wildtype (WT) mouse embryonic fibroblasts (wtMEF) or p53 knockout MEFs
transduced with HRas-V12-GFP oncogene.

``` r
## Load the library
library(cellphaseR)

## View the example dataset
PIdata
#> # A tibble: 7,570 × 8
#>    Well  Cells `PI Obj Integral` `Object Index` `PI Obj Size` `PI Obj Area`
#>    <chr> <chr>             <dbl>          <dbl>         <dbl>         <dbl>
#>  1 D4    wtMEF            301821            154          12             101
#>  2 D4    wtMEF            544126            252          11.4           101
#>  3 D4    wtMEF            324017            524          11.6           101
#>  4 D4    wtMEF            319824            553          11.4           101
#>  5 D5    wtMEF            312154             58          12.1           101
#>  6 D5    wtMEF            677514            114          11.4           101
#>  7 D5    wtMEF            327071            139          11.7           101
#>  8 D5    wtMEF            497192            153          11.5           101
#>  9 D5    wtMEF            314237            175          11.6           101
#> 10 D5    wtMEF            322754            244          11.4           101
#> # ℹ 7,560 more rows
#> # ℹ 2 more variables: `PI Obj Mean` <dbl>, `PI Obj Peak` <dbl>
```

The `cpridges` function generates a histogram with kernel density
estimate overlay for your DNA content data. Here we use the
`PI Obj Integral` output value from the example `PIdata` to plot cell
cycle data by each cell type (`group = Cells`)

``` r
cpridges(data = PIdata, signal = `PI Obj Integral`, group = Cells)
#> Picking joint bandwidth of 152000
```

<img src="man/figures/README-cpridges_example-1.png" width="100%" />
