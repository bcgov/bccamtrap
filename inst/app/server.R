library(shiny)

function(input, output, session) {

  spi_meta <- reactiveValues()

  observe({
    spi_meta$proj_info <- read_project_info(req(input$spi_input$datapath))
    spi_meta$sample_station_info <- read_sample_station_info(req(input$spi_input$datapath))
  })

  output$project_table <- renderTable(spi_meta$proj_info)
  output$ssi_table <- renderTable(
    req(spi_meta$sample_station_info) %>%
    dplyr::select(-dplyr::any_of("wlrs_project_name")) %>%
    sf::st_drop_geometry()
  )

}
