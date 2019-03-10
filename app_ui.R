library("shiny")

app_ui <- navbarPage(
  "Global Economy and Education Trends",
  tabPanel("Home"),
  tabPanel(
    "Nordic Countries",
    div(
      style = "display:inline-block",
      selectInput("nordic_country",
        label = "Nordic Country",
        choices = list(
          "All", "Denmark",
          "Finland", "Iceland",
          "Norway", "Sweden"
        )
      )
    ),
    div(
      style = "display:inline-block",
      selectInput("top_country",
        label = "Top Economy Country",
        choices = list(
          "All", "Germany",
          "India", "Japan",
          "United Kingdom",
          "United States"
        )
      )
    ),
    plotOutput("nordic_plot"),
    plotOutput("top_plot")
  ),
  tabPanel("About")
)