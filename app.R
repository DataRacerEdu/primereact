library(shiny)
library(primereact)
library(bslib)

ui <- bslib::page(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "species_group.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "countries_flag.css")
  ),
  # tagList(
  #   # showModal(
  #     modalDialog(
  #       title = "Fisheries Overview Modal",
  #       size = "xl",
  #       class = "modal-container-fisheries",
  #       primereact::multiple_select_input(
  #         inputId = ("admin1_selected"),
  #         value = NULL,
  #         width = "100%",
  #         filter = TRUE,
  #         class = "primereact-modal-input",
  #         options = list(
  #           list(title = "Admin 11", item = "Admin 11"),
  #           list(title = "Admin 12", item = "Admin 12"),
  #           list(title = "Admin 13", item = "Admin 13")
  #         )
  #       )
  #     )
  #   # )
  # ),

  # action_button(
  #   inputId = "actnBtnTest",
  #   label = "Enter text",
  #   icon = "pi pi-check"
  # ),
  # primereact::select_input(
  #   inputId = ("country_selected"),
  #   value = NULL,
  #   options = list(
  #     list(title = "Kenya", item = "KEN"),
  #     list(title = "Indonesia", item = "IDN"),
  #     list(title = "Philippines", item = "PHL")
  #   ),
  #   width = "100%",
  #   placeholder = "Select country",
  #   iconClass="country-flag country-flag-",
  #   class = "primereact-modal-input"
  # ),
  #
  # primereact::multiple_select_input(
  #   inputId = ("partner_selected"),
  #   value = NULL,
  #   options = list(
  #     list(title = "Partner 1", item = "Partner 1"),
  #     list(title = "Partner 2", item = "Partner 2"),
  #     list(title = "Partner 3", item = "Partner 3")
  #   ),
  #   width = "100%",
  #   filter = TRUE,
  #   placeholder = "Select partner",
  #   class = "primereact-modal-input"
  # ),
  # date_range_input(
  #   inputId = "dateRange",
  #   placeholder = "Select date range",
  #   width = "50%",
  #   value = c("2024-07-01", "2024-07-10"),
  #   minDate = Sys.Date() - 1000,
  #   maxDate = Sys.Date(),
  # ),
  # toggle_button(
  #   inputId = "tglBtnTest",
  #   value = FALSE,
  #   onLabel = "Group by",
  #   offLabel = "Don't group by",
  #   onIcon = "pi pi-check",
  #   offIcon = "pi pi-times"
  # ),
  #
  # multiple_select_input(
  #   inputId = "msiTest",
  #   value = NULL,
  #   options = list(
  #     list(title = "Barnacle", item = "octopus"),
  #     list(title = "Ray", item = "ray"),
  #     list(title = "Sea cucumber", item = "sea_cucumber"),
  #     list(title = "Shark", item = "shark"),
  #     list(title = "Shrimp", item = "shrimp")
  #   ),
  #   iconClass="species-group species-group-",
  #   width = "50%",
  #   filter = TRUE
  # ),
  #
  select_input(
    inputId = "siTest",
    value = list(title = "Kenya", item = "KEN"),
    options = list(
      list(title = "Kenya", item = "KEN"),
      list(title = "Indonesia", item = "IDN"),
      list(title = "Philippines", item = "PHL")
    ),
    iconClass="country-flag country-flag-"
  ),

  toggle_text_button(
    inputId = "ttbTest",
    value = "On",
    options = c("Off", "On")
  )

)

server <- function(input, output, session) {
  observe({
    # print(input$actnBtnTest)
    # print(input$dateRange)
    # print(input$tglBtnTest)
    # print(input$msiTest[names(input$msiTest) == "item"] |> unname())
    print(input$ttbTest)
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
