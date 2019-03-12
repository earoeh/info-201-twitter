library("dplyr")
source("scripts/join.R")

developing <- c("Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal")
industrialized <- c("Germany", "India", "Japan", "United Kingdom", "United States")

eco_edu_developing <- economics_education %>%
  filter(Country.Name %in% developing)

avg_developing <- eco_edu_developing %>%
  group_by(Year) %>%
  summarize(
    avg_gdp = mean(GDP, na.rm = T),
    avg_expenditure = mean(Education.Expenditure, na.rm = T)
  )

eco_edu_industrialized <- economics_education %>%
  filter(Country.Name %in% industrialized)

avg_industrialized <- eco_edu_industrialized %>%
  group_by(Year) %>%
  summarize(
    avg_gdp = mean(GDP, na.rm = T),
    avg_expenditure = mean(Education.Expenditure, na.rm = T)
  )

create_developing_plot <- function(country) {
  if (country == "All") {
    ggplot(data = avg_developing) +
      geom_point(mapping = aes(x = Year, y = avg_expenditure))
  } else {
    developing_filtered <- eco_edu_developing %>%
      filter(Country.Name == country)
    
    ggplot(data = developing_filtered) +
      geom_point(mapping = aes(x = Year, y = Education.Expenditure))
  }
}