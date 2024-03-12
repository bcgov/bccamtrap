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
        QA_BLANK_trigger_mode QA_BLANK_temperature
      1                 FALSE                FALSE
      2                 FALSE                FALSE
      3                 FALSE                FALSE
      4                 FALSE                FALSE
      5                 FALSE                FALSE
      6                 FALSE                FALSE
        QA_total_count_episode_UNMATCHED_species QA_timelapse_lag QA_snow_blank
      1                                    FALSE            FALSE         FALSE
      2                                    FALSE            FALSE         FALSE
      3                                    FALSE            FALSE         FALSE
      4                                    FALSE            FALSE         FALSE
      5                                    FALSE            FALSE         FALSE
      6                                    FALSE            FALSE         FALSE
        QA_snow_outlier
      1           FALSE
      2           FALSE
      3           FALSE
      4           FALSE
      5           FALSE
      6           FALSE

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
        QA_BLANK_trigger_mode QA_BLANK_temperature QA_BLANK_episode QA_timelapse_lag
      1                 FALSE                FALSE            FALSE            FALSE
      2                 FALSE                FALSE            FALSE            FALSE
      3                 FALSE                FALSE            FALSE            FALSE
      4                 FALSE                FALSE            FALSE            FALSE
      5                 FALSE                FALSE            FALSE            FALSE
      6                 FALSE                FALSE            FALSE            FALSE
        QA_snow_outlier
      1           FALSE
      2           FALSE
      3           FALSE
      4           FALSE
      5           FALSE
      6           FALSE

# find_blanks

    Code
      find_blanks(d)
    Output
        study_area_name sample_station_label deployment_label           date_time
      1               a                    a                a                <NA>
      2               b                    b                b 2024-03-11 05:16:42
      3                                                       2024-03-11 05:16:42
      4                                                       2024-03-11 05:16:42
      5            <NA>                 <NA>             <NA> 2024-03-11 05:16:42
        surveyor trigger_mode temperature episode QA_BLANK_study_area_name
      1                     A         NaN       a                    FALSE
      2     <NA>            B          NA       b                    FALSE
      3        a            C           1       c                     TRUE
      4        b            D           2       d                     TRUE
      5                     E           3       e                     TRUE
        QA_BLANK_sample_station_label QA_BLANK_deployment_label QA_BLANK_date_time
      1                         FALSE                     FALSE               TRUE
      2                         FALSE                     FALSE              FALSE
      3                          TRUE                      TRUE              FALSE
      4                          TRUE                      TRUE              FALSE
      5                          TRUE                      TRUE              FALSE
        QA_BLANK_surveyor QA_BLANK_trigger_mode QA_BLANK_temperature QA_BLANK_episode
      1              TRUE                 FALSE                 TRUE            FALSE
      2              TRUE                 FALSE                 TRUE            FALSE
      3             FALSE                 FALSE                FALSE            FALSE
      4             FALSE                 FALSE                FALSE            FALSE
      5              TRUE                 FALSE                FALSE            FALSE

# find_unmatched

    Code
      find_unmatched(d, "a", "b", exclude_human_use = FALSE)
    Output
         a  b human_use_type QA_a_UNMATCHED_b
      1  1 NA              a             TRUE
      2 NA  3              b            FALSE
      3  2  4           <NA>            FALSE

---

    Code
      find_unmatched(d, "b", "a", exclude_human_use = FALSE)
    Output
         a  b human_use_type QA_b_UNMATCHED_a
      1  1 NA              a            FALSE
      2 NA  3              b             TRUE
      3  2  4           <NA>            FALSE

---

    Code
      find_unmatched(d, "a", "b", exclude_human_use = TRUE)
    Output
         a  b human_use_type QA_a_UNMATCHED_b
      1  1 NA              a            FALSE
      2 NA  3              b            FALSE
      3  2  4           <NA>            FALSE

---

    Code
      find_unmatched(d, "b", "a", exclude_human_use = TRUE)
    Output
         a  b human_use_type QA_b_UNMATCHED_a
      1  1 NA              a            FALSE
      2 NA  3              b            FALSE
      3  2  4           <NA>            FALSE

# validate_counts

    Code
      validate_counts(d, cols = c("adult_male", "adult_female"), exclude_human_use = FALSE)
    Output
        total_count_episode adult_male adult_female human_use_type QA_sum_counts
      1                   5          2            3           <NA>         FALSE
      2                   3         NA            3           <NA>         FALSE
      3                  NA          0            1              a          TRUE
      4                   0          1            0              b          TRUE
      5                   1         NA           NA              c          TRUE

---

    Code
      validate_counts(d, cols = c("adult_male", "adult_female"), exclude_human_use = TRUE)
    Output
        total_count_episode adult_male adult_female human_use_type QA_sum_counts
      1                   5          2            3           <NA>         FALSE
      2                   3         NA            3           <NA>         FALSE
      3                  NA          0            1              a         FALSE
      4                   0          1            0              b         FALSE
      5                   1         NA           NA              c         FALSE

# find_dup_episodes

    Code
      find_dup_episodes(d)
    Output
        episode_num episode deployment_label  date_time file species QA_dup_episode
      1           3  3:1|17                a 2024-03-09    x       p           TRUE
      2           4  4:1|17                b 2024-03-10    y       q          FALSE
      3           3  3:2|17                a 2024-03-11    z       p           TRUE
      4           4  4:1|17                c 2024-03-12   zz       s          FALSE

