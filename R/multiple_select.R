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
    translation_list = list(
      en = list(`Select value` = "Select value")
    ),
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
#' Update a multiple_select input. Only pass the parameters you want to update.
#'
#' @param session The Shiny session object
#' @param inputId The input ID
#' @param value The new value (optional)
#' @param options New options list (optional)
#' @param placeholder New placeholder text (optional)
#' @param class New CSS class (optional)
#' @param width New width (optional)
#' @param iconClass New icon class (optional)
#' @param filter Enable/disable filter (optional)
#' @param filterInputAutoFocus Enable/disable filter auto focus (optional)
#'
#' @export
update_multiple_select_input <- function(session, inputId, value = NULL, options = NULL,
                                          placeholder = NULL, class = NULL, width = NULL,
                                          iconClass = NULL, filter = NULL,
                                          filterInputAutoFocus = NULL) {
  message <- list()
  config <- list()

  # Use list assignment to preserve NULL values
  if (!missing(value)) message["value"] <- list(value)
  if (!missing(options) && !is.null(options)) config$options <- options
  if (!missing(placeholder) && !is.null(placeholder)) config$placeholder <- placeholder
  if (!missing(class) && !is.null(class)) config$class <- class
  if (!missing(width) && !is.null(width)) config$width <- width
  if (!missing(iconClass) && !is.null(iconClass)) config$iconClass <- iconClass
  if (!missing(filter) && !is.null(filter)) config$filter <- filter
  if (!missing(filterInputAutoFocus) && !is.null(filterInputAutoFocus)) config$filterInputAutoFocus <- filterInputAutoFocus

  if (length(config) > 0) message$configuration <- config
  if (length(message) > 0) {
    session$sendInputMessage(inputId, message)
  }
}

#' Extract Multi-Select Input
#'
#' Extract Multi-Select Input
#'
#' @export
extract_items_prime_react_multiselect <- function(named_vec, item = "item") {
  named_vec[names(named_vec) %in% item] |> unname()
}
