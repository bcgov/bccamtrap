
ui <- page_sidebar(
  tags$head(
    tags$style(
      HTML(".shiny-notification {
             position:fixed;
             top: calc(50%);
             left: calc(50%);
             }
             "
      )
    )
  ),
  theme = bs_theme(version = 5, bootswatch = "sandstone"),
  title = "BC WLRS Camera Trap Data Application",
  sidebar = sidebar(
    title = "",
    h4("Metadata input"),
    span(HTML("Choose either Metadata from SPI worksheet <em>OR</em> Metadata from Field Forms")),
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
      open = FALSE,
      multiple = FALSE
    ),
    h4("Image Data Import"),
    fileInput(
      "image_input",
      "select all files",
      accept = c(".csv"),
      multiple = TRUE
    ),
    hr(),
    h4("Data export"),
    "Write to SPI worksheet",
    downloadButton(
      "spi_download"
    ),
    "Download consolidated image data",
    downloadButton(
      "img_data_download"
    )
  ),
  navset_card_tab(
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
            leaflet::leafletOutput("ssi_map", height = 600)
          ),
          # card(
          #   textOutput("ssi_summary")
          # )
        )
      )
    ),
    nav_panel(
      "Deployments",
      navset_pill(
        nav_panel(
          "Deployments Plot",
          ggiraph::girafeOutput("deployments_plot", width = "90%", height = "90%")
        ),
        nav_panel("Deployments Table", gt_output("deployments_table"))
      ),
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
        ), class = "text-center"),
        card(radioButtons(
          "rb_check_snow",
          "Check Snow Depth?",
          choices = c("Yes", "No"),
          selected = "Yes",
          inline = TRUE
        ), class = "text-center"),
        card(sliderInput(
          "tl_time",
          "TimeLapse photo time",
          min = as.POSIXct("2020-01-01 00:00:00", tz = "UTC"),
          max = as.POSIXct("2020-01-01 23:59:59", tz = "UTC"),
          value = as.POSIXct("2020-01-01 12:00:00", tz = "UTC"),
          step = 60,
          width = "100%",
          timeFormat = "%H:%M",
          timezone = "+0000"
        ), class = "text-center"),
        div(actionButton(
          "btn_qa_image_data",
          "Check!",
          class = "btn-lg btn-success",
          style = "margin-top: 40px;"
        ), class = "text-center"
        ),
        fill = FALSE,
        gap = "3em",
        height = "150px"
      ),
      uiOutput("img_qa_summary"),
      shinycssloaders::withSpinner(
        gt_output("image_qa_table"),
        type = 5,
        color = "darkgrey"
      )
    ),
    nav_panel(
      "QA Deployments vs Images",
      navset_pill(
        nav_panel("Deployments vs Images Summary", uiOutput("qa_deps_imgs")),
        nav_panel(
          "Deployments vs Images Plot",
          ggiraph::girafeOutput("deployments_images_plot", width = "90%", height = "90%")
        )
      )
    ),
    nav_panel(
      "Sample Sessions",
      uiOutput("ss_opts"),
      gt_output("sessions_table")
    ),
    nav_panel(
      "Analysis data",
      navset_pill(
        nav_panel(
          "Sample RAI",
          uiOutput("sample_rai_opts"),
          gt_output("sample_rai_table")
        ),
        nav_panel(
          "RAI over time",
          uiOutput("rai_by_time_opts"),
          gt_output("rai_by_time_table")
        )
      )
    ),
    header = br()
  )

)
