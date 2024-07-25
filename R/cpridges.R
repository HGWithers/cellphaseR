#' Create a ridge plot with histogram and kernel density estimates for each group of data.
#'
#' @param data A dataframe or tibble with DNA content data.
#' @param signal Column name containing the measurement values for DNA content staining (e.g. object integral for PI staining)
#' @param group Column name containing the treatment condition or unique sample ID to split the data on.
#'
#' @return A ggplot object for ridgeplots.
#' @import magrittr ggplot2 dplyr ggridges
#' @export
#'
#' @examples
#' cpridges(data = PIdata, signal = "PI Obj Integral", group = "Cells")
cpridges <- function(data, signal, group){
  data %>%
    ggplot(aes(x = signal)) +
    geom_density(aes(color = group)) +
    theme_bw()
}
