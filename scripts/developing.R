library("dplyr")
source("scripts/join.R")

developing <- c("Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal")
industrialized <- c("Germany", "India", "Japan", "United Kingdom", "United States")

eco_edu_developing <- economics_education %>%
  filter(Country.Name %in% developing) %>%
  mutate(GDP.Billions = round(GDP / 1000000000, 1),
         Education.Billions = round((GDP * (Education.Expenditure / 100)) / 1000000000, 1)
  )

eco_edu_industrialized <- economics_education %>%
  filter(Country.Name %in% industrialized) %>%
  mutate(GDP.Billions = round(GDP / 1000000000, 1),
         Education.Billions = round((GDP * (Education.Expenditure / 100)) / 1000000000, 1)
  )

create_developing_plot <- function(country) {
  if (country == "All") {
    ggplot(eco_edu_developing, aes(x = as.numeric(Year))) +
      geom_line(mapping = aes(y = GDP.Billions, color = "palegreen4")) +
      geom_area(mapping = aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7) +
      geom_line(mapping = aes(y = Education.Billions, color = "steelblue4")) +
      geom_area(mapping = aes(y = Education.Billions), fill = "steelblue3", alpha = 0.7) +
      facet_grid(~Country.Name)
  } else {
    developing_filtered <- eco_edu_developing %>%
      filter(Country.Name == country)
    
    ggplot(developing_filtered, aes(x = as.numeric(Year))) +
      geom_line(mapping = aes(y = GDP.Billions, color = "palegreen4")) +
      geom_area(mapping = aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7) +
      geom_line(mapping = aes(y = Education.Billions, color = "steelblue4")) +
      geom_area(mapping = aes(y = Education.Billions), fill = "steelblue3", alpha = 0.7)
  }
}

create_industrialized_plot <- function(country) {
  if (country == "All") {
    ggplot(eco_edu_industrialized, aes(x = as.numeric(Year))) +
      geom_line(mapping = aes(y = GDP, color = "palegreen4")) +
      geom_area(mapping = aes(y = GDP), fill = "palegreen3", alpha = 0.7) +
      geom_line(mapping = aes(y = Education.Expenditure, color = "steelblue4")) +
      geom_area(mapping = aes(y = Education.Expenditure), fill = "steelblue3", alpha = 0.7) +
      facet_grid(~Country.Name)
  } else {
    industrialized_filtered <- eco_edu_industrialized %>%
      filter(Country.Name == country)
    
    ggplot(industrialized_filtered, aes(x = as.numeric(Year))) +
      geom_line(mapping = aes(y = GDP.Billions, color = "palegreen4")) +
      geom_area(mapping = aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7) +
      geom_line(mapping = aes(y = Education.Billions, color = "steelblue4")) +
      geom_area(mapping = aes(y = Education.Billions), fill = "steelblue3", alpha = 0.7)
  }
}