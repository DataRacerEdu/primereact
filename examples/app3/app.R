library(shiny)
library(primereact)

# Define translations
translations <- list(
  en = list(
    select_country = "Select a country",
    select_countries = "Select countries",
    select_species = "Select species",
    select_category = "Select category",
    toggle_on = "Active",
    toggle_off = "Inactive",
    date_range = "Select date range",
    submit_btn = "Submit",
    option_all = "All",
    option_verified = "Verified",
    option_pending = "Pending"
  ),
  es = list(
    select_country = "Selecciona un país",
    select_countries = "Selecciona países",
    select_species = "Selecciona especies",
    select_category = "Selecciona categoría",
    toggle_on = "Activo",
    toggle_off = "Inactivo",
    date_range = "Selecciona rango de fechas",
    submit_btn = "Enviar",
    option_all = "Todos",
    option_verified = "Verificado",
    option_pending = "Pendiente"
  ),
  fr = list(
    select_country = "Sélectionnez un pays",
    select_countries = "Sélectionnez des pays",
    select_species = "Sélectionnez les espèces",
    select_category = "Sélectionnez une catégorie",
    toggle_on = "Actif",
    toggle_off = "Inactif",
    date_range = "Sélectionnez la plage de dates",
    submit_btn = "Soumettre",
    option_all = "Tous",
    option_verified = "Vérifié",
    option_pending = "En attente"
  )
)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .lang-btn { margin-right: 5px; }
      .component-section {
        margin: 20px 0;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
      }
      .component-section h4 { margin-top: 0; color: #333; }
    "))
  ),

  h2("Translation Demo"),

  # Language switcher
  div(
    style = "margin-bottom: 20px;",
    tags$strong("Select Language: "),
    actionButton("lang_en", "English", class = "lang-btn"),
    actionButton("lang_es", "Español", class = "lang-btn"),
    actionButton("lang_fr", "Français", class = "lang-btn")
  ),

  hr(),

  # Row 1: Select inputs
  fluidRow(
    # Select Input WITH icon
    column(3,
      div(class = "component-section",
        h4("Select (with icon)"),
        select_input(
          inputId = "country",
          placeholder = "select_country",
          options = list(
            list(title = "Kenya", item = "KEN"),
            list(title = "Indonesia", item = "IDN"),
            list(title = "Philippines", item = "PHL")
          ),
          iconClass = "country-flag country-flag-",
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("country_value")
      )
    ),

    # Select Input WITHOUT icon
    column(3,
      div(class = "component-section",
        h4("Select (no icon)"),
        select_input(
          inputId = "category",
          placeholder = "select_category",
          options = list(
            list(title = "Fish", item = "fish"),
            list(title = "Crustacean", item = "crustacean"),
            list(title = "Mollusk", item = "mollusk")
          ),
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("category_value")
      )
    ),

    # Multiple Select Input WITH icon
    column(3,
      div(class = "component-section",
        h4("MultiSelect (with icon)"),
        multiple_select_input(
          inputId = "countries",
          placeholder = "select_countries",
          options = list(
            list(title = "Kenya", item = "KEN"),
            list(title = "Indonesia", item = "IDN"),
            list(title = "Philippines", item = "PHL")
          ),
          iconClass = "country-flag country-flag-",
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("countries_value")
      )
    ),

    # Multiple Select Input WITHOUT icon
    column(3,
      div(class = "component-section",
        h4("MultiSelect (no icon)"),
        multiple_select_input(
          inputId = "species",
          placeholder = "select_species",
          options = list(
            list(title = "Tuna", item = "tuna"),
            list(title = "Shark", item = "shark"),
            list(title = "Lobster", item = "lobster")
          ),
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("species_value")
      )
    )
  ),

  # Row 2: Other components
  fluidRow(
    # Date Range Input
    column(3,
      div(class = "component-section",
        h4("Date Range Input"),
        date_range_input(
          inputId = "dates",
          value = NULL,
          placeholder = "date_range",
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("dates_value")
      )
    ),

    # Toggle Button
    column(3,
      div(class = "component-section",
        h4("Toggle Button"),
        toggle_button(
          inputId = "status",
          value = FALSE,
          onLabel = "toggle_on",
          offLabel = "toggle_off",
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("status_value")
      )
    ),

    # Toggle Text Button
    column(3,
      div(class = "component-section",
        h4("Toggle Text Button"),
        toggle_text_button(
          inputId = "filter",
          value = "option_all",
          options = c("option_all", "option_verified", "option_pending"),
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("filter_value")
      )
    ),

    # Action Button
    column(3,
      div(class = "component-section",
        h4("Action Button"),
        action_button(
          inputId = "submit",
          label = "submit_btn",
          translation_list = translations,
          default_langauge = "en"
        ),
        verbatimTextOutput("submit_value")
      )
    )
  )
)

server <- function(input, output, session) {
  # Language switching
  observeEvent(input$lang_en, {
    session$sendCustomMessage("language_changed", "en")
  })

  observeEvent(input$lang_es, {
    session$sendCustomMessage("language_changed", "es")
  })

  observeEvent(input$lang_fr, {
    session$sendCustomMessage("language_changed", "fr")
  })

  # Output values
  output$country_value <- renderPrint({
    paste("Selected:", input$country)
  })

  output$category_value <- renderPrint({
    paste("Selected:", input$category)
  })

  output$countries_value <- renderPrint({
    paste("Selected:", paste(input$countries, collapse = ", "))
  })

  output$species_value <- renderPrint({
    paste("Selected:", paste(input$species, collapse = ", "))
  })

  output$dates_value <- renderPrint({
    paste("Selected:", paste(input$dates, collapse = " to "))
  })

  output$status_value <- renderPrint({
    paste("Status:", input$status)
  })

  output$filter_value <- renderPrint({
    paste("Filter:", input$filter)
  })

  output$submit_value <- renderPrint({
    paste("Clicks:", input$submit)
  })
}

shinyApp(ui, server)
