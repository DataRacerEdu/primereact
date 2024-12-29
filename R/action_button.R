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
    translation_list = list(
      en = list(`Select value` = "Select value")
    ),
    icon = NULL,
    iconPos = "right",
    disabled = FALSE,
    rounded = FALSE,
    text = FALSE,
    raised = FALSE,
    outlined = FALSE,
    size = "normal",
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
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
      size = size,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
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

