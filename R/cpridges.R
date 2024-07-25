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
cpridges <- function(data = PIdata, signal = `PI Obj Integral`, group = Cells){
  signal <- enquo(signal)
  group <- enquo(group)

  data %>%
    ggplot(aes(x = !!signal, y = !!group)) +
    geom_density_ridges(aes(color = !!group),
                        fill = NA,
                        scale = 0.99) +
    geom_density_ridges(aes(fill = !!group),
                        color = NA,
                        stat = "binline",
                        bins = 200,
                        alpha = 0.3,
                        scale = 0.99) +
    labs(y = "") +
    theme_bw() +
    theme(panel.grid = element_blank(),
          legend.position = "none")
}
