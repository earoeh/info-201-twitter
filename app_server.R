library("shiny")
source("scripts/nordic.R")
source("scripts/education_vs_population.R")

app_server <- function(input, output) {
  
  output$nordic_plot <- renderPlot({
    generate_line_plot_nordic(input$nordic_country)
  })
  
  output$top_plot <- renderPlot({
    generate_line_plot_top(input$top_country)
  })
  
  output$education_slider <- renderUI({
    all_df < filter(all_df, input$country)
    slider <- tagList(
      sliderInput("year", "Year Range:", all_df[1], all_df[nrow(all_df)], c(all_df[1], all_df[nrow(all_df)]))
    )
    slider # return
  })
  
  output$education_plot <- renderPlot({
    ggplot(data = all_df) + 
      geom_line(mapping = aes_string(x = "Year", y = "Population")) + 
      geom_line(mapping = aes_string(x = "Year", y = "education_budget")) + 
      labs(
        title = paste0("Population Density and Education Budget in ", input$country, " from ", input$year[1], " to ", input$year[2]) # plot title
      ) 
  })
}
