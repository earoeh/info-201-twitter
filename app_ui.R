library("shiny")
source("scripts/education_vs_population.R")

select_values <- c(all_df$Country.Name)

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
    selectInput("developing_country", label = "Developing Country to Display",
                choices = c(
                  "All", "Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal"
                )),
    
    selectInput("industrialized_country", label = "Industrialized Country to Display",
                choices = c(
                  "All", "Germany", "India", "Japan", "United Kingdom", "United States"
                ))
  ),
  
  tabPanel("About"),
  tabPanel(
    "Education spending versus population",
    div(
      style = "display:inline-block",
      selectInput(inputId = "country", label = "Country of Choice",
                  choices = select_values, selected = "United States")
    ),
    div(
      style = "display:inline-block",
      uiOutput("education_slider")
    ),
    plotOutput("education_plot")
  )
)
