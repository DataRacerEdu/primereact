library(shiny)
library(primereact)

ui <- fluidPage(
  tags$link(rel = "stylesheet", href = "species_icons/icons.css"),

  h3("Custom Species Icons Test"),

  fluidRow(
    column(6,
      select_input(
        inputId = "species",
        value = NULL,
        options = list(
          list(title = "Shark", item = "shark"),
          list(title = "Crab", item = "crab"),
          list(title = "Lobster", item = "lobster"),
          list(title = "Shrimp", item = "shrimp"),
          list(title = "Octopus", item = "octopus"),
          list(title = "Squid", item = "squid"),
          list(title = "Finfish", item = "finfish"),
          list(title = "Eel", item = "eel"),
          list(title = "Manta Ray", item = "manta-ray"),
          list(title = "Bivalve", item = "bivalve"),
          list(title = "Snail", item = "snail"),
          list(title = "Sea Urchin", item = "sea-urchin"),
          list(title = "Sea Cucumber", item = "sea-cucumber"),
          list(title = "Cuttlefish", item = "cuttlefish"),
          list(title = "Barnacle", item = "barnacle"),
          list(title = "Goose Barnacle", item = "goose-barnacle"),
          list(title = "Fish Group", item = "fishgroup")
        ),
        placeholder = "Select species",
        iconClass = "species-",
        width = "300px"
      )
    ),
    column(6,
      h5("Selected:"),
      verbatimTextOutput("selected")
    )
  )
)

server <- function(input, output, session) {
  output$selected <- renderPrint({
    input$species
  })
}

shinyApp(ui, server)
