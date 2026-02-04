#' Date Input
#'
#' Single Date Input with optional translation support.
#'
#' @param inputId The input ID
#' @param value Initial date value
#' @param placeholder Placeholder text (can be translation key)
#' @param class CSS class
#' @param minDate Minimum selectable date
#' @param maxDate Maximum selectable date
#' @param width Width
#' @param translation_list Optional named list of translations by language
#' @param default_langauge Default language code (default: 'en')
#' @param message_handler_id_from_shiny Shiny message handler ID for language changes
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
date_input <- function(
    inputId,
    value = NULL,
    placeholder = NULL,
    class = NULL,
    minDate = NULL,
    maxDate = NULL,
    width = NULL,
    translation_list = NULL,
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
) {
  reactR::createReactShinyInput(
    inputId,
    "date_input",
    htmltools::htmlDependency(
      name = "date_input-input",
      version = "1.0.0",
      src = "www/primereact/main_bundle",
      package = "primereact",
      script = "bundle.js"
    ),
    default = value,
    list(
      placeholder = placeholder,
      class = class,
      minDate = minDate,
      maxDate = maxDate,
      width = width,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
    ),
    htmltools::tags$div
  )
}

#' Update Date Input
#'
#' Update Date Input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value New date value (optional)
#' @param placeholder New placeholder text (optional)
#' @param class New CSS class (optional)
#' @param minDate New minimum date (optional)
#' @param maxDate New maximum date (optional)
#' @param width New width (optional)
#'
#' @export
update_date_input <- function(session, inputId, value = NULL, placeholder = NULL,
                               class = NULL, minDate = NULL, maxDate = NULL,
                               width = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(placeholder) && !is.null(placeholder)) config$placeholder <- placeholder
  if (!missing(class) && !is.null(class)) config$class <- class
  if (!missing(minDate) && !is.null(minDate)) config$minDate <- minDate
  if (!missing(maxDate) && !is.null(maxDate)) config$maxDate <- maxDate
  if (!missing(width) && !is.null(width)) config$width <- width

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}
