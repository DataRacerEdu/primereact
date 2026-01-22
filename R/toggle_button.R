#' ToggleButton
#'
#' ToggleButton with optional translation support.
#'
#' @param inputId The input ID
#' @param value Initial value (TRUE/FALSE)
#' @param onLabel Label when toggled on (can be translation key)
#' @param offLabel Label when toggled off (can be translation key)
#' @param onIcon Icon class when toggled on
#' @param offIcon Icon class when toggled off
#' @param class CSS class
#' @param width Width
#' @param disabled Disabled state
#' @param translation_list Optional named list of translations by language
#' @param default_langauge Default language code (default: 'en')
#' @param message_handler_id_from_shiny Shiny message handler ID for language changes
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
toggle_button <- function(
    inputId,
    value = FALSE,
    onLabel = "On",
    offLabel = "Off",
    onIcon = "pi pi-check",
    offIcon = "pi pi-times",
    class = NULL,
    width = NULL,
    disabled = FALSE,
    translation_list = NULL,
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
  ) {
  reactR::createReactShinyInput(
    inputId,
    "toggle_button",
    htmltools::htmlDependency(
      name = "toggle_button-input",
      version = "1.0.0",
      src = "www/primereact/main_bundle",
      package = "primereact",
      script = "bundle.js"
    ),
    default = value,
    list(
      onLabel = onLabel,
      offLabel = offLabel,
      onIcon = onIcon,
      offIcon = offIcon,
      disabled = disabled,
      class = class,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
    ),
    htmltools::tags$div
  )
}

#' Update a toggle_button input
#'
#' Update a toggle_button input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value New toggle value TRUE/FALSE (optional)
#' @param onLabel Label when toggled on (optional)
#' @param offLabel Label when toggled off (optional)
#' @param onIcon Icon when toggled on (optional)
#' @param offIcon Icon when toggled off (optional)
#' @param class CSS class (optional)
#' @param disabled Enable/disable toggle (optional)
#'
#' @export
update_toggle_button <- function(session, inputId, value = NULL, onLabel = NULL,
                                  offLabel = NULL, onIcon = NULL, offIcon = NULL,
                                  class = NULL, disabled = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(onLabel) && !is.null(onLabel)) config$onLabel <- onLabel
  if (!missing(offLabel) && !is.null(offLabel)) config$offLabel <- offLabel
  if (!missing(onIcon) && !is.null(onIcon)) config$onIcon <- onIcon
  if (!missing(offIcon) && !is.null(offIcon)) config$offIcon <- offIcon
  if (!missing(class) && !is.null(class)) config$class <- class
  if (!missing(disabled) && !is.null(disabled)) config$disabled <- disabled

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}
