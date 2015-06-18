# ui.R

shinyUI(fluidPage(
  titlePanel("2013 County-Level Socioeconomic Indicators"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create indicator maps with 
               information from the United States Department of Agriculture",
               a("Economic Research Service", href="http://www.ers.usda.gov/data-products/county-level-data-sets/download-data.aspx")),
      
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent in Poverty", "Percent Unemployed",
                              "Percent with Bacholer"),
                  selected = "Percent in Poverty" )

      ),
    
    mainPanel(plotOutput("map"))
  )
))
