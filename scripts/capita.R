source("scripts/join.R")
library("ggplot2")

united_kingdom <- filter(economics_education, Country.Name == "United Kingdom")
united_kingdom <- mutate(united_kingdom, 
                         GDP.Per.Capita = GDP / Population, 
                         Education.Per.Capita = (Education.Expenditure / 100) * GDP / Population)

united_kingdom <- gather(united_kingdom, 
                         key = "Type",
                         value = GDP.Per.Capita,
                         -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code, -Year,
                         na.rm = T)
types <- c("GDP.Per.Capita", "Education.Per.Capita")
united_kingdom <- filter(united_kingdom,
                         Type %in% types)

# Generates a bar plot of GDP and education spending per capita for the given year
generate_capita_plot <- function(selected_year) {
  united_kingdom_year <- filter(united_kingdom,
                                Year == selected_year)
  
  ggplot(united_kingdom_year, aes(x = Type, y = GDP.Per.Capita, fill = Type)) +
    geom_bar(stat = 'identity', alpha = .7) + 
    scale_fill_manual(values = c("steelblue3", "palegreen3")) +
    geom_text(aes(label = round(GDP.Per.Capita)), vjust = -0.25) +
    labs(x = "Spending",
         y = "US Dollars per Capita") +
    theme(legend.position = "none")
}