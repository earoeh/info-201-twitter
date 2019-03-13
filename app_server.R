library("shiny")
source("scripts/nordic.R")
source("scripts/education_vs_population.R")
source("scripts/developing.R")
source("scripts/capita.R")

app_server <- function(input, output) {
  
  output$capita_plot <- renderPlot({
    generate_capita_plot(input$capita_year)
  })
  
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
  
  output$industrialized_plot <- renderPlot({
    create_industrialized_plot(input$industrialized_country)
  })
  
  output$developing_plot_analysis <- renderUI({
    text1 <- paste0("The first thing to note about these plots is that all countries spend only a
                   small percentage of their GDP on education. On average, in 2011, the developing
                   countries listed here (excluding the Philippines, as data for it in 2011 wasn't
                   available) spent ", percent_expenditure_developing, "% of their GDP on
                   education. Also in 2011, the industrialized countries spent an average of ",
                   percent_expenditure_industrialized, "% of their GDP on education. These numbers
                   are quite similar, which tells us that it isn't necessarily the priority that's
                   given to education funds that determines a country's economic success.")
    text2 <- paste0("However, percentage of GDP spent on education isn't the same as raw
                   money spent on education; developing countries simply don't have as much money
                   to spend on education as industrialized countries do. While the percentages for
                   these two categories of countries are similar, the absolute amount of money that
                   developing countries spend on education is a lot less than that of
                   industrialized countries.")
    text3 <- paste0("For example, Indonesia (the developing country with the highest GDP in
                   its category) spent ", indonesia_2011_edu, " billion US dollars on education in
                   2011; India (the industrialized country with the lowest GDP in its category)
                   spent ", india_2011_edu, " billion US dollars on education, also in 2011. These
                   raw numbers are quite different and illustrate how much more money
                   industrialized countries are able to use for education.")
    text4 <- paste0("In conclusion, it is possible that spending more on education leads to a
                   higher GDP. Both industrialized and developing countries spend similar
                   percentages of their GDP on education, but industrialized countries simply have
                   a lot more money to spend than developing countries.")
    text5 <- paste0("Of course, the plots and this analysis don't take into account other
                   metrics, such as population. As such, only general conclusions and correlations
                   can be drawn from this basic analysis, and answering the question(s) posed
                   above would require more research and data about other measures that could
                   affect a country's GDP and overall education.")
    
    HTML(paste(text1, text2, text3, text4, text5, sep = "<br/>"))
  })
  
  output$education_slider <- renderUI({
    slider <- generate_slider(input$country)
  })
  
  output$population_slider <- renderUI({
    slider <- generate_slider(input$country)
  })
  
  output$education_plot <- renderPlot({
    draw_education_plot(input$country, input$year[1], input$year[2])
  })
  
  output$population_plot <- renderPlot({
    draw_population_plot(input$country, input$year[1], input$year[2])
  })
}
