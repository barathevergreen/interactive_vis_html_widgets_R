#' Helpers to use highcharter as input in shiny apps
#' 
#' When you use highcharter in a shiny app, for example
#' \code{renderHighcharter('my_chart')}, you can access to the actions of the
#' user using and then use the \code{hc_add_event_point} via the 
#' \code{my_chart} input (\code{input$my_chart}). That's a way you can
#' use a chart as an input.
#' 
#' @param hc A \code{highchart} \code{htmlwidget} object. 
#' @param series The name of type of series to apply the event.
#' @param event The name of event: click, mouseOut,  mouseOver. See 
#'   \url{http://api.highcharts.com/highcharts/plotOptions.areasplinerange.point.events.select}
#'   for more details.
#'   
#' @note Event details are accessible from hc_name_EventType, i.e. if a highchart is rendered against output$my_hc and
#'     and we wanted the coordinates of the user-clicked point we would use input$my_hc_click
#' 
#' @export
hc_add_event_point <- function(hc, series = "series", event = "click"){
  
  fun <- paste0("function(){
                var pointinfo = {series: this.series.name, seriesid: this.series.id,
                name: this.name, x: this.x, y: this.y, category: this.category.name}
                window.x = this;
                console.log(pointinfo);
                
                if (typeof Shiny != 'undefined') { Shiny.onInputChange(this.series.chart.renderTo.id + '_' + '", event, "', pointinfo); }
}")

  fun <- JS(fun)
  
  eventobj <- structure(
    list(structure(
      list(structure(
        list(structure(
          list(fun),
          .Names = event)
        ),
        .Names = "events")
      ),
      .Names = "point")
    ),
    .Names = series
  )
  
  hc$x$hc_opts$plotOptions <- rlist::list.merge(
    hc$x$hc_opts$plotOptions,
    eventobj
  )
  
  hc
  
  }

#' @rdname hc_add_event_point
#' @export
hc_add_event_series <- function(hc, series = "series", event = "click"){
  
  fun <- paste0("function(){
                var seriesinfo = {name: this.name }
                console.log(seriesinfo);
                window.x = this;
                if (typeof Shiny != 'undefined') { Shiny.onInputChange(this.chart.renderTo.id + '_' + '", event, "', seriesinfo); }
                
}")
  fun <- JS(fun)
  
  eventobj <- structure(
    list(structure(
      list(structure(
        list(fun),
        .Names = event)
      ),
      .Names = "events")
    ),
    .Names = series
  )
  
  hc$x$hc_opts$plotOptions <- rlist::list.merge(
    hc$x$hc_opts$plotOptions,
    eventobj
  )
  
  hc
  
  }