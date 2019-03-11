library("dplyr")
source("scripts/join.R")

developing <- c("Afghanistan", "Ethiopia", "Philippines", "Indonesia", "Nepal")
industrialized <- c("Germany", "India", "Japan", "United Kingdom", "United States")

eco_edu_developing <- economics_education %>%
  filter(Country.Name %in% developing)

eco_edu_industrialized <- economics_education %>%
  filter(Country.Name %in% industrialized)
