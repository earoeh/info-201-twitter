library("ggplot2")
source("scripts/join.R")
options(scipen = 999)

nordic <- c("Denmark", "Finland", "Iceland", "Norway", "Sweden")

nordic_data <- economics_education %>%
  filter(Country.Name %in% nordic)
nordic_data <- nordic_data %>%
  mutate(Education.Expenditure.Value = GDP * (Education.Expenditure / 100),
         Education.Expenditure.Billions = round(Education.Expenditure.Value / 1000000000, 1),
         GDP.Billions = round(GDP / 1000000000))

avg_nordic_expenditure_percent <- round(mean(nordic_data$Education.Expenditure,
                                         na.rm = T), 2)
avg_nordic_expenditure <- round(mean(nordic_data$Education.Expenditure.Billions,
                                     na.rm = T), 1)
avg_nordic_pop <- round(mean(nordic_data$Population))
nordic_data_no_iceland <- nordic_data %>%
  filter(Country.Name != "Iceland")
avg_nordic_pop_no_iceland <- round(mean(nordic_data_no_iceland$Population,
                                        na.rm = T))

top_economies <- c("Germany", "India", "Japan",
                   "United Kingdom", "United States")

top_economies_data <- economics_education %>%
  filter(Country.Name %in% top_economies)
top_economies_data <- top_economies_data %>%
  mutate(Education.Expenditure.Value = GDP * (Education.Expenditure / 100),
         Education.Expenditure.Billions = round(Education.Expenditure.Value / 1000000000, 1),
         GDP.Billions = round(GDP / 1000000000))

avg_top_economy_expenditure_percent <- round(mean(top_economies_data$Education.Expenditure,
                                    na.rm = T), 2)
avg_top_economy_expenditure <- round(mean(top_economies_data$Education.Expenditure.Billions,
                                          na.rm = T), 1)
avg_top_economy_pop <- round(mean(top_economies_data$Population))

# Generates a line plot of the given data.
generate_plot <- function(data, area) {
  ggplot(data, aes(x = as.numeric(Year), group = 1)) + 
    geom_line(aes(y = GDP.Billions, color = "palegreen4")) +
    geom_area(aes(y = GDP.Billions), fill = "palegreen3", alpha = 0.7) +
    geom_line(aes(y = Education.Expenditure.Billions, color = "steelblue4")) +
    geom_area(aes(y = Education.Expenditure.Billions), fill = "steelblue3", alpha = 0.7) +
    scale_color_manual(values = c("palegreen4", "steelblue4"), labels = c("GDP", "Education Expenditure")) +
    theme(legend.position = "bottom") +
    facet_grid(~ Country.Name) + 
    labs(title = paste("GDP and Education Expenditure Over Time:", area),
         x = "Year",
         y = "US Dollars (in billions)",
         color = "")
}

# Generates a line plot displaying education expenditure and GDP
# of the given Nordic country or countries.
generate_line_plot_nordic <- function(country) {
  if (country == "All") {
    data_n <- nordic_data
  } else {
    data_n <- nordic_data %>%
      filter(Country.Name == country)
  }
  generate_plot(data_n, "Nordic Countries")
}

# Generates a line plot displaying education expenditure and GDP
# of the given top economy country or countries.
generate_line_plot_top <- function(country) {
  if (country == "All") {
    data_t <- top_economies_data
  } else {
    data_t <- top_economies_data %>%
      filter(Country.Name == country)
  }
  generate_plot(data_t, "Top Economy Countries")
}