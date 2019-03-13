library("shiny")
source("scripts/education_vs_population.R")

select_values <- c(all_df$Country.Name)
select_values <- unique(select_values)

app_ui <- navbarPage(
  "Global Economy and Education Trends",
  tabPanel("Home"),
  
  tabPanel(
    "GDP Per Capita",
    sliderInput(inputId = "capita_year", label = "Year:",
                min = 1970, max = 2018, value = 2000, sep = ""),
    plotOutput("capita_plot")
  ),
  
  tabPanel(
    "Nordic Countries",
    h2("Comparing Nordic Education to Countries with Top GDP"),
    p(
      "Nordic countries such as Finland are constantly",
      "in the media due to their education system.",
      "Advertised as being free from primary education",
      "to university, the Nordic education system is often",
      "praised. In this section, the following question will",
      "be addressed:"
    ),
    p(strong(
      "What is the difference between education in",
      "Nordic countries and other industrialized countries?",
      "Is free education feasible in countries like the",
      "United States?"
    )),
    textOutput("nordic_description"),
    div(
      style = "display:inline-block",
      selectInput("nordic_country",
                  label = "Nordic Country to Display",
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
                  label = "Top Economy Country to Display",
                  choices = list(
                    "All", "Germany",
                    "India", "Japan",
                    "United Kingdom",
                    "United States"
                  )
      )
    ),
    plotOutput("nordic_plot"),
    plotOutput("top_plot"),
    textOutput("nordic_analysis"),
    p("So how is it that Nordic countries have free education",
      "while spending so much less than the countries with the top GDPs?"),
    textOutput("nordic_reasons"),
    p("It is clear that the priorities of Nordic countries",
      "and countries with top GDPs are quite different.",
      "While Nordic countries are known for being the happiest",
      "in the world partially due to their education system",
      "countries with the top GDPs would rather spend their",
      "money elsewhere."),
    p("While it is hard to tell whether free education is",
      "feasible in countries such as the United States just",
      "from economic data due to so many external factors,",
      "it seems that spending more on education may lead",
      "to a happier country.")
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
  ),
  
  tabPanel(
      "Education Spending Versus Population",
      h2("Comparing Country Education to Country Population Over Time"),
      p("Educatuion leads to higher living standards, and median incomes.",
        "The average person spends 19 years in school",
        "In this section, the following question will",
        "be addressed:"
      ),
      p(strong(
        "1. What is the difference between education budgeting through time in",
        "relation to population growth? \n",
        "2. Is the government in the specified countries giving more importance", 
        "to education as population is increase?"
      )),
      div(
        style = "display:inline-block",
        selectInput("country", "Country of Choice",
                    select_values, "Greece")
        ),
      div(
        uiOutput("education_slider")
      ),
  
     plotOutput("education_plot"),
     plotOutput("population_plot"),
     
     p("So how have the countries changed their education budgeting 
       through the years?"),
     p("When you take a look at the different countries you see various 
        different patterns of ups and downs. Though most countries have 
        wavy trends, their overall trendline through a certain year range 
        is either upwards or downwards."),
     p("When observing countries such as Japan or United States, that are
        well established as their populations are increasing their budget 
        for education is also decreasing. While under developed countries
        such as Costa Rica, Senegal and even Greece seem to be increasing 
        the amount of money spent as their population increases. This shows
        that the more developed countries are valuing other things more such 
        as military budgeting, or other fundings than education's while the 
        developing countries are willing to spend more on education as this 
        can in turn bring awareness, and create more jobs for their country 
        and economy.")
  ),
  tabPanel("About")
)
