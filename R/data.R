#' Available Country Flags
#'
#' A data frame containing country codes and names for the embedded country flag icons.
#' Use these codes with `iconClass = "country-flag country-flag-"` in select_input.
#'
#' @format A data frame with 26 rows and 3 columns:
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
  code = c("blz", "bra", "cv", "com", "fsm", "gha", "gmb", "gnb", "gtm", "hnd",
           "ind", "idn", "ken", "mdg", "mex", "mmr", "moz", "mus", "phl", "plw",
           "png", "sen", "som", "tha", "tl", "tza"),
  name = c("Belize", "Brazil", "Cape Verde", "Comoros", "Micronesia", "Ghana",
           "Gambia", "Guinea-Bissau", "Guatemala", "Honduras", "India", "Indonesia",
           "Kenya", "Madagascar", "Mexico", "Myanmar", "Mozambique", "Mauritius",
           "Philippines", "Palau", "Papua New Guinea", "Senegal", "Somalia",
           "Thailand", "East Timor", "Tanzania"),
  code_upper = c("BLZ", "BRA", "CV", "COM", "FSM", "GHA", "GMB", "GNB", "GTM", "HND",
                 "IND", "IDN", "KEN", "MDG", "MEX", "MMR", "MOZ", "MUS", "PHL", "PLW",
                 "PNG", "SEN", "SOM", "THA", "TL", "TZA"),
  stringsAsFactors = FALSE
)
