#' Country Flags Icons (Auto-loaded)
#'
#' Country flag icons are automatically embedded in the primereact package.
#' No need to call this function - icons are bundled and load automatically.
#'
#' Use with select_input or multiple_select_input by setting:
#' iconClass = "country-flag country-flag-"
#'
#' @return NULL (invisibly). Icons are auto-loaded with the package.
#'
#' @examples
#' \dontrun{
#' ui <- fluidPage(
#'   # No need to call use_country_flags() - auto-loaded!
#'   select_input(
#'     inputId = "country",
#'     value = NULL,
#'     options = list(
#'       list(title = "Kenya", item = "KEN"),
#'       list(title = "Indonesia", item = "IDN")
#'     ),
#'     iconClass = "country-flag country-flag-"
#'   )
#' )
#' }
#'
#' @export
use_country_flags <- function() {
 message("Country flags are auto-loaded with primereact. No action needed.")
 message("Use: iconClass = 'country-flag country-flag-'")
 invisible(NULL)
}
