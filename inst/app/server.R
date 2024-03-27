
function(input, output, session) {

  spi_meta <- reactiveValues()

  observeEvent(
    input$spi_input$datapath, {
      spi_meta$proj_info <- read_project_info(input$spi_input$datapath)
      spi_meta$sample_station_info <- read_sample_station_info(input$spi_input$datapath) %>%
        qa_stations_spatial()
      spi_meta$camera_info <- read_camera_info(input$spi_input$datapath)
      spi_meta$cam_seup_checks <- read_cam_setup_checks(input$spi_input$datapath)
      spi_meta$deployments <- make_deployments(input$spi_input$datapath)
    })

  image_data <- reactive({
    req(input$image_input)
    read_image_data(
      # This is an escape hatch for check_template() in shiny - since the file
      # names assigned from fileInput() are random, we assign the csv files
      # names based on the original filenames, and use those to check the template
      stats::setNames(input$image_input$datapath, input$image_input$name)
    )
  })


  output$project_table <- renderTable(spi_meta$proj_info)


# Sample station info -----------------------------------------------------

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
        sample_station_comments ~ px(300),
        site_description_comments ~ px(400),
        habitat_feature ~ px(150)
      ) %>%
      data_color(columns = spatial_outlier, method = "factor", palette = c("#1E88E5", "#D81B60")) %>%
      opt_interactive(
        use_resizers = TRUE,
        use_compact_mode = TRUE
      ) %>%
      opt_row_striping()
  })

  output$ssi_map <- renderLeaflet({
    map <- map_stations(req(spi_meta$sample_station_info))
    map@map
  })

  output$ssi_summary <- renderText({
    capture.output(summary(req(spi_meta$sample_station_info)), type = "message")
  })


# Deployments ------------------------------------------------

  output$deployments_plot <- renderPlotly(
    plot_deployments(
      req(spi_meta$deployments),
      study_area_name = req(spi_meta$sample_station_info$study_area_name[1]),
      interactive = TRUE
    )
  )

  output$deployments_table <- render_gt({
    req(spi_meta$deployments) %>%
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
        general_sampling_comments ~ px(400),
        site_description_comments ~ px(400),
        habitat_feature ~ px(150)
      ) %>%
      opt_interactive(
        use_resizers = TRUE,
        use_compact_mode = TRUE
      ) %>%
      opt_row_striping()
  })


# Image Data QA -----------------------------------------------------------

  img_data_qa <- eventReactive(input$btn_qa_image_data, {
    qa_image_data(
      req(image_data()),
      exclude_human_use = req(input$rb_exclude_human) == "Yes",
      check_snow = req(input$rb_check_snow) == "Yes",
      tl_time = format(req(input$tl_time), "%T")
    )
  })

  output$img_qa_summary <- renderUI({
    qa_data <- req(img_data_qa())
    card(
      h3("Images QA"),
      h5("Number of records with potential issues:"),
      p(nrow(qa_data)),
      h5("Potential Issues:"),
      p(paste0(grep("^QA_", names(qa_data), value = TRUE), collapse = ","))
    )
  })

  output$image_qa_table <- render_gt({
    qa_data <- req(img_data_qa())
    qa_data %>%
      select(
        -any_of(
          c("wlrs_project_name", "study_area_name")
        )
      ) %>%
      gt() %>%
      data_color(columns = starts_with("QA_"), method = "factor", palette = c("#1E88E5", "#D81B60")) %>%
      opt_interactive(
        use_resizers = TRUE,
        use_compact_mode = TRUE
      ) %>%
      opt_row_striping()
  }) %>%
    bindCache(img_data_qa())

# Deployments vs Images QA ------------------------------------------------

  output$deployments_images_plot <- renderPlotly({
    plot_deployment_detections(
      req(spi_meta$deployments),
      req(image_data()),
      interactive = TRUE
    )
  })

  output$qa_deps_imgs <- renderUI({
    out <- suppressMessages(
      qa_deployment_images(req(spi_meta$deployments), req(image_data()))
    )

    card(
      h3("Deployments vs Images QA"),
      h5("Image labels not in deployments:"),
      p(paste0(out$img_dep_labels_not_in_deployments, collapse = ", ")),
      h5("Deployment labels not in images:"),
      p(paste0(out$deployment_dep_labels_not_in_images, collapse = ", ")),
      h5("Image records with different timelapse time than indicated in deployments:"),
      p(paste0(out$mismatched_timelapse_image_times, collapse = ", "))
    )
  })


# Sample sessions ---------------------------------------------------------

  sessions <- reactiveVal()

  observe({
    sessions(make_sample_sessions(req(image_data())))
  })

  output$ss_date_range <- renderUI({
    x <- req(xions())
    card(dateRangeInput(
      "ss_date_range",
      "Session Start and End dates",
      start = min(x$sample_start_date),
      end = max(x$sample_end_date)
    ))
  })

  observeEvent(
    input$ss_date_range,
    {
      sessions(make_sample_sessions(
        req(image_data()),
        sample_start_date = input$ss_date_range[1],
        sample_end_date = input$ss_date_range[2]
      ))
    }
  )

  output$sessions_table <- render_gt({
    req(sessions()) %>%
      gt() %>%
      opt_interactive(
        use_resizers = TRUE,
        use_compact_mode = TRUE
      )
  })


# Analysis Data -----------------------------------------------------------


# Sample RAI --------------------------------------------------------------

  output$sample_rai_opts <- renderUI({
    x <- req(image_data())
    layout_columns(
      dateRangeInput(
        "s_rai_date_range",
        "Session Start and End dates",
        start = min(as.Date(x$date_time), na.rm = TRUE),
        end = max(as.Date(x$date_time), na.rm = TRUE)
      ),
      selectInput(
        "s_rai_deployment_labels",
        "Deployment Label(s)",
        choices = unique(x$deployment_label),
        multiple = TRUE
      ),
      selectInput(
        "s_rai_species",
        "Species",
        choices = unique(x$species),
        multiple = TRUE
      ),
      radioButtons(
        "s_rai_by_deployment",
        "By Deployment?",
        choices = c("Yes", "No"),
        selected = "Yes",
        inline = TRUE
      ),
      radioButtons(
        "s_rai_by_species",
        "By Species?",
        choices = c("Yes", "No"),
        selected = "Yes",
        inline = TRUE
      )
    )
  })

  sample_rai_df <- reactive(
    sample_rai(
      req(image_data()),
      deployment_label = x_or_null(input$s_rai_deployment_labels),
      species = x_or_null(input$s_rai_species),
      by_deployment = yesno_as_logical(input$s_rai_by_deployment, TRUE),
      by_species = yesno_as_logical(input$s_rai_by_species, TRUE),
      sample_start_date = x_or_null(input$s_rai_date_range[1]),
      sample_end_date = x_or_null(input$s_rai_date_range[2])
    )
  )

  output$sample_rai_table <- render_gt({
    req(sample_rai_df()) %>%
      gt() %>%
      opt_interactive(
        use_resizers = TRUE
      ) %>%
      opt_row_striping()
  })


# RAI by Time -------------------------------------------------------------

  output$rai_by_time_opts <- renderUI({
    x <- isolate(req(image_data()))
    layout_column_wrap(
      dateRangeInput(
        "rai_time_date_range",
        "Session Start and End dates",
        start = min(as.Date(x$date_time), na.rm = TRUE),
        end = max(as.Date(x$date_time), na.rm = TRUE)
      ),
      selectInput(
        "rai_time_deployment_labels",
        "Deployment Label(s)",
        choices = unique(x$deployment_label),
        multiple = TRUE
      ),
      selectInput(
        "rai_time_species",
        "Species",
        choices = unique(x$species),
        multiple = TRUE
      ),
      radioButtons(
        "rai_time_by_deployment",
        "By Deployment?",
        choices = c("Yes", "No"),
        selected = "No",
        inline = TRUE
      ),
      radioButtons(
        "rai_time_by_species",
        "By Species?",
        choices = c("Yes", "No"),
        selected = "Yes",
        inline = TRUE
      )
    )
  })

  rai_by_time_df <- reactive(
    rai_by_time(
      req(image_data()),
      by_species = yesno_as_logical(input$rai_time_by_species, TRUE),
      species = x_or_null(input$rai_time_species),
      by_deployment = yesno_as_logical(input$rai_time_by_deployment, FALSE),
      deployment_label = x_or_null(input$rai_time_deployment_labels),
      sample_start_date = x_or_null(input$rai_time_date_range[1]),
      sample_end_date = x_or_null(input$rai_time_date_range[2])
    )
  )

  output$rai_by_time_table <- render_gt({
    req(rai_by_time_df()) %>%
      gt() %>%
      opt_interactive(
        use_resizers = TRUE
      ) %>%
      opt_row_striping()
  })

# SPI download ------------------------------------------------------------

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
