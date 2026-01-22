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
- `date_range_input()` - Date range picker

Each component has a corresponding `update_*()` function for dynamic updates.

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
