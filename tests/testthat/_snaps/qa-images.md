# qa_image_data works

    Code
      head(dplyr::select(as.data.frame(qa_image_data(imgs_1)), starts_with("QA")))
    Output
        QA_BLANK_study_area_name QA_BLANK_sample_station_label
      1                    FALSE                         FALSE
      2                    FALSE                         FALSE
      3                    FALSE                         FALSE
      4                    FALSE                         FALSE
      5                    FALSE                         FALSE
      6                    FALSE                         FALSE
        QA_BLANK_deployment_label QA_BLANK_date_time QA_BLANK_surveyor
      1                     FALSE              FALSE             FALSE
      2                     FALSE              FALSE             FALSE
      3                     FALSE              FALSE             FALSE
      4                     FALSE              FALSE             FALSE
      5                     FALSE              FALSE             FALSE
      6                     FALSE              FALSE             FALSE
        QA_BLANK_trigger_mode QA_BLANK_temperature QA_BLANK_episode
      1                 FALSE                FALSE             TRUE
      2                 FALSE                FALSE             TRUE
      3                 FALSE                FALSE             TRUE
      4                 FALSE                FALSE             TRUE
      5                 FALSE                FALSE             TRUE
      6                 FALSE                FALSE             TRUE
        QA_species_UNMATCHED_total_count_episode
      1                                    FALSE
      2                                    FALSE
      3                                    FALSE
      4                                    FALSE
      5                                    FALSE
      6                                    FALSE
        QA_total_count_episode_UNMATCHED_species QA_sum_counts QA_dup_episode
      1                                    FALSE         FALSE          FALSE
      2                                    FALSE         FALSE          FALSE
      3                                    FALSE         FALSE          FALSE
      4                                    FALSE         FALSE          FALSE
      5                                    FALSE         FALSE          FALSE
      6                                    FALSE         FALSE          FALSE
        QA_timelapse_lag QA_snow_blank QA_snow_outlier
      1            FALSE         FALSE           FALSE
      2            FALSE         FALSE           FALSE
      3            FALSE         FALSE           FALSE
      4            FALSE         FALSE           FALSE
      5            FALSE         FALSE           FALSE
      6            FALSE         FALSE           FALSE

---

    Code
      head(dplyr::select(as.data.frame(qa_image_data(imgs_2)), starts_with("QA")))
    Output
        QA_BLANK_study_area_name QA_BLANK_sample_station_label
      1                    FALSE                         FALSE
      2                    FALSE                         FALSE
      3                    FALSE                         FALSE
      4                    FALSE                         FALSE
      5                    FALSE                         FALSE
      6                    FALSE                         FALSE
        QA_BLANK_deployment_label QA_BLANK_date_time QA_BLANK_surveyor
      1                     FALSE              FALSE             FALSE
      2                     FALSE              FALSE             FALSE
      3                     FALSE              FALSE             FALSE
      4                     FALSE              FALSE             FALSE
      5                     FALSE              FALSE             FALSE
      6                     FALSE              FALSE             FALSE
        QA_BLANK_trigger_mode QA_BLANK_temperature QA_BLANK_episode
      1                 FALSE                FALSE            FALSE
      2                 FALSE                FALSE            FALSE
      3                 FALSE                FALSE            FALSE
      4                 FALSE                FALSE            FALSE
      5                 FALSE                FALSE            FALSE
      6                 FALSE                FALSE            FALSE
        QA_species_UNMATCHED_total_count_episode
      1                                     TRUE
      2                                    FALSE
      3                                    FALSE
      4                                    FALSE
      5                                    FALSE
      6                                    FALSE
        QA_total_count_episode_UNMATCHED_species QA_sum_counts QA_dup_episode
      1                                    FALSE          TRUE          FALSE
      2                                    FALSE         FALSE           TRUE
      3                                    FALSE         FALSE           TRUE
      4                                    FALSE          TRUE          FALSE
      5                                    FALSE         FALSE           TRUE
      6                                    FALSE         FALSE          FALSE
        QA_timelapse_lag QA_snow_blank QA_snow_outlier
      1            FALSE         FALSE           FALSE
      2            FALSE         FALSE           FALSE
      3            FALSE         FALSE           FALSE
      4            FALSE         FALSE           FALSE
      5            FALSE         FALSE           FALSE
      6            FALSE          TRUE           FALSE

