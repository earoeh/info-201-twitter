library("dplyr")
library("tidyr")

economics <- read.csv("data/economics.csv", stringsAsFactors = FALSE)
education <- read.csv("data/wdi_education_cleaned.csv", stringsAsFactors = FALSE)

colnames(education)[5:53] <- substring(colnames(education)[5:53], 2)
education_long <- gather(education, key = Year, value = Education.Expenditure,
                            -Country.Name, -Country.Code, -Indicator.Name, -Indicator.Code,
                            na.rm = TRUE)
economics <- economics %>%
  mutate(Year = as.character(Year))

economics_education <- left_join(economics, education_long,
                                 by = c("Country.Name", "Country.Code", "Year"),
                                 na.rm = TRUE)