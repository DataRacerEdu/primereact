library(shiny)
library(primereact)
library(bslib)

# Test app for the `readonly` option on date_input() / date_range_input().
#
# What to check:
# - Readonly inputs (the default): typing in the field must be impossible,
#   dates can only be picked from the calendar popup.
# - Editable inputs (readonly = FALSE): dates can be typed as MM/DD/YYYY
#   (ranges as MM/DD/YYYY - MM/DD/YYYY) or picked from the popup. The value
#   commits when the popup closes (click outside / Escape).
# - Typed dates respect minDate/maxDate (see last section).
# - "Toggle readonly" flips the behavior at runtime via update_*().

ui <- bslib::page(

  # ============================================================================
  # DATE INPUT
  # ============================================================================
  h3("Date Input: readonly (default) vs editable"),

  fluidRow(
    column(6,
      h5("Default (readonly = TRUE) - typing must NOT work"),
      date_input(
        inputId = "diReadonly",
        placeholder = "Popup only",
        width = "300px"
      ),
      h5("Current value:"),
      verbatimTextOutput("debug_di_readonly")
    ),
    column(6,
      h5("readonly = FALSE - type MM/DD/YYYY or use popup"),
      date_input(
        inputId = "diEditable",
        placeholder = "Type or pick",
        readonly = FALSE,
        width = "300px"
      ),
      h5("Current value:"),
      verbatimTextOutput("debug_di_editable")
    )
  ),

  fluidRow(
    column(6, actionButton("di_toggle", "Toggle readonly on left input")),
    column(6,
      actionButton("di_format", "Cycle dateFormat on right input"),
      verbatimTextOutput("debug_di_state")
    )
  ),

  hr(),

  # ============================================================================
  # DATE RANGE INPUT
  # ============================================================================
  h3("Date Range Input: readonly (default) vs editable"),

  fluidRow(
    column(6,
      h5("Default (readonly = TRUE) - typing must NOT work"),
      date_range_input(
        inputId = "drReadonly",
        value = NULL,
        placeholder = "Popup only",
        width = "300px"
      ),
      h5("Current value:"),
      verbatimTextOutput("debug_dr_readonly")
    ),
    column(6,
      h5("readonly = FALSE - type MM/DD/YYYY - MM/DD/YYYY"),
      date_range_input(
        inputId = "drEditable",
        value = NULL,
        placeholder = "Type or pick",
        readonly = FALSE,
        width = "300px"
      ),
      h5("Current value:"),
      verbatimTextOutput("debug_dr_editable")
    )
  ),

  fluidRow(
    column(6, actionButton("dr_toggle", "Toggle readonly on left input")),
    column(6, "")
  ),

  hr(),

  # ============================================================================
  # TYPED DATES vs minDate / maxDate
  # ============================================================================
  h3("Typed dates respect min/max (editable, +/- 7 days around today)"),

  fluidRow(
    column(6,
      date_input(
        inputId = "diMinMax",
        placeholder = "Try typing an out-of-range date",
        readonly = FALSE,
        minDate = as.character(Sys.Date() - 7),
        maxDate = as.character(Sys.Date() + 7),
        width = "300px"
      )
    ),
    column(6,
      h5("Current value (out-of-range typed dates must not commit):"),
      verbatimTextOutput("debug_di_minmax")
    )
  )
)

server <- function(input, output, session) {

  # ============================================================================
  # DATE INPUT
  # ============================================================================
  output$debug_di_readonly <- renderPrint({ input$diReadonly })
  output$debug_di_editable <- renderPrint({ input$diEditable })

  di_readonly <- reactiveVal(TRUE)
  observeEvent(input$di_toggle, {
    di_readonly(!di_readonly())
    update_date_input(session, "diReadonly", readonly = di_readonly())
  })
  di_formats <- c("mm/dd/yy", "dd.mm.yy", "yy-mm-dd")
  di_format_idx <- reactiveVal(1)
  observeEvent(input$di_format, {
    di_format_idx((di_format_idx() %% length(di_formats)) + 1)
    update_date_input(session, "diEditable", dateFormat = di_formats[di_format_idx()])
  })
  output$debug_di_state <- renderPrint({
    paste0(
      "Left input readonly: ", di_readonly(),
      " | Right input dateFormat: ", di_formats[di_format_idx()]
    )
  })

  # ============================================================================
  # DATE RANGE INPUT
  # ============================================================================
  output$debug_dr_readonly <- renderPrint({ input$drReadonly })
  output$debug_dr_editable <- renderPrint({ input$drEditable })

  dr_readonly <- reactiveVal(TRUE)
  observeEvent(input$dr_toggle, {
    dr_readonly(!dr_readonly())
    update_date_range_input(session, "drReadonly", readonly = dr_readonly())
  })

  # ============================================================================
  # TYPED DATES vs minDate / maxDate
  # ============================================================================
  output$debug_di_minmax <- renderPrint({ input$diMinMax })
}

shinyApp(ui, server)
