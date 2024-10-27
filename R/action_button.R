#' Action Button Input
#'
#' Action Button Input for Shiny from PrimeReact module
#'
#' @importFrom reactR createReactShinyInput
#' @importFrom htmltools htmlDependency tags
#'
#' @export
action_button <- function(
    inputId,
    label,
    icon = NULL,
    iconPos = "right",
    disabled = FALSE,
    rounded = FALSE,
    text = FALSE,
    raised = FALSE,
    outlined = FALSE,
    size = "normal"
  ) {
  reactR::createReactShinyInput(
    inputId,
    "action_button",
    htmltools::htmlDependency(
      name = "action_button-input",
      version = "1.0.0",
      src = "www/primereact/main_bundle",
      stylesheet = "primeicons.css",
      package = "primereact",
      script = "bundle.js"
    ),
    default = NULL,
    list(
      label = label,
      icon = icon,
      iconPos = iconPos,
      disabled = disabled,
      rounded = rounded,
      text = text,
      raised = raised,
      outlined = outlined,
      size = size
    ),
    htmltools::tags$div
  )
}

#' Update Action Button Input
#'
#' Update Action Button Input for Shiny from PrimeReact module
#'
#' @export
update_action_button <- function(session, inputId, configuration = NULL) {
  message <- list()
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}

