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
#' Update Action Button Input for Shiny from PrimeReact module.
#' Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param label New button label (optional)
#' @param icon New icon (optional)
#' @param iconPos Icon position: "left" or "right" (optional)
#' @param disabled Enable/disable button (optional)
#' @param rounded Enable/disable rounded style (optional)
#' @param text Enable/disable text style (optional)
#' @param raised Enable/disable raised style (optional)
#' @param outlined Enable/disable outlined style (optional)
#' @param size Button size: "small", "normal", "large" (optional)
#'
#' @export
update_action_button <- function(session, inputId, label = NULL, icon = NULL,
                                  iconPos = NULL, disabled = NULL, rounded = NULL,
                                  text = NULL, raised = NULL, outlined = NULL,
                                  size = NULL) {
  message <- list()
  config <- list()

  if (!missing(label) && !is.null(label)) config$label <- label
  if (!missing(icon) && !is.null(icon)) config$icon <- icon
  if (!missing(iconPos) && !is.null(iconPos)) config$iconPos <- iconPos
  if (!missing(disabled) && !is.null(disabled)) config$disabled <- disabled
  if (!missing(rounded) && !is.null(rounded)) config$rounded <- rounded
  if (!missing(text) && !is.null(text)) config$text <- text
  if (!missing(raised) && !is.null(raised)) config$raised <- raised
  if (!missing(outlined) && !is.null(outlined)) config$outlined <- outlined
  if (!missing(size) && !is.null(size)) config$size <- size

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}

