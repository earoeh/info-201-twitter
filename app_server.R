library("shiny")
source("scripts/nordic.R")
source("scripts/developing.R")

app_server <- function(input, output) {
  
  output$nordic_plot <- renderPlot({
    generate_line_plot_nordic(input$nordic_country)
  })
  
  output$top_plot <- renderPlot({
    generate_line_plot_top(input$top_country)
  })
  
  output$nordic_description <- renderText({
    if (input$nordic_country == "All") {
      nordic_country <- nordic
      nordic_country <- paste(nordic_country, collapse = ", ")
    } else {
      nordic_country <- input$nordic_country
    }
    if (input$top_country == "All") {
      top_country <- top_economies
      top_country <- paste(top_country, collapse = ", ")
    } else {
      top_country <- input$top_country
    }
    
    message <- paste("The line plots below show GDP and economic expenditure",
                     "across time. GDP is in green and economic expenditure is",
                     "in blue. Currently, the line plots compare",
                     nordic_country,
                     "of the Nordic countries and",
                     top_country,
                     "of the countries with top GDPs worldwide.",
                     "You can select which countries to display below.")
                     
  })
  
  output$nordic_analysis <- renderText({
    message <- "On average, a Nordic country spends "
    message <- paste0(message,
                      avg_nordic_expenditure_percent,
                      "% of their total GDP on education, while a country with a top GDP spends ",
                      avg_top_economy_expenditure_percent,
                      "% of their total GDP.")
    message <- paste(message,
                     "From this, it seems as though",
                     "the average Nordic country spends more on education",
                     "than the average country with a top GDP. While it",
                     "is true that the average Nordic country spends a higher",
                     "percentage of its GDP on education, the actual",
                     "figures are surprising.")
    message <- paste(message,
                     "On average, a Nordic country spends",
                     avg_nordic_expenditure,
                     "billion dollars on education, while a country with a top GDP spends",
                     avg_top_economy_expenditure,
                     "billion dollars on education.")
  })
  
  output$nordic_reasons <- renderText({
    message <- "Of course, population is a factor."
    message <- paste(message,
                     "The population of the average Nordic country is",
                     avg_nordic_pop,
                     "people. However, Iceland only has a population",
                     "of about 300,000. Thus, excluding Iceland, the average",
                     "Nordic country has a population of",
                     avg_nordic_pop_no_iceland,
                     "people. This population is tiny compared to the average",
                     "top economy country, which has",
                     avg_top_economy_pop,
                     "people.")
    message <- paste(message,
                     "However, while the average top economy country has",
                     round(avg_top_economy_pop / avg_nordic_pop_no_iceland),
                     "times more people than the average Nordic country,",
                     "they only spend",
                     round(avg_top_economy_expenditure / avg_nordic_expenditure),
                     "times as much on education.")
  })
  
  output$developing_plot <- renderPlot({
    create_developing_plot(input$developing_country)
  })
}