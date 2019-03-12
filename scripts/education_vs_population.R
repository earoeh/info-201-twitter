library("ggplot2")
library("dplyr")
library("tidyr")
options(scipen = 999)


#Wrangles data for popualtion and education data 
economic <- read.csv(file = "data/economics.csv", stringsAsFactors = FALSE) 
population <- select(economic, -c(X, Country.Code, Cash.Surplus:GDP))

education <- read.csv(file = "data/wdi_education_cleaned.csv", stringsAsFactors = FALSE)
education <- select(education, -c(Country.Code : Indicator.Code))

education_long<- gather(        #gathers data long shape
<<<<<<< HEAD
    education,
    key = year,
    value = education_budget,
    -Country.Name
)
=======
  education,
  key = year,
  value = education_budget,
  -Country.Name
) 
>>>>>>> education_vs_population

education <- mutate(education_long, Year = as.numeric(substr(education_long$year, 2, nchar(education_long$year))))

education$year <- NULL

<<<<<<< HEAD
all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year")) %>% drop_na()
=======
#combines all data that was filtered and selected
all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year")) %>% drop_na()

#Takes in a country, and a year range
#generates a plot of based on the given country, and year range
#of year vs population
draw_population_plot <- function(country, year1, year2){
  filtered_df <- filter(all_df, Country.Name == country, Year > year1 & Year < year2)
  
  p <- ggplot(data = filtered_df) + 
    geom_area(mapping = aes_string(x = "Year", y = "Population"), fill = "palegreen3", alpha = 0.7) +
    labs(
      title = paste0("Population in ", country, " from ", year1, " to ", year2), # plot title
      x = "Year",
      y = "Population (in billions)",
      color = ""
    )
  
  p
}

#Takes in a country, and a year range
#generates a plot of based on the given country, and year range
#of year vs education budget
draw_education_plot <- function(country, year1, year2){
  filtered_df <- filter(all_df, Country.Name == country, Year > year1 & Year < year2)
  
  p <- ggplot(data = filtered_df) + 
    geom_area(mapping = aes_string(x = "Year", y = "education_budget"), fill = "steelblue3", alpha = 0.7) + 
    labs(
      title = paste0("Education Budget in ", country, " from ", year1, " to ", year2), # plot title
      x = "Year",
      y = "Education Budget (% of GDP)",
      color = ""
    ) 
  p
}

#Takes in a country, and a year range
#generates a plot of based on the given country, and year range
#
generate_slider <- function(country){
  filtered_df <- filter(all_df, Country.Name == country)
  slider <- tagList(
    sliderInput("year", "Year Range:", filtered_df[1, "Year"], filtered_df[nrow(filtered_df), "Year"], c(filtered_df[1, "Year"], filtered_df[nrow(filtered_df), "Year"]))
  )
  slider
}
>>>>>>> education_vs_population
