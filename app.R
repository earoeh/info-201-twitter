library("shiny")

# shared data

source("app_ui.R")
source("app_server.R")

shinyApp(ui = app_ui, server = app_server)
