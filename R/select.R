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
#' Update Select Input
#'
#' @export
update_select_input <- function(session, inputId, value, configuration = NULL) {
  message <- list(value = value)
  if (!is.null(configuration)) message$configuration <- configuration
  session$sendInputMessage(inputId, message);
}
