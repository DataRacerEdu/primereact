#' Date Range Input
#'
#' Date Range Input
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
    width = NULL
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
      width = width
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
#'
#' @export
update_date_range_input <- function(session, inputId, value = NULL, placeholder = NULL,
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
