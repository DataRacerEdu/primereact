#' ToggleTextButton
#'
#' ToggleTextButton
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
toggle_text_button <- function(
    inputId,
    value = list(value = NULL, name = NULL),
    options,
    disabled = FALSE,
    default_langauge = 'en',
    translation_list = list(
      en = list(`Select value` = "Select value")
    ),
    message_handler_id_from_shiny = "language_changed"
  ) {
  reactR::createReactShinyInput(
    inputId,
    "toggle_text_button",
    htmltools::htmlDependency(
      name = "toggle_text_button-input",
      version = "1.0.0",
      src = "www/primereact/main_bundle",
      package = "primereact",
      script = "bundle.js"
    ),
    default = value,
    list(
      options = options,
      disabled = disabled,
      default_langauge = default_langauge,
      translation_list = translation_list,
      message_handler_id_from_shiny = message_handler_id_from_shiny
    ),
    htmltools::tags$div
  )
}

#' Update a toggle_text_button input
#'
#' Update a toggle_text_button input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value New value (optional)
#' @param options New options list (optional)
#' @param disabled Enable/disable the input (optional)
#'
#' @export
update_toggle_text_button <- function(session, inputId, value = NULL, options = NULL,
                                       disabled = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(options) && !is.null(options)) config$options <- options
  if (!missing(disabled) && !is.null(disabled)) config$disabled <- disabled

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}
