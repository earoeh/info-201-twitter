library("ggplot2")
library("dplyr")
library("tidyr")
options(scipen = 999)


economic <- read.csv(file = "data/economics.csv", stringsAsFactors = FALSE) 
population <- select(economic, -c(X, Country.Code, Cash.Surplus:GDP))

education <- read.csv(file = "data/wdi_education_cleaned.csv", stringsAsFactors = FALSE)
education <- select(education, -c(Country.Code : Indicator.Code))
<<<<<<< HEAD

education_long<- gather(        #gathers data long shape
    education,
    key = year,
    value = education_budget,
    -Country.Name
) 

=======

education_long<- gather(        #gathers data long shape
  education,
  key = year,
  value = education_budget,
  -Country.Name
) 

>>>>>>> a6c45402672115e0fabf533f71af7585ba85dadf
education <- mutate(education_long, Year = as.numeric(substr(education_long$year, 2, nchar(education_long$year))))

education$year <- NULL

<<<<<<< HEAD
all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year")) %>% drop_na()
=======
all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year")) %>% drop_na()
>>>>>>> a6c45402672115e0fabf533f71af7585ba85dadf
