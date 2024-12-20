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
    iconClass = NULL,
    filter = FALSE,
    filterInputAutoFocus = FALSE,
    translation_list,
    default_langauge = 'en',
    message_handler_id_from_shiny = "language_changed"
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
      iconClass = iconClass,
      filter = filter,
      filterInputAutoFocus = filterInputAutoFocus,
      translation_list = translation_list,
      default_langauge = default_langauge,
      message_handler_id_from_shiny = message_handler_id_from_shiny
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

#' Extract Multi-Select Input
#'
#' Extract Multi-Select Input
#'
#' @export
extract_items_prime_react_multiselect <- function(named_vec, item = "item") {
  named_vec[names(named_vec) %in% item] |> unname()
}
