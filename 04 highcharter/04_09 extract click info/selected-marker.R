
#if scatterplot click is empty it returns nothing
#else displays the coordinates
output$click_ui <- renderUI({
  if (is.null(input$scatter_plot_click)) {
    return()
  }
  print(input$scatter_plot_click)
  wellPanel(
    "Coordinates of clicked point: ",
    input$scatter_plot_click$x,
    input$scatter_plot_click$y
  )
  
})

#if scatterplot mouse over is empty it returns nothing
#else displays the coordinates
output$mouseOver_ui <- renderUI({
  if (is.null(input$scatter_plot_mouseOver)) {
    return()
  }
  print(input$scatter_plot_mouseOver)
  wellPanel(
    "Coordinates of mouseOvered point: ",
    input$scatter_plot_mouseOver$x,
    input$scatter_plot_mouseOver$y
  )
  
})