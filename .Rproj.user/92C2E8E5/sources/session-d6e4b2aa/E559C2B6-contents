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
#' Update Date Range Input
#'
#' @export
update_date_range_input <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
