# primereact <img src="man/figures/logo.svg" align="right" height="139" />

PrimeReact components for R Shiny applications.

## Installation

```r
# Install from local source
devtools::install_local("path/to/primereact")
```

## Components

- `select_input()` - Dropdown select
- `multiple_select_input()` - Multi-select dropdown
- `action_button()` - Action button
- `toggle_button()` - Toggle button
- `toggle_text_button()` - Text-based toggle button
- `date_input()` - Single date picker
- `date_range_input()` - Date range picker

Each component has a corresponding `update_*()` function for dynamic updates.

## Date Inputs

By default, dates can only be picked from the calendar popup (`readonly = TRUE`).
Set `readonly = FALSE` to also let users type the date directly into the field.
Typed dates are validated against the active `dateFormat` and against
`minDate`/`maxDate` by the underlying PrimeReact Calendar.

The display (and typing) format is controlled by `dateFormat`, using PrimeReact
tokens: `dd` = day, `mm` = month, `yy` = 4-digit year, `y` = 2-digit year.
The default is `"mm/dd/yy"` (i.e. `MM/DD/YYYY`). The Shiny input value is
always returned as `"yyyy-mm-dd"` regardless of the display format.

```r
date_input("start")                            # popup only (default)
date_input("start", readonly = FALSE)          # popup + typed MM/DD/YYYY
date_input("start", dateFormat = "dd.mm.yy")   # display as DD.MM.YYYY

# Change at runtime
update_date_input(session, "start", readonly = FALSE, dateFormat = "dd.mm.yy")
```

The same `readonly` and `dateFormat` parameters are available on
`date_range_input()` / `update_date_range_input()`, where a typed range uses
the form `<date> - <date>`.

## Icons

### Embedded Country Flags (Auto-loaded)

Country flag icons are bundled with the package and load automatically.

```r
library(shiny)
library(primereact)

ui <- fluidPage(
  select_input(
    inputId = "country",
    options = list(
      list(title = "Kenya", item = "KEN"),
      list(title = "Indonesia", item = "IDN"),
      list(title = "Philippines", item = "PHL")
    ),
    iconClass = "country-flag country-flag-"
  )
)
```

**Available countries:** See `primereact::country_flags` for all codes and names.

```r
# View available countries
primereact::country_flags

# Use programmatically
options <- lapply(1:nrow(country_flags), function(i) {
  list(title = country_flags$name[i], item = country_flags$code_upper[i])
})
```

### Custom Icons

Use `generate_icon_css()` to create icons from your own images.

#### Step 1: Prepare images

```
my_app/
└── source_images/
    ├── shark.png
    ├── crab.png
    └── lobster.png
```

#### Step 2: Generate CSS

```r
library(primereact)

generate_icon_css(
  images_dir = "source_images",
  output_dir = "www/species_icons",
  prefix = "species-"
)
```

This creates:
```
my_app/
└── www/
    └── species_icons/
        ├── icons.css
        ├── shark.png
        ├── crab.png
        └── lobster.png
```

#### Step 3: Use in app

```r
library(shiny)
library(primereact)

ui <- fluidPage(
  tags$link(rel = "stylesheet", href = "species_icons/icons.css"),

  select_input(
    inputId = "species",
    options = list(
      list(title = "Shark", item = "shark"),
      list(title = "Crab", item = "crab"),
      list(title = "Lobster", item = "lobster")
    ),
    iconClass = "species-"
  )
)
```

**Important:** The `item` value must match the image filename (lowercase, without extension).

### Custom Icons with Mapping

When image filenames differ from desired codes, use the `mapping` parameter:

```r
generate_icon_css(
  images_dir = "source_images",
  output_dir = "www/flags",
  prefix = "flag-",
  mapping = list(
    "kenya.png" = "ken",
    "indonesia.png" = "idn",
    "philippines.png" = "phl"
  )
)
```

This creates:
- `kenya.png` → `.flag-ken` → use with `item = "ken"`
- `indonesia.png` → `.flag-idn` → use with `item = "idn"`

```r
select_input(
  inputId = "country",
  options = list(
    list(title = "Kenya", item = "ken"),
    list(title = "Indonesia", item = "idn")
  ),
  iconClass = "flag-"
)
```

### generate_icon_css() Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `images_dir` | required | Source folder with images |
| `output_dir` | required | Output folder for CSS + images |
| `prefix` | `"icon-"` | CSS class prefix |
| `css_filename` | `"icons.css"` | Generated CSS filename |
| `width` | `24` | Icon width in pixels |
| `height` | `18` | Icon height in pixels |
| `mapping` | `NULL` | Optional filename → code mapping |
| `overwrite` | `FALSE` | Overwrite existing files |

## Translation Support (Optional)

All primereact components support optional key-based translation for dynamic language switching.

### Step 1: Define translations

Create a named list where keys are language codes and values are translation dictionaries:

```r
translations <- list(
  en = list(
    my_placeholder = "Select a country",
    btn_submit = "Submit"
  ),
  es = list(
    my_placeholder = "Selecciona un país",
    btn_submit = "Enviar"
  )
)
```

### Step 2: Use translation keys in components

Pass `translation_list` and use keys (not text) for translatable fields:

```r
select_input(
  inputId = "country",
  placeholder = "my_placeholder",
  options = list(...),
  translation_list = translations,
  default_langauge = "en"
)
```

### Step 3: Switch language from server

Send a message to change language:

```r
server <- function(input, output, session) {
  observeEvent(input$lang_es, {
    session$sendCustomMessage("language_changed", "es")
  })
}
```

### Complete Example

```r
library(shiny)
library(primereact)

translations <- list(
  en = list(select_item = "Select item", btn_go = "Go"),
  es = list(select_item = "Seleccionar", btn_go = "Ir")
)

ui <- fluidPage(
  actionButton("lang_en", "EN"),
  actionButton("lang_es", "ES"),

  select_input(
    inputId = "item",
    placeholder = "select_item",
    options = list(list(title = "A", item = "a"), list(title = "B", item = "b")),
    translation_list = translations,
    default_langauge = "en"
  ),

  action_button(
    inputId = "go",
    label = "btn_go",
    translation_list = translations,
    default_langauge = "en"
  )
)

server <- function(input, output, session) {
  observeEvent(input$lang_en, {
    session$sendCustomMessage("language_changed", "en")
  })
  observeEvent(input$lang_es, {
    session$sendCustomMessage("language_changed", "es")
  })
}

shinyApp(ui, server)
```

### Translatable Fields by Component

| Component | Translatable Fields |
|-----------|---------------------|
| `select_input()` | `placeholder` |
| `multiple_select_input()` | `placeholder` |
| `toggle_button()` | `onLabel`, `offLabel` |
| `toggle_text_button()` | `options` |
| `date_range_input()` | `placeholder` |
| `action_button()` | `label` |

### Translation Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `translation_list` | `NULL` | Named list of translations by language |
| `default_langauge` | `'en'` | Default language code |
| `message_handler_id_from_shiny` | `"language_changed"` | Shiny message handler ID |

### Without Translation

Simply omit translation parameters to use plain text:

```r
select_input(
  inputId = "country",
  placeholder = "Select a country",
  options = list(...)
)
```

## Development

### Build JS bundle

```bash
npm install
npm run build
```

### Watch mode

```bash
npm run watch
```

### Add new component

```r
reactR::scaffoldReactShinyInput(
  "<component_name>",
  list("primereact" = "^10.8.0")
)
```

## Examples

See the `examples/` folder:
- `app1/` - Component update tests
- `app2/` - Custom icons demo
- `app3/` - Translation demo (English, Spanish, French)
