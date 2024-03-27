
ui <- page_sidebar(
  theme = bs_theme(version = 5, bootswatch = "cerulean"),
  title = "BC WLRS Camera Trap Data Application",
  sidebar = sidebar(
    accordion(
      accordion_panel(
        "Metadata from SPI Worksheet",
        fileInput(
          "spi_input",
          "Choose SPI Excel File",
          accept = c(".xls", ".xlsx", ".xlsm")
        )
      ),
      accordion_panel(
        "Metadata from csv Field Forms",
        fileInput(
          "ff_stations_input",
          "Choose Sample Stations Field Form csv",
          accept = ".csv"
        ),
        fileInput(
          "ff_deployments_input",
          "Choose Deployments Field Form csv",
          accept = c(".csv")
        )
      ),
      accordion_panel(
        "TimeLapse Image Data",
        fileInput(
          "image_input",
          "Import Timelapse image data - select all files",
          accept = c(".csv"),
          multiple = TRUE
        )
      )
    )
  ),
  navset_tab(
    nav_panel(
      "Project Metadata",
      card(
        "Project Information",
        tableOutput("project_table")
      ),
      navset_pill(
        nav_panel(
          "Sample Station Information",
          gt_output("ssi_table")
        ),
        nav_panel(
          "Sample Station Map",
          card(
            leafletOutput("ssi_map", height = 600)
          ),
          card(
            verbatimTextOutput("ssi_qa_spatial")
          )
        )
      )
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
