library(shiny)
library(rCharts)
library(rjson)

shinyUI(fluidPage(
  headerPanel("Crime in Seattle"), 
  
  sidebarPanel(
    uiOutput("select.date.ran"), 
    uiOutput("select.crime")
  ), 
  
  mainPanel(chartOutput("my.map", "leaflet"),
            tags$style('.leaflet {height: 500px;}'),
            tags$head(tags$script(src="http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js")),
            # tags$head(tags$script(src="http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js")),
            uiOutput('spd.map')
            )
))