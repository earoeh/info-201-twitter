library("ggplot2")
library("tidyr")
options(scipen = 999)


economic <- read.csv(file = "data/economics.csv", stringsAsFactors = FALSE) 
population <- select(economic, -c(X, Country.Code, Cash.Surplus:GDP))

education <- read.csv(file = "data/wdi_education_cleaned.csv", stringsAsFactors = FALSE)
education <- select(education, -c(Country.Code : Indicator.Code))

education_long<- gather(        #gathers data long shape
    education,
    key = year,
    value = education_budget,
    -Country.Name
) 

education <- mutate(education_long, Year = as.numeric(substr(education_long$year, 2, nchar(education_long$year))))

education$year <- NULL

all_df <- left_join(population, education, by = c("Country.Name" = "Country.Name", "Year" = "Year")) %>% drop_na()
