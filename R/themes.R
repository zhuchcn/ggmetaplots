################################################################################
#' @title Journal style for ggplot objects
#' @description A clean theme with white background for ggplot objects.
#' @export
#' @author Chenghao Zhu
theme_journal = function(){
    theme_classic() +
        theme (
            panel.border = element_rect(size = 1 , fill = NA),
            strip.text   = element_text(size = 13),
            axis.text.x  = element_text(size = 12, color = "black"),
            axis.text.y  = element_text(size = 11, color = "black"),
            axis.ticks   = element_line(size = 1 , color = "black"),
            axis.title.x = element_text(size = 15, vjust = -2),
            axis.title.y = element_text(size = 15, vjust = 2),
            plot.margin  = margin(l = 15,  b = 15,
                                  t = 10,  r = 10, unit  = "pt")
        )
}
