
function(input, output, session) {

  spi_meta <- reactiveValues()

  observe({
    req(input$spi_input$datapath)
    spi_meta$proj_info <- read_project_info(input$spi_input$datapath)
    spi_meta$sample_station_info <- read_sample_station_info(input$spi_input$datapath) %>%
      qa_stations_spatial()
  })

  output$project_table <- renderTable(spi_meta$proj_info)

  output$ssi_table <- render_gt(
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
  )

  output$ssi_map <- renderLeaflet({
    map <- map_stations(req(spi_meta$sample_station_info))
    map@map
  })

}
