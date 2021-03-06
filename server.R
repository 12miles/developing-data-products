# server.R

library(maps)
library(mapproj)
#counties <- readRDS("data/counties.rds")
indicators2013 <- read.csv("data/census2013.csv")
source("helpers.R")


shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      args <- switch(input$var,
                     "Percent in Poverty" = list(indicators2013$PCTPOVALL_2013, 
                                                 "darkgreen", "% in Poverty", 
                                                 min(indicators2013$PCTPOVALL_2013, na.rm = T),
                                                 max(indicators2013$PCTPOVALL_2013, na.rm = T)),
                     "Percent Unemployed" = list(indicators2013$Unemployment_rate_2013,
                                                 "darkblue", "% Unemployed",
                                                 min(indicators2013$Unemployment_rate_2013, na.rm = T),
                                                 max(indicators2013$Unemployment_rate_2013, na.rm = T)),
                     "Percent with Bacholer" = list(indicators2013$bachelor_or_higher_2013,
                                                    "darkred", "% with at least a Bachelors",
                                                    min(indicators2013$bachelor_or_higher_2013, na.rm = T),
                                                    max(indicators2013$bachelor_or_higher_2013, na.rm = T))
      )
      
      
      do.call(percent_map, args)
    })
    data <- reactive({
      dist <- switch(input$var,
                     "Percent in Poverty" = indicators2013$PCTPOVALL_2013,
                     "Percent Unemployed" = indicators2013$Unemployment_rate_2013,
                     "Percent with Bacholer" = indicators2013$bachelor_or_higher_2013)
      
    })
    # Generate a summary of the data
    output$summary <- renderPrint({
      summary(data())
    })
    
    # Generate the weighted mean for the nation
    output$weighted <- renderPrint({
      weighted.mean(data(),indicators2013$POP_ESTIMATE_2013, na.rm=T)
    })
  }
)
