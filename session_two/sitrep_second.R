
library(tidyverse)
library(lubridate)
library(DT)

load("ShinyContactData.rda")

ui <- fluidPage(
  
  # Application title
  titlePanel("Sitrep"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # ...
    ),
    mainPanel(
      # ...
    )
  )
)

# server

server <- function(input, output) {
  
  returnData <- reactive({
    
    ShinyContactData %>% 
      filter(Status %in% input$status) %>% 
      filter(Year %in% input$year) %>%
      group_by(Month, Group1) %>% 
      summarise(count = n()) %>% 
      ungroup()
  })
  
  output$table <- renderDT({
    
    returnData() %>% 
      spread(., Group1, count)
  })
  
  output$graph <- renderPlot({
    
    returnData() %>% 
      ggplot(aes(x = Month, y = count, colour = Group1)) +
      geom_line()
  })
}