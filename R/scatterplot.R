################################################################################
#' @title Make a scatterplot using ggplot2
#'
#' @description This is a encapsulated function to make a scatterplot using the
#' ggplot2 package. It allows the users to control the plot color, size, and
#' other styles using arguments.
#'
#' @param data A data.frame containing all the variables needed to draw the box
#' plot.
#' @param x A character string indicating the x axis variable.
#' @param y A character string indicating the y axis variable.
#' @param cols A character string indicating the variable defines faceting
#' groups on columns.
#' @param rows A character string indicating the variable defines faceting
#' groups on rows.
#' @param color A character string indicating the variable defines the color of
#' lines or points.
#' @param trendline Logic value whether to draw a linear trandline.
#' @param trendline.color DESCRIPTION.
#' @param trendline.size DESCRIPTION.
#' @param show.points DESCRIPTION.
#' @param point.size Numeric value defines the size of points.
#' @param point.alpha Numeric value defines the transparency.
#' @param point.color Character value defines the color of points when the
#' argument 'color' is not specified.
#' @param color.pal Character vector defines the color panel to use.
#' @param show.legend Logic value defines whether to show legend.
#'
#' @return a ggplot object
#' @author Chenghao Zhu
#' @import ggplot2
#' @export
ggscatterplot = function(data,
                         x,
                         y,
                         cols,
                         rows,
                         color,
                         trendline   = TRUE,
                         trendline.color = "steelblue",
                         trendline.size = 1,
                         show.points = TRUE,
                         point.size  = 3,
                         point.alpha = 1,
                         point.color = "black",
                         color.pal   = NULL,
                         show.legend = TRUE){

    if(missing(color)) color = NULL
    if(is.null(color) & !is.null(color.pal)){
        color.pal = NULL
        warning("[ ggmetaplot ] Ignored the color.pal argument because the color is not specified")
    }
    facet_cols = if(!missing(cols)) vars(!!sym(cols)) else vars()
    facet_rows = if(!missing(rows)) vars(!!sym(rows)) else vars()
    # add color to it if color is specified.
    my_geom_point = function(){
        if(is.null(color)){
            geom_point(size = point.size, alpha = point.alpha,
                       color = point.color)
        }else{
            geom_point(aes_string(color = color),
                       size = point.size, alpha = point.alpha)
        }
    }

    p = ggplot(data, aes(x=!!sym(x), y=!!sym(y))) +
        my_geom_point() +
        theme_bw()
    # trendline
    if(trendline == TRUE)
        p = p + stat_smooth(method = "lm", color = trendline.color,
                            size = trendline.size)
    # facet
    if(!missing(cols) | !missing(rows))
        p = p + facet_grid(rows = facet_rows, cols = facet_cols)
    # color pal
    if(!is.null(color.pal)){
        color_pal = colorRampPalette(colors = color.pal)(length(unique(data[,color])))
        p = p + scale_color_manual(values = color_pal)
    }
    # hide legend
    if(!show.legend)
        p = p + theme(legend.position = "none")

    return(p)
}
