#' Multiple Select Input
#'
#' Multiple Select Input
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
multiple_select_input <- function(
    inputId,
    value = NULL,
    options,
    placeholder = 'Select option(s)',
    class = NULL,
    width = NULL,
    iconClass = NULL
  ) {
  reactR::createReactShinyInput(
    inputId,
    "multiple_select",
    htmltools::htmlDependency(
      name = "multiple_select-input",
      version = "1.0.0",
      src = "www/primereact/main_bundle",
      package = "primereact",
      script = "bundle.js"
    ),
    default = value,
    list(
      options = options,
      placeholder = placeholder,
      class = class,
      width = width,
      iconClass = iconClass
    ),
    htmltools::tags$div
  )
}

#' Update a multiple_select input
#'
#' Update a multiple_select input
#'
#' @export
update_multiple_select_input <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
