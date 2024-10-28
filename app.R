library(shiny)
library(primereact)

ui <- div(
  # tags$head(
  #   tags$link(rel = "stylesheet", type = "text/css", href = "species_group.css"),
  #   tags$link(rel = "stylesheet", type = "text/css", href = "countries_flag.css")
  # ),
  action_button(
    inputId = "actnBtnTest",
    label = "Enter text",
    icon = "pi pi-check"
  ),
  date_range_input(
    inputId = "dateRange",
    placeholder = "Select date range",
    width = "50%",
    value = c("2024-07-01", "2024-07-10"),
    minDate = Sys.Date() - 1000,
    maxDate = Sys.Date(),
  ),
  toggle_button(
    inputId = "tglBtnTest",
    value = FALSE,
    onLabel = "Group by",
    offLabel = "Don't group by",
    onIcon = "pi pi-check",
    offIcon = "pi pi-times"
  ),

  multiple_select_input(
    inputId = "msiTest",
    value = NULL,
    options = list(
      list(title = "Barnacle", item = "octopus"),
      list(title = "Ray", item = "ray"),
      list(title = "Sea cucumber", item = "sea_cucumber"),
      list(title = "Shark", item = "shark"),
      list(title = "Shrimp", item = "shrimp")
    ),
    iconClass="species-group species-group-",
    width = "50%",
    filter = TRUE
  ),

  select_input(
    inputId = "siTest",
    value = NULL,
    options = list(
      list(title = "Kenya", item = "KEN"),
      list(title = "Indonesia", item = "IDN"),
      list(title = "Philippines", item = "PHL")
    ),
    iconClass="country-flag country-flag-"
  )

)

server <- function(input, output, session) {
  observe({
    # print(input$actnBtnTest)
    print(input$dateRange)
    # print(input$tglBtnTest)
    # print(input$msiTest[names(input$msiTest) == "item"] |> unname())
    # print(input$siTest)
  })

  observeEvent(input$actnBtnTest, {

    print(input$actnBtnTest)

    # if(input$actnBtnTest > 2) {
      # update_date_range_input(
      #   session,
      #   inputId = "dateRange",
      #   value = c("2024-07-01", "2024-07-10"),
      #   configuration = list(
      #     placeholder = "New date range",
      #     minDate = "2024-07-01",
      #     maxDate = "2024-08-31",
      #     width = "100%"
      #   )
      # )

      # update_toggle_button(
      #   session,
      #   inputId = "tglBtnTest",
      #   value = TRUE,
      #   configuration = list(
      #     onLabel = "on Label",
      #     offLabel = "off Label",
      #     onIcon = "pi pi-check",
      #     offIcon = "pi pi-times"
      #   )
      # )

      # update_multiple_select_input(
      #   session,
      #   inputId = "msiTest",
      #   value = list(
      #     list(title = "Ray", item = "ray"),
      #     list(title = "Shrimp", item = "shrimp")
      #   ),
      #   configuration = list(
      #     width = "100%",
      #     options = list(
      #       list(title = "Barnacle", item = "octopus"),
      #       list(title = "Ray", item = "ray"),
      #       list(title = "Sea cucumber", item = "sea_cucumber"),
      #       list(title = "Shark", item = "shark"),
      #       list(title = "Shrimp", item = "shrimp")
      #     )
      #   )
      # )

      # update_select_input(
      #   session,
      #   inputId = "siTest",
      #   value = list(title = "Philippines", item = "PHL"),
      #   configuration = list(
      #     options = list(
      #       list(title = "Kenya", item = "KEN"),
      #       list(title = "Indonesia", item = "IDN"),
      #       list(title = "Philippines", item = "PHL"),
      #       list(title = "Madagascar", item = "MDG"),
      #       list(title = "Tanzania", item = "TZA")
      #     ),
      #     iconClass="country-flag country-flag-"
      #   )
      # )
    # }
  })
}

shinyApp(ui, server)
