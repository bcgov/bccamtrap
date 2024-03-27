
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
      ),
      open = c("Metadata from SPI Worksheet", "TimeLapse Image Data")
    ),
    "Write to SPI worksheet",
    downloadButton(
      "spi_download"
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
            textOutput("ssi_summary")
          )
        )
      )
    ),
    nav_panel(
      "Deployments",
      gt_output("deployments_table")
    ),
    nav_panel(
      "Image Data QA",
      layout_columns(
        card(radioButtons(
          "rb_exclude_human",
          "Exclude Human Use?",
          choices = c("Yes", "No"),
          selected = "Yes",
          inline = TRUE
        )),
        card(radioButtons(
          "rb_check_snow",
          "Check Snow Depth?",
          choices = c("Yes", "No"),
          selected = "Yes",
          inline = TRUE
        )),
        card(sliderInput(
          "tl_time",
          "TimeLapse photo time",
          min = as.POSIXct("2020-01-01 00:00:00", tz = "UTC"),
          max = as.POSIXct("2020-01-01 23:59:59", tz = "UTC"),
          value = as.POSIXct("2020-01-01 12:00:00", tz = "UTC"),
          timeFormat = "%T",
          timezone = "+0000"
        )),
        actionButton(
          "btn_qa_image_data",
          "Check!",
          class = "btn-lg btn-success"
        )
      ),
      card(
        verbatimTextOutput("img_qa_summary")
      ),
      shinycssloaders::withSpinner(
        gt_output("image_qa_table"),
        type = 5,
        color = "darkgrey"
      )
    ),
    nav_panel(
      "Sample Sessions",
      gt_output("sessions_table")
    ),
    nav_panel(
      "Analysis data"
    ),
    nav_panel(
      "Export to SPI sheet"
    )
  )

)
