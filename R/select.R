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
    iconClass = NULL,
    translation_list = list(
      en = list(`Select value` = "Select value")
    ),
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
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
      iconClass = iconClass,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
    ),
    htmltools::tags$div
  )
}

#' Update Select Input
#'
#' Update Select Input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value The new value (optional)
#' @param options New options list (optional)
#' @param placeholder New placeholder text (optional)
#' @param class New CSS class (optional)
#' @param width New width (optional)
#' @param iconClass New icon class (optional)
#'
#' @export
update_select_input <- function(session, inputId, value = NULL, options = NULL,
                                 placeholder = NULL, class = NULL, width = NULL,
                                 iconClass = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(options) && !is.null(options)) config$options <- options
  if (!missing(placeholder) && !is.null(placeholder)) config$placeholder <- placeholder
  if (!missing(class) && !is.null(class)) config$class <- class
  if (!missing(width) && !is.null(width)) config$width <- width
  if (!missing(iconClass) && !is.null(iconClass)) config$iconClass <- iconClass

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}
