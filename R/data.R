#' Available Country Flags
#'
#' A data frame containing country codes and names for the embedded country flag icons.
#' Use these codes with `iconClass = "country-flag country-flag-"` in select_input.
#'
#' @format A data frame with 22 rows and 3 columns:
#' \describe{
#'   \item{code}{Country code (lowercase) - use as `item` value}
#'   \item{name}{Country name - use as `title` value}
#'   \item{code_upper}{Country code (uppercase) - alternative `item` value}
#' }
#'
#' @examples
#' # View available countries
#' primereact::country_flags
#'
#' # Use in select_input
#' \dontrun{
#' select_input(
#'   inputId = "country",
#'   options = lapply(1:nrow(country_flags), function(i) {
#'     list(title = country_flags$name[i], item = country_flags$code_upper[i])
#'   }),
#'   iconClass = "country-flag country-flag-"
#' )
#' }
#'
#' @export
country_flags <- data.frame(
  code = c("blz", "cv", "com", "fsm", "gmb", "gtm", "hnd", "ind", "idn", "ken",
           "mdg", "mex", "mmr", "moz", "mus", "phl", "png", "sen", "som", "tha",
           "tl", "tza"),
  name = c("Belize", "Cape Verde", "Comoros", "Micronesia", "Gambia", "Guatemala",
           "Honduras", "India", "Indonesia", "Kenya", "Madagascar", "Mexico",
           "Myanmar", "Mozambique", "Mauritius", "Philippines", "Papua New Guinea",
           "Senegal", "Somalia", "Thailand", "East Timor", "Tanzania"),
  code_upper = c("BLZ", "CV", "COM", "FSM", "GMB", "GTM", "HND", "IND", "IDN", "KEN",
                 "MDG", "MEX", "MMR", "MOZ", "MUS", "PHL", "PNG", "SEN", "SOM", "THA",
                 "TL", "TZA"),
  stringsAsFactors = FALSE
)
