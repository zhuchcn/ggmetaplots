################################################################################
#' @title Make a boxplot using ggplot2
#'
#' @description This is a encapsulated function to make a boxplot using the
#' ggplot2 package. When parsing a cross-over study or repeated measure data,
#' lines can be drawn between the 2 points belong to the same entity in
#' different timepoints.
#'
#' @param data A data.frame containing all the variables needed to draw the box
#' plot.
#' @param x A character string indicating the x axis variable.
#' @param y A character string indicating the y axis variable.
#' @param cols A character string indicating the variable defines faceting
#' groups on columns.
#' @param rows A character string indicating the variable defines faceting
#' groups on rows.
#' @param show.points Logic value indicates whether to show points.
#' @param line A character string indicating the variable used to draw lines
#' between points.
#' @param color A character string indicating the variable defines the color of
#' lines or points.
#' @param jitter Numeric value defines the amount of horizontal jitter.
#' @param box.size Numeric value defines the size of the box.
#' @param whisker.size Numeric value defines the size of whisker.
#' @param whisker.width Numeric value defines the width of boxplot
#' @param point.size Numeric value defines the size of points.
#' @param point.alpha Numeric value defines the transparency.
#' @param point.color Character value defines the color of points when the
#' argument 'color' is not specified.
#' @param color.pal Character vector defines the color panel to use.
#' @param show.legend Logic value defines whether to show legend.
#'
#' @return A ggplot object
#' @export
#' @import ggplot2
#' @author Chenghao Zhu
ggboxplot = function(data,
                     x,
                     y,
                     cols,
                     rows,
                     line,
                     color,
                     show.points   = TRUE,
                     jitter        = 0,
                     box.size      = 0.5,
                     whisker.size  = 0.5,
                     whisker.width = 0.5,
                     point.size    = 3,
                     point.alpha   = 0.5,
                     point.color   = "black",
                     color.pal     = NULL,
                     show.legend   = TRUE){
    # force color.pal to be null when color is not specified.
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
                       color = point.color,
                       position = position_jitter(w=jitter))
        }else{
            geom_point(aes_string(color = color),
                       size = point.size, alpha = point.alpha,
                       position = position_jitter(w=jitter))
        }
    }
    # main plotting part
    p = ggplot(data,aes(x = !!sym(x), y = !!sym(y))) +
        geom_boxplot(outlier.shape = NA, size = box.size) +
        stat_boxplot(geom = "errorbar", width = whisker.width,
                     size = whisker.size) +
        theme_bw() +
        theme(strip.text = element_text(size = 13))
    # facet
    if(!missing(cols) | !missing(rows))
        p = p + facet_grid(rows = facet_rows, cols = facet_cols)
    # show points
    if(show.points){
        p = p + my_geom_point()
    }
    # line
    if(!missing(line))
        p = p + geom_line(aes_string(group = line, color = color))
    # color panel
    if(!is.null(color.pal)){
        col_num = length(unique(data[,color]))
        mypal = colorRampPalette(colors = color.pal)
        p = p + scale_color_manual(
            values = mypal(col_num))
    }
    # hide legend
    if(!show.legend)
        p = p + theme(legend.position = "none")

    return(p)
}

