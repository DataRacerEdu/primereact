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
    value,
    options
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
      options = options
    ),
    htmltools::tags$div
  )
}

#' Update a toggle_text_button input
#'
#' Update a toggle_text_button input
#'
#' @export
update_toggle_text_button <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
