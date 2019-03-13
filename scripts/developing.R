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

percent_expenditure_developing <- eco_edu_developing %>%
  filter(Year == "2011") %>%
  mutate(Percent.Education = round(Education.Billions / GDP.Billions * 100, 1)) %>%
  summarize(Avg.Percent.Education = mean(Percent.Education, na.rm = T))

percent_expenditure_industrialized <- eco_edu_industrialized %>%
  filter(Year == "2011") %>%
  mutate(Percent.Education = round(Education.Billions / GDP.Billions * 100, 1)) %>%
  summarize(Avg.Percent.Education = mean(Percent.Education, na.rm = T))

# Create a line graph for the given data and country.
create_plot <- function(data, country) {
    ggplot(data, aes(x = as.numeric(Year))) +
      geom_line(mapping = aes(y = GDP.Billions, color = "palegreen4")) +
      geom_area(mapping = aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7) +
      geom_line(mapping = aes(y = Education.Billions, color = "steelblue4")) +
      geom_area(mapping = aes(y = Education.Billions), fill = "steelblue3", alpha = 0.7) +
      facet_grid(~Country.Name) +
      scale_color_manual(
        values = c("palegreen4", "steelblue4"),
        labels = c("GDP", "Education Expenditure")) +
      theme(legend.position = "bottom") +
      labs(
        title = paste("GDP and Education Spenditure Over Time:", country),
        x = "Year",
        y = "US Dollars (in billions)",
        color = ""
      )
}

# Create a plot of GDP and education expenditure over time for developing countries
create_developing_plot <- function(country) {
  if (country == "All") {
    data <- eco_edu_developing
  } else {
    data <- filter(eco_edu_developing, Country.Name == country)
  }
  create_plot(data, country)
}

# Create a plot of GDP and education expenditure over time for industrialized countries
create_industrialized_plot <- function(country) {
  if (country == "All") {
    data <- eco_edu_industrialized
  } else {
    data <- filter(eco_edu_industrialized, Country.Name == country)
  }
  create_plot(data, country)
}