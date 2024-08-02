#' ToggleButton
#'
#' ToggleButton
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
    width = NULL
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
      class = class
    ),
    htmltools::tags$div
  )
}

#' Update a toggle_button input
#'
#' Update a toggle_button input
#'
#' @export
update_toggle_button <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
