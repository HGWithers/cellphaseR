#' Create a ridge plot with histogram and kernel density estimates for each group of data.
#'
#' @param data A dataframe or tibble with DNA content data.
#' @param signal Column name containing the measurement values for DNA content staining (e.g. object integral for PI staining)
#' @param group Column name containing the treatment condition or unique sample ID to split the data on.
#' @param x.log Logical indicating whether to log10 transform the x-axis (default = FALSE).
#' @param bins Define the number of bins for the histogram (default = 300).
#' @param label.peaks Logical indicating whether to provide the x-axis value for peaks identified using the `ggpmsic::find_peaks` function (default = FALSE).
#' @param peak.threshold Numeric value between 0 and 1 defining the threshold below which peaks will be ignored (default = 0.1). Passed to the `find_peaks` function from the ggpmisc package.
#'
#' @return A ggplot object for ridgeplots with histogram and kernel density estimates.
#' @import magrittr ggplot2 dplyr ggridges ggpmisc
#' @export
#'
#' @examples
#' cpridges(data = PIdata, signal = `PI Obj Integral`, group = Cells)
cpridges <- function(data = PIdata, signal = `PI Obj Integral`, group = Cells,
                     x.log = FALSE, bins = 300,
                     label.peaks = FALSE, peak.threshold = 0.1){

  ## Make input arguments dplyr friendly
  signal <- enquo(signal)
  group <- enquo(group)

  main.plot <- data %>%
    ggplot(aes(x = !!signal, y = !!group)) +
    geom_density_ridges(aes(color = !!group),
                        fill = NA,
                        scale = 0.99) +
    geom_density_ridges(aes(fill = !!group),
                        color = NA,
                        stat = "binline",
                        bins = bins,
                        alpha = 0.25,
                        scale = 0.99) +
    labs(y = "") +
    scale_y_discrete(expand = expansion(mult = c(0.1, 1.1))) +
    theme_bw() +
    theme(panel.grid = element_blank(),
          legend.position = "none")

  if(label.peaks == TRUE){

    ## Calculate kernel densities for each group and find peaks
    density.data <- data %>%
      group_by(!!group) %>%
      reframe(den.x = density(!!signal)$x,
                den.y = density(!!signal)$y) %>%
      ungroup() %>%
      group_by(!!group) %>%
      mutate(peak = ggpmisc::find_peaks(den.y, ignore_threshold = peak.threshold)) %>%
      ungroup() %>%
      filter(peak == TRUE)

    main.plot <- main.plot +
      geom_text(data = density.data, aes(x = den.x,
                                         # y = 2,
                                         label = formatC(den.x, format = "e", digits = 2),
                                         color = !!group),
                hjust = 0, angle = 90,
                size = 3,
                nudge_y = 0.01)
  }

  if(x.log == TRUE){
    main.plot <- main.plot +
      scale_x_log10()
  }

    return(main.plot)
}
