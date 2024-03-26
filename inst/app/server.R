
function(input, output, session) {

  spi_meta <- reactiveValues()

  observe({
    req(input$spi_input$datapath)
    spi_meta$proj_info <- read_project_info(input$spi_input$datapath)
    spi_meta$sample_station_info <- read_sample_station_info(input$spi_input$datapath) %>%
      qa_stations_spatial()
  })

  output$project_table <- renderTable(spi_meta$proj_info)

  output$ssi_table <- renderDT(
    req(spi_meta$sample_station_info) %>%
      dplyr::select(-dplyr::any_of("wlrs_project_name")) %>%
      sf::st_drop_geometry()
  )


  output$ssi_map <- renderLeaflet({
    map <- map_stations(req(spi_meta$sample_station_info))
    map@map
  })

}
