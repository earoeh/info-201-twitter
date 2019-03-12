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
  
  tabPanel("Developing Countries",
    div(
      style = "display:inline-block",
      selectInput("developing_country", label = "Developing Country to Display",
                  choices = c(
                    "All", "Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal"
                  ))
    ),
    
    plotOutput("developing_plot"),
    
    div(
      style = "display:inline-block",
      selectInput("industrialized_country", label = "Industrialized Country to Display",
                  choices = c(
                    "All", "Germany", "India", "Japan", "United Kingdom", "United States"
                  ))
    ),
    
    plotOutput("industrialized_plot")
  )
  
  # tabPanel("About"),
  # tabPanel(
  #   "Education spending versus population",
  #   div(
  #     style = "display:inline-block",
  #     selectInput(inputId = "country", label = "Country of Choice",
  #                 choices = select_values, selected = "United States")
  #     ),
  #   div(
  #     style = "display:inline-block",
  #     sliderInput(inputId = "year", label = "Year Range:",
  #                 min = 1970, max = 2018, value = c(2002, 2017)),
  #   ),
  #   plotOutput("education_plot"),
  # )
)
