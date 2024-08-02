#' Select Input
#'
#' Select Input
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
select_input <- function(
    inputId,
    value = NULL,
    options,
    placeholder = 'Select value',
    class = NULL,
    width = NULL,
    iconClass = NULL
  ) {
  reactR::createReactShinyInput(
    inputId,
    "select",
    htmltools::htmlDependency(
      name = "select-input",
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

#' Update Select Input
#'
#' Update Select Input
#'
#' @export
update_select_input <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
