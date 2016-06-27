library(shiny)
library(rCharts)
library(rjson)

source('prepData.R')


shinyServer(function(input, output, session) {

  spd <- seaCrime
  print(spd)

    output$select.date.ran <- renderUI({
    dateRangeInput("sel.date", "Choose date range:", 
                   # start = "2014/01/01", end = "2015/10/05",
                   start = min(spd$Date), end = max(spd$Date), 
                   separator = "to", format = "yyyy/mm/dd",
                   startview = "month", weekstart = 0, 
                   language = "en")
  })
  
  output$select.crime <- renderUI({
    checkboxGroupInput(inputId = "sel.crime", "Select crimes:", 
                       choices = offence
                       # ,selected = "BURGLARY"
                       )
  })
  
  output$my.map <- renderMap({
    
    my.map <- Leaflet$new() 
    my.map$setView(c(47.5982623,-122.3415519) ,12) 
    my.map$tileLayer(provider="Esri.WorldStreetMap")
    my.map
  })
  
  output$spd.map <- renderUI({
    spd.dat <- spd[
        spd$Offence %in% input$sel.crime & 
                     (spd$Date >= input$sel.date[1] &
                        spd$Date <= input$sel.date[2]), ]
                        # spd$Date <= input$sel.date[2]), c(3,4)]
    print(spd.dat)
    print(input$sel.date[1])
    
    # spd.json <- toJSONArray2(spd.dat, json = FALSE, names = FALSE)
    spd.json <- toJSONArray2(spd.dat[c(4,3)], json = FALSE, names = FALSE)

    tags$body(tags$script(HTML(sprintf("
var addressPoints = %s;
if (typeof heat === typeof undefined) {
  heat = L.heatLayer(addressPoints, {maxZoom: 9, radius: 10, blur: 20}).addTo(map);
} else {
  heat.setOptions({maxZoom:9, radius:10, blur:20}).setLatLngs(addressPoints)
}
                                       ", 
                                       rjson::toJSON(spd.json)
    ))))
  })
})