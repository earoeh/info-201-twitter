library("ggplot2")
library("tidyr")
options(scipen = 999)


economic <- read.csv(file = "data/economics.csv", stringsAsFactors = FALSE) 
population <- select(economic, -c(X, Country.Code, Cash.Surplus:GDP))

education <- read.csv(file = "data/wdi_education_cleaned.csv", stringsAsFactors = FALSE)
education <- select(education, -c(Country.Code : Indicator.Code))
education<- gather(        #gathers data long shape
    education,
    key = year,
    value = education_budget,
    -Country.Name
) %>% with(education_long[order(Country.Name) , ])

education <- mutate(education, Year = as.numeric(substr(education$year, 2, nchar(education$year))))
education$year <- NULL

all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year"))

draw_education_population_plot(){
  
  ggplot(data, aes(x = input, group = 1)) + 
            geom_line(aes(y = , color = "palegreen4")) +
            geom_area(aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7)
}