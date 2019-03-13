library("shiny")
source("scripts/education_vs_population.R")

select_values <- c(all_df$Country.Name)
select_values <- unique(select_values)

app_ui <- navbarPage(
  "Global Economy and Education Trends",
  tabPanel(
    "About",
    h2("World Economy and Education Trends"),
    p("Our project analyzes the correlations between",
      "economic signifiers and education expenditure.",
      "We believe education needs to be a high priority",
      "for countries all over the world, and intend to",
      "demonstrate this through the analysis in our project.",
      "Our economic data comes from the World Bank, and",
      "data on education expenditure comes from the",
      "World Development Indicators. There are some gaps",
      "in the data that may cause our visualizations to",
      "look strange. If this happens, please select",
      "a different option to display."),
    p("In the GDP Per Capita, you can view the GDP and",
      "education expenditure per capita in the United Kingdom."),
    p("If you click on the Nordic Countries tab, you will",
      "find an analysis of GDP and education expenditure",
      "in Nordic countries compared to countries with the",
      "top GDPs."),
    p("The Developing Countries tab shows an analysis of",
      "GDP and education expenditure in developing countries",
      "compared to industrialized countries."),
    p("Finally, in the Education Spending versus Population",
      "tab, there is an analysis of how education spending",
      "correlates with population."),
    p("Written by Anish Prasad, Emilynn Roehrich,",
      "Hershey Lande, and Maya Sioson.")
    ),
  
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
    h2("Comparing GDP and Education Spenditure for Industrialized vs. Developing Countries"),
    p("Getting an education plays a large part in finding a job and establishing a strong
      workforce in many countries. Thus, if a country spends more on education, we would expect
      their GDP to be higher."),
    p(strong("But does spending more on education guarantee a higher GDP?"), "In order to explore
      this question, this page looks at GDP and education spenditure for countries that are
      considered to be industrialized (or have a high GDP) versus countries that are considered to
      be developing. This allows us to see if", strong("education spenditure really has an effect
      on the overall economic success of a developing country.")),
    p("The following plots graph GDP and education spenditure over time. Use the drop-down menus to
      view plots for all available countries, or select a single one from each category to examine
      the data in more detail."),
    
    div(
      style = "display:inline-block",
      selectInput("developing_country", label = "Developing Country to Display",
                  choices = c(
                    "All", "Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal"
                  ))
    ),
           
    div(
      style = "display:inline-block",
      selectInput("industrialized_country", label = "Industrialized Country to Display",
                  choices = c(
                    "All", "Germany", "India", "Japan", "United Kingdom", "United States"
                  ))
    ),
    
    plotOutput("developing_plot"),
    plotOutput("industrialized_plot"),
    
    htmlOutput("developing_plot_analysis")
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
  )
)
