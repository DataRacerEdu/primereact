#' Date Range Input
#'
#' Date Range Input with optional translation support.
#'
#' @param inputId The input ID
#' @param value Initial date range value
#' @param placeholder Placeholder text (can be translation key)
#' @param class CSS class
#' @param minDate Minimum selectable date
#' @param maxDate Maximum selectable date
#' @param width Width
#' @param readonly If TRUE (default), dates can only be picked from the
#'   calendar popup; set to FALSE to also let the user type the dates directly
#'   in the format given by `dateFormat`
#' @param dateFormat Display (and typing) format for the dates, using
#'   PrimeReact tokens: `dd` = day, `mm` = month, `yy` = 4-digit year,
#'   `y` = 2-digit year. Default `"mm/dd/yy"` (i.e. MM/DD/YYYY). The Shiny
#'   input value is always returned as `"yyyy-mm-dd"` regardless of this
#'   setting.
#' @param translation_list Optional named list of translations by language
#' @param default_langauge Default language code (default: 'en')
#' @param message_handler_id_from_shiny Shiny message handler ID for language changes
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
date_range_input <- function(
    inputId,
    value,
    placeholder = NULL,
    class = NULL,
    minDate = NULL,
    maxDate = NULL,
    width = NULL,
    readonly = TRUE,
    dateFormat = "mm/dd/yy",
    translation_list = NULL,
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
) {
  reactR::createReactShinyInput(
    inputId,
    "date_range",
    htmltools::htmlDependency(
      name = "date_range-input",
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
      readonly = readonly,
      dateFormat = dateFormat,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
    ),
    htmltools::tags$div
  )
}

#' Update Date Range Input
#'
#' Update Date Range Input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value New date range value (optional)
#' @param placeholder New placeholder text (optional)
#' @param class New CSS class (optional)
#' @param minDate New minimum date (optional)
#' @param maxDate New maximum date (optional)
#' @param width New width (optional)
#' @param readonly New readonly setting (optional)
#' @param dateFormat New date format (optional)
#'
#' @export
update_date_range_input <- function(session, inputId, value = NULL, placeholder = NULL,
                                     class = NULL, minDate = NULL, maxDate = NULL,
                                     width = NULL, readonly = NULL, dateFormat = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(placeholder) && !is.null(placeholder)) config$placeholder <- placeholder
  if (!missing(class) && !is.null(class)) config$class <- class
  if (!missing(minDate) && !is.null(minDate)) config$minDate <- minDate
  if (!missing(maxDate) && !is.null(maxDate)) config$maxDate <- maxDate
  if (!missing(width) && !is.null(width)) config$width <- width
  if (!missing(readonly) && !is.null(readonly)) config$readonly <- readonly
  if (!missing(dateFormat) && !is.null(dateFormat)) config$dateFormat <- dateFormat

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}
