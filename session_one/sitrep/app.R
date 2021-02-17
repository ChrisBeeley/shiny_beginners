library(shiny)
library(DT)
library(lubridate)
library(tidyverse)

load("ShinyContactData.rda")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Sitrep"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "yearInput",
                "Select year(s)",
                choices = c(2020, 2019, 2018),
                multiple = TRUE
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           DTOutput("sitrepTable")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$sitrepTable <- renderDT({
        
        cat(str(ShinyContactData))
        
        ShinyContactData %>% 
            filter(Year %in% input$yearInput) %>%
            group_by(Month, Group1) %>% 
            summarise(count = n()) %>% 
            ungroup() %>% 
            spread(., Group1, count)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
