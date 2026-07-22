# Extract the configuration JSON that createReactShinyInput embeds in a
# <script id="<inputId>_configuration"> tag
extract_config <- function(tag, inputId) {
  html <- as.character(htmltools::renderTags(tag)$html)
  pattern <- paste0('<script [^>]*id="', inputId, '_configuration"[^>]*>(.*?)</script>')
  m <- regmatches(html, regexec(pattern, html))[[1]]
  expect_length(m, 2)
  jsonlite::fromJSON(m[2])
}

make_session <- function() {
  recorded <- new.env()
  list(
    sendInputMessage = function(inputId, message) {
      recorded$inputId <- inputId
      recorded$message <- message
    },
    recorded = recorded
  )
}

# --- date_input -------------------------------------------------------------

test_that("date_input defaults to readonly = TRUE", {
  config <- extract_config(date_input("d1"), "d1")
  expect_true(config$readonly)
})

test_that("date_input readonly = FALSE is passed to the component", {
  config <- extract_config(date_input("d1", readonly = FALSE), "d1")
  expect_false(config$readonly)
})

test_that("date_input dateFormat defaults to mm/dd/yy and can be customized", {
  config <- extract_config(date_input("d1"), "d1")
  expect_equal(config$dateFormat, "mm/dd/yy")

  config <- extract_config(date_input("d1", dateFormat = "dd.mm.yy"), "d1")
  expect_equal(config$dateFormat, "dd.mm.yy")
})

test_that("date_input keeps other configuration alongside readonly", {
  config <- extract_config(
    date_input("d1", placeholder = "Pick", minDate = "2026-01-01", maxDate = "2026-12-31"),
    "d1"
  )
  expect_equal(config$placeholder, "Pick")
  expect_equal(config$minDate, "2026-01-01")
  expect_equal(config$maxDate, "2026-12-31")
  expect_true(config$readonly)
})

test_that("update_date_input sends readonly when supplied", {
  session <- make_session()
  update_date_input(session, "d1", readonly = TRUE)
  expect_equal(session$recorded$inputId, "d1")
  expect_true(session$recorded$message$configuration$readonly)

  update_date_input(session, "d1", readonly = FALSE)
  expect_false(session$recorded$message$configuration$readonly)
})

test_that("update_date_input omits readonly when not supplied", {
  session <- make_session()
  update_date_input(session, "d1", placeholder = "New")
  expect_null(session$recorded$message$configuration$readonly)
  expect_equal(session$recorded$message$configuration$placeholder, "New")
})

test_that("update_date_input sends dateFormat when supplied, omits otherwise", {
  session <- make_session()
  update_date_input(session, "d1", dateFormat = "dd.mm.yy")
  expect_equal(session$recorded$message$configuration$dateFormat, "dd.mm.yy")

  update_date_input(session, "d1", placeholder = "New")
  expect_null(session$recorded$message$configuration$dateFormat)
})

# --- date_range_input -------------------------------------------------------

test_that("date_range_input defaults to readonly = TRUE", {
  config <- extract_config(
    date_range_input("r1", value = c("2026-01-01", "2026-01-10")),
    "r1"
  )
  expect_true(config$readonly)
})

test_that("date_range_input readonly = FALSE is passed to the component", {
  config <- extract_config(
    date_range_input("r1", value = c("2026-01-01", "2026-01-10"), readonly = FALSE),
    "r1"
  )
  expect_false(config$readonly)
})

test_that("update_date_range_input sends readonly when supplied", {
  session <- make_session()
  update_date_range_input(session, "r1", readonly = TRUE)
  expect_equal(session$recorded$inputId, "r1")
  expect_true(session$recorded$message$configuration$readonly)
})

test_that("update_date_range_input omits readonly when not supplied", {
  session <- make_session()
  update_date_range_input(session, "r1", width = "200px")
  expect_null(session$recorded$message$configuration$readonly)
  expect_equal(session$recorded$message$configuration$width, "200px")
})

test_that("date_range_input dateFormat defaults to mm/dd/yy and can be customized", {
  config <- extract_config(
    date_range_input("r1", value = c("2026-01-01", "2026-01-10")),
    "r1"
  )
  expect_equal(config$dateFormat, "mm/dd/yy")

  config <- extract_config(
    date_range_input("r1", value = c("2026-01-01", "2026-01-10"), dateFormat = "dd.mm.yy"),
    "r1"
  )
  expect_equal(config$dateFormat, "dd.mm.yy")
})

test_that("update_date_range_input sends dateFormat when supplied", {
  session <- make_session()
  update_date_range_input(session, "r1", dateFormat = "dd.mm.yy")
  expect_equal(session$recorded$message$configuration$dateFormat, "dd.mm.yy")
})
