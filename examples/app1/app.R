library(shiny)
library(primereact)
library(bslib)

ui <- bslib::page(
  # Country flags auto-loaded - just use iconClass = "country-flag country-flag-"

  # ============================================================================
  # SELECT INPUT
  # ============================================================================
  h3("Test Select Input Updates"),

  fluidRow(
    column(6,
      select_input(
        inputId = "siTest",
        value = NULL,
        options = list(
          list(title = "Kenya", item = "KEN"),
          list(title = "Indonesia", item = "IDN"),
          list(title = "Philippines", item = "PHL")
        ),
        placeholder = "Select country",
        iconClass = "country-flag country-flag-",
        width = "300px",
        class = "test-class"
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_select")
    )
  ),

  fluidRow(
    column(3, actionButton("si_value_set", "Set value"), actionButton("si_value_clear", "Clear")),
    column(3, actionButton("si_options", "New options")),
    column(3, actionButton("si_placeholder", "Change placeholder")),
    column(3, actionButton("si_width", "Toggle width"))
  ),
  fluidRow(
    column(3, actionButton("si_class", "Toggle class")),
    column(3, actionButton("si_icon", "Toggle iconClass")),
    column(6, "")
  ),

  hr(),

  # ============================================================================
  # MULTIPLE SELECT INPUT
  # ============================================================================
  h3("Test Multiple Select Input Updates"),

  fluidRow(
    column(6,
      multiple_select_input(
        inputId = "msTest",
        value = NULL,
        options = list(
          list(title = "Apple", item = "apple"),
          list(title = "Banana", item = "banana"),
          list(title = "Cherry", item = "cherry"),
          list(title = "Date", item = "date")
        ),
        placeholder = "Select fruits",
        width = "300px",
        filter = FALSE
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_multiselect")
    )
  ),

  fluidRow(
    column(3, actionButton("ms_value_set", "Set values"), actionButton("ms_value_clear", "Clear")),
    column(3, actionButton("ms_options", "New options")),
    column(3, actionButton("ms_filter_on", "Filter ON"), actionButton("ms_filter_off", "Filter OFF")),
    column(3, actionButton("ms_placeholder", "Change placeholder"))
  ),
  fluidRow(
    column(3, actionButton("ms_width", "Toggle width")),
    column(3, actionButton("ms_class", "Toggle class")),
    column(3, actionButton("ms_icon", "Toggle iconClass")),
    column(3, "")
  ),

  hr(),

  # ============================================================================
  # TOGGLE BUTTON
  # ============================================================================
  h3("Test Toggle Button Updates"),

  fluidRow(
    column(6,
      toggle_button(
        inputId = "tbTest",
        value = FALSE,
        onLabel = "Active",
        offLabel = "Inactive"
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_toggle")
    )
  ),

  fluidRow(
    column(3, actionButton("tb_value_on", "Set ON"), actionButton("tb_value_off", "Set OFF")),
    column(3, actionButton("tb_labels", "Change labels")),
    column(3, actionButton("tb_disable", "Disable"), actionButton("tb_enable", "Enable")),
    column(3, actionButton("tb_icons", "Change icons"))
  ),
  fluidRow(
    column(3, actionButton("tb_class", "Toggle class")),
    column(9, "")
  ),

  hr(),

  # ============================================================================
  # ACTION BUTTON
  # ============================================================================
  h3("Test Action Button Updates"),

  fluidRow(
    column(6,
      action_button(
        inputId = "abTest",
        label = "Click Me",
        icon = "pi pi-check"
      )
    ),
    column(6,
      h5("Click count:"),
      verbatimTextOutput("debug_action")
    )
  ),

  fluidRow(
    column(3, actionButton("ab_label", "Change label")),
    column(3, actionButton("ab_icon", "Change icon")),
    column(3, actionButton("ab_disable", "Disable"), actionButton("ab_enable", "Enable")),
    column(3, actionButton("ab_style", "Toggle outlined"))
  ),
  fluidRow(
    column(3, actionButton("ab_iconpos", "Toggle iconPos")),
    column(3, actionButton("ab_size", "Cycle size")),
    column(3, actionButton("ab_rounded", "Toggle rounded")),
    column(3, actionButton("ab_raised", "Toggle raised"))
  ),

  hr(),

  # ============================================================================
  # TOGGLE TEXT BUTTON
  # ============================================================================
  h3("Test Toggle Text Button Updates"),

  fluidRow(
    column(6,
      toggle_text_button(
        inputId = "ttbTest",
        value = list(value = NULL, name = NULL),
        options = c("opt1", "opt2", "opt3")
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_toggle_text")
    )
  ),

  fluidRow(
    column(4, actionButton("ttb_value_set", "Set value"), actionButton("ttb_value_clear", "Clear")),
    column(4, actionButton("ttb_options", "New options")),
    column(4, actionButton("ttb_disable", "Disable"), actionButton("ttb_enable", "Enable"))
  ),

  hr(),

  # ============================================================================
  # DATE RANGE INPUT
  # ============================================================================
  h3("Test Date Range Input Updates"),

  fluidRow(
    column(6,
      date_range_input(
        inputId = "drTest",
        value = NULL,
        placeholder = "Select date range",
        width = "300px"
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_daterange")
    )
  ),

  fluidRow(
    column(3, actionButton("dr_value_set", "Set dates"), actionButton("dr_value_clear", "Clear")),
    column(3, actionButton("dr_placeholder", "Change placeholder")),
    column(3, actionButton("dr_minmax", "Set min/max")),
    column(3, actionButton("dr_width", "Toggle width"))
  ),
  fluidRow(
    column(3, actionButton("dr_class", "Toggle class")),
    column(9, "")
  ),

  hr(),

  # ============================================================================
  # DATE INPUT (Single Date)
  # ============================================================================
  h3("Test Date Input Updates"),

  fluidRow(
    column(6,
      date_input(
        inputId = "diTest",
        value = NULL,
        placeholder = "Select date",
        width = "300px"
      )
    ),
    column(6,
      h5("Current value:"),
      verbatimTextOutput("debug_date")
    )
  ),

  fluidRow(
    column(3, actionButton("di_value_set", "Set date"), actionButton("di_value_clear", "Clear")),
    column(3, actionButton("di_placeholder", "Change placeholder")),
    column(3, actionButton("di_minmax", "Set min/max")),
    column(3, actionButton("di_width", "Toggle width"))
  ),
  fluidRow(
    column(3, actionButton("di_class", "Toggle class")),
    column(9, "")
  )
)

server <- function(input, output, session) {

  # ============================================================================
  # SELECT INPUT
  # ============================================================================
  output$debug_select <- renderPrint({ input$siTest })

  observeEvent(input$si_value_set, {
    update_select_input(session, "siTest", value = list(title = "Indonesia", item = "IDN"))
  })
  observeEvent(input$si_value_clear, {
    update_select_input(session, "siTest", value = NULL)
  })
  observeEvent(input$si_options, {
    update_select_input(session, "siTest", options = list(
      list(title = "Option A", item = "A"),
      list(title = "Option B", item = "B")
    ))
  })
  observeEvent(input$si_placeholder, {
    update_select_input(session, "siTest", placeholder = paste("Updated at", Sys.time()))
  })
  si_wide <- reactiveVal(FALSE)
  observeEvent(input$si_width, {
    si_wide(!si_wide())
    update_select_input(session, "siTest", width = if(si_wide()) "500px" else "300px")
  })
  si_styled <- reactiveVal(FALSE)
  observeEvent(input$si_class, {
    si_styled(!si_styled())
    update_select_input(session, "siTest", class = if(si_styled()) "highlighted" else "")
  })
  si_icons <- reactiveVal(TRUE)
  observeEvent(input$si_icon, {
    si_icons(!si_icons())
    update_select_input(session, "siTest", iconClass = if(si_icons()) "country-flag country-flag-" else "")
  })

  # ============================================================================
  # MULTIPLE SELECT INPUT
  # ============================================================================
  output$debug_multiselect <- renderPrint({ input$msTest })

  observeEvent(input$ms_value_set, {
    update_multiple_select_input(session, "msTest", value = list(
      list(title = "Apple", item = "apple"),
      list(title = "Cherry", item = "cherry")
    ))
  })
  observeEvent(input$ms_value_clear, {
    update_multiple_select_input(session, "msTest", value = NULL)
  })
  observeEvent(input$ms_options, {
    update_multiple_select_input(session, "msTest", options = list(
      list(title = "Red", item = "red"),
      list(title = "Green", item = "green"),
      list(title = "Blue", item = "blue")
    ))
  })
  observeEvent(input$ms_filter_on, {
    update_multiple_select_input(session, "msTest", filter = TRUE)
  })
  observeEvent(input$ms_filter_off, {
    update_multiple_select_input(session, "msTest", filter = FALSE)
  })
  observeEvent(input$ms_placeholder, {
    update_multiple_select_input(session, "msTest", placeholder = paste("Pick items -", Sys.time()))
  })
  ms_wide <- reactiveVal(FALSE)
  observeEvent(input$ms_width, {
    ms_wide(!ms_wide())
    update_multiple_select_input(session, "msTest", width = if(ms_wide()) "500px" else "300px")
  })
  ms_styled <- reactiveVal(FALSE)
  observeEvent(input$ms_class, {
    ms_styled(!ms_styled())
    update_multiple_select_input(session, "msTest", class = if(ms_styled()) "highlighted" else "")
  })
  ms_icons <- reactiveVal(FALSE)
  observeEvent(input$ms_icon, {
    ms_icons(!ms_icons())
    update_multiple_select_input(session, "msTest", iconClass = if(ms_icons()) "pi pi-tag" else "")
  })

  # ============================================================================
  # TOGGLE BUTTON
  # ============================================================================
  output$debug_toggle <- renderPrint({ input$tbTest })

  observeEvent(input$tb_value_on, {
    update_toggle_button(session, "tbTest", value = TRUE)
  })
  observeEvent(input$tb_value_off, {
    update_toggle_button(session, "tbTest", value = FALSE)
  })
  observeEvent(input$tb_labels, {
    update_toggle_button(session, "tbTest", onLabel = "YES", offLabel = "NO")
  })
  observeEvent(input$tb_disable, {
    update_toggle_button(session, "tbTest", disabled = TRUE)
  })
  observeEvent(input$tb_enable, {
    update_toggle_button(session, "tbTest", disabled = FALSE)
  })
  observeEvent(input$tb_icons, {
    update_toggle_button(session, "tbTest", onIcon = "pi pi-star-fill", offIcon = "pi pi-star")
  })
  tb_styled <- reactiveVal(FALSE)
  observeEvent(input$tb_class, {
    tb_styled(!tb_styled())
    update_toggle_button(session, "tbTest", class = if(tb_styled()) "p-button-success" else "")
  })

  # ============================================================================
  # ACTION BUTTON
  # ============================================================================
  output$debug_action <- renderPrint({ input$abTest })

  observeEvent(input$ab_label, {
    update_action_button(session, "abTest", label = paste("Clicked", input$abTest, "times"))
  })
  observeEvent(input$ab_icon, {
    update_action_button(session, "abTest", icon = "pi pi-heart")
  })
  observeEvent(input$ab_disable, {
    update_action_button(session, "abTest", disabled = TRUE)
  })
  observeEvent(input$ab_enable, {
    update_action_button(session, "abTest", disabled = FALSE)
  })
  ab_outlined <- reactiveVal(FALSE)
  observeEvent(input$ab_style, {
    ab_outlined(!ab_outlined())
    update_action_button(session, "abTest", outlined = ab_outlined())
  })
  ab_iconpos <- reactiveVal("right")
  observeEvent(input$ab_iconpos, {
    ab_iconpos(if(ab_iconpos() == "right") "left" else "right")
    update_action_button(session, "abTest", iconPos = ab_iconpos())
  })
  ab_size_idx <- reactiveVal(1)
  sizes <- c("small", "normal", "large")
  observeEvent(input$ab_size, {
    ab_size_idx((ab_size_idx() %% 3) + 1)
    update_action_button(session, "abTest", size = sizes[ab_size_idx()])
  })
  ab_rounded <- reactiveVal(FALSE)
  observeEvent(input$ab_rounded, {
    ab_rounded(!ab_rounded())
    update_action_button(session, "abTest", rounded = ab_rounded())
  })
  ab_raised <- reactiveVal(FALSE)
  observeEvent(input$ab_raised, {
    ab_raised(!ab_raised())
    update_action_button(session, "abTest", raised = ab_raised())
  })

  # ============================================================================
  # TOGGLE TEXT BUTTON
  # ============================================================================
  output$debug_toggle_text <- renderPrint({ input$ttbTest })

  observeEvent(input$ttb_value_set, {
    update_toggle_text_button(session, "ttbTest", value = list(name = "opt2", value = "opt2"))
  })
  observeEvent(input$ttb_value_clear, {
    update_toggle_text_button(session, "ttbTest", value = list(name = NULL, value = NULL))
  })
  observeEvent(input$ttb_options, {
    update_toggle_text_button(session, "ttbTest", options = c("a", "b", "c"))
  })
  observeEvent(input$ttb_disable, {
    update_toggle_text_button(session, "ttbTest", disabled = TRUE)
  })
  observeEvent(input$ttb_enable, {
    update_toggle_text_button(session, "ttbTest", disabled = FALSE)
  })

  # ============================================================================
  # DATE RANGE INPUT
  # ============================================================================
  output$debug_daterange <- renderPrint({ input$drTest })

  observeEvent(input$dr_value_set, {
    update_date_range_input(session, "drTest", value = list(
      as.character(Sys.Date()),
      as.character(Sys.Date() + 7)
    ))
  })
  observeEvent(input$dr_value_clear, {
    update_date_range_input(session, "drTest", value = NULL)
  })
  observeEvent(input$dr_placeholder, {
    update_date_range_input(session, "drTest", placeholder = "Pick a range")
  })
  observeEvent(input$dr_minmax, {
    update_date_range_input(session, "drTest",
      minDate = as.character(Sys.Date() - 30),
      maxDate = as.character(Sys.Date() + 30)
    )
  })
  dr_wide <- reactiveVal(FALSE)
  observeEvent(input$dr_width, {
    dr_wide(!dr_wide())
    update_date_range_input(session, "drTest", width = if(dr_wide()) "500px" else "300px")
  })
  dr_styled <- reactiveVal(FALSE)
  observeEvent(input$dr_class, {
    dr_styled(!dr_styled())
    update_date_range_input(session, "drTest", class = if(dr_styled()) "highlighted" else "")
  })

  # ============================================================================
  # DATE INPUT (Single Date)
  # ============================================================================
  output$debug_date <- renderPrint({ input$diTest })

  observeEvent(input$di_value_set, {
    update_date_input(session, "diTest", value = as.character(Sys.Date()))
  })
  observeEvent(input$di_value_clear, {
    update_date_input(session, "diTest", value = NULL)
  })
  observeEvent(input$di_placeholder, {
    update_date_input(session, "diTest", placeholder = "Pick a date")
  })
  observeEvent(input$di_minmax, {
    update_date_input(session, "diTest",
      minDate = as.character(Sys.Date() - 30),
      maxDate = as.character(Sys.Date() + 30)
    )
  })
  di_wide <- reactiveVal(FALSE)
  observeEvent(input$di_width, {
    di_wide(!di_wide())
    update_date_input(session, "diTest", width = if(di_wide()) "500px" else "300px")
  })
  di_styled <- reactiveVal(FALSE)
  observeEvent(input$di_class, {
    di_styled(!di_styled())
    update_date_input(session, "diTest", class = if(di_styled()) "highlighted" else "")
  })
}

shinyApp(ui, server)
