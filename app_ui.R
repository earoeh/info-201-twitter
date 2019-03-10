library("shiny")

app_ui <- fluidPage(
  titlePanel("Global Economy and Education Trends"),
  tabsetPanel(
    tabPanel("Nordic Countries",
             selectInput("nordic_country",
                         label = "Nordic Country", 
                         choices = list("All", "Denmark",
                                        "Finland", "Iceland",
                                        "Norway", "Sweden")),
             selectInput("top_country",
                         label = "Top Economy Country",
                         choices = list("All", "Germany",
                                        "India", "Japan",
                                        "United Kingdom",
                                        "United States")),
             plotOutput("nordic_plot"),
             plotOutput("top_plot"))
  )
)