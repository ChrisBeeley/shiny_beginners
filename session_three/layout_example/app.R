
ui <- fluidPage(
  fluidRow(
    column(width = 6, wellPanel(p("This appears in one column"))
    ),
    column(width = 6, wellPanel(p("Then this in another column"))
    )
  ),
  fluidRow(
    column(width = 3, wellPanel(p("Then a thin column underneath the top row"))),
    column(width = 9, wellPanel(p("Then a wide column next to that one")))
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)