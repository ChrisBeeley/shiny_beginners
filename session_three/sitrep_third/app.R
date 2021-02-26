library(tidyverse)
library(lubridate)
library(DT)
library(shiny)

load("ShinyContactData.rda")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Reactive application"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("year", "Select year",
                        choices = unique(ShinyContactData$Year),
                        multiple = TRUE,
                        selected = max(ShinyContactData$Year)),
            selectInput("status", "Select type",
                        choices = unique(ShinyContactData$Status),
                        multiple = TRUE,
                        selected = unique(ShinyContactData$Status)[1])
    ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(id = "tabset1",
                tabPanel("The table", value = "table",
                         DTOutput("table")),
                tabPanel("The graph", value = "graph",
                         plotOutput("graph"))
            )
        )
    )
)

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
            ggplot(aes(x = Month, y = count)) +
            geom_line() + facet_wrap(~ Group1)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
