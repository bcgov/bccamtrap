library(shiny)
library(bslib)

ui <- page_sidebar(
  theme = bs_theme(version = 5, bootswatch = "cerulean"),
  title = "BC WLRS Camera Trap Data Application",
  sidebar = sidebar(
    accordion(
      accordion_panel(
        title = "Import metadata from SPI sheet",
        "button here"
      ),
      accordion_panel(
        title = "Import metadata from csv field forms",
        "button for sample stations",
        "button for deployments"
      ),
      accordion_panel(
        title = "Import Timelapse image data",
        "Choose a directory or single file",
        "button here"
      )
    )
  ),
  navset_tab(
    nav_panel(
      "Project Metadata"
    ),
    nav_panel(
      "hello"
    ),
    nav_panel(
      "Analysis data"
    ),
    nav_panel(
      "Export to SPI sheet"
    )
  )

)
