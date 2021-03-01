library(tidyverse)
library(lubridate)
library(DT)
library(shiny)

load("ShinyContactData.rda")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Reactive application"),
  
  fluidRow(
    column(width = 3,
           uiOutput("yearUI"),
           
           selectInput("status", "Select type",
                       choices = unique(ShinyContactData$Status),
                       multiple = TRUE,
                       selected = unique(ShinyContactData$Status)[1])
    ),
    column(width = 9,
           tabsetPanel(id = "tabset1",
                       tabPanel("The table", value = "table",
                                DTOutput("table")),
                       tabPanel("The graph", value = "graph",
                                plotOutput("graph"))
           )
    )
  ),
  fluidRow(
    column(6, wellPanel(p("Half the screen"))),
    column(6, wellPanel(p("Half the screen")))
  )
)

server <- function(input, output) {
  
  output$yearUI <- renderUI({
    
    year_choices <- ShinyContactData %>%
      distinct(Year) %>%
      pull(Year)
    
    selected <- sample(year_choices, 1)
    
    selectInput("year", "Select year",
                choices = year_choices,
                multiple = TRUE,
                selected = selected)
  })
  
  returnData <- reactive({
    
    ShinyContactData %>% 
      filter(Status %in% input$status) %>% 
      filter(Year %in% input$year) %>%
      group_by(Month, Group1) %>% 
      summarise(count = n()) %>% 
      ungroup()
  })
  
  output$table <- renderDT({
    
    validate(
      need(input$year, "Please select a year"),
      need(input$status, "Please select a status")
    )
    
    returnData() %>% 
      spread(., Group1, count)
  })
  
  output$graph <- renderPlot({
    
    req(input$status)
    req(input$year)
    
    returnData() %>% 
      ggplot(aes(x = Month, y = count)) +
      geom_line() + facet_wrap(~ Group1)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
