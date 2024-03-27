
function(input, output, session) {

  spi_meta <- reactiveValues()
  image_data <- reactiveVal()

  observeEvent(
    input$spi_input$datapath, {
    spi_meta$proj_info <- read_project_info(input$spi_input$datapath)
    spi_meta$sample_station_info <- read_sample_station_info(input$spi_input$datapath) %>%
      qa_stations_spatial()
    spi_meta$camera_info <- read_camera_info(input$spi_input$datapath)
    spi_meta$cam_seup_checks <- read_cam_setup_checks(input$spi_input$datapath)
  })

  observe({
    req(input$image_input)
    image_data(read_image_data(
      # This is an escape hatch for check_template() in shiny - since the file
      # names assigned from fileInput() are random, we assign the csv files
      # names based on the original filenames, and use those to check the template
      stats::setNames(input$image_input$datapath, input$image_input$name)
    ))
  })

  output$project_table <- renderTable(spi_meta$proj_info)

  output$ssi_table <- render_gt({
    req(spi_meta$sample_station_info) %>%
      select(
        -any_of(
          c("wlrs_project_name", "study_area_name", "code")
        ),
        -starts_with("utm"),
        -starts_with("easting"),
        -starts_with("northing")
      ) %>%
      sf::st_drop_geometry() %>%
      gt() %>%
      cols_width(
        site_description_comments ~ px(400),
        habitat_feature ~ px(150)
      ) %>%
      data_color(columns = spatial_outlier, method = "factor", palette = c("red", "green")) %>%
      opt_interactive(
        use_resizers = TRUE,
        use_compact_mode = TRUE
      )
  })

  output$ssi_map <- renderLeaflet({
    map <- map_stations(req(spi_meta$sample_station_info))
    map@map
  })

  output$ssi_summary <- renderText({
    capture.output(summary(req(spi_meta$sample_station_info)), type = "message")
  })

  output$spi_download <- downloadHandler(
    filename = function() {
      "SPI_submission_form.xlsx"
    },
    content = function(file) {
      req(spi_meta$sample_station_info)
      req(spi_meta$camera_info)
      req(spi_meta$cam_seup_checks)
      req(image_data)
      fill_spi_template(
        spi_meta$sample_station_info,
        spi_meta$camera_info,
        spi_meta$cam_seup_checks,
        image_data(),
        file
      )
    }
  )

}
