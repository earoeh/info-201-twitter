library("shiny")
source("scripts/nordic.R")

app_server <- function(input, output) {
  
  output$nordic_plot <- renderPlot({
    generate_line_plot_nordic(input$nordic_country)
  })
  
  output$top_plot <- renderPlot({
    generate_line_plot_top(input$top_country)
  })
  
}