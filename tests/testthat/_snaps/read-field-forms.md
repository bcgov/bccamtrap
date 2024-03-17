# read_sample_station_csv is like read_sample_station

    Code
      common_names
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "sample_station_label"        "station_status"             
       [5] "set_date"                    "elevation_m"                
       [7] "slope_percent"               "aspect_degrees"             
       [9] "crown_closure_percent"       "camera_bearing_degrees"     
      [11] "camera_height_cm"            "distance_to_feature_m"      
      [13] "visible_range_m"             "habitat_feature"            
      [15] "lock"                        "code"                       
      [17] "access_notes"                "site_description_comments"  
      [19] "longitude_sample_station_dd" "latitude_sample_station_dd" 
      [21] "geometry"                   

---

    Code
      setdiff(names(ret), names(ssi1))
    Output
      [1] "linked_project"

---

    Code
      setdiff(names(ssi1), names(ret))
    Output
      [1] "study_area_photos"       "utm_zone_sample_station"
      [3] "easting_sample_station"  "northing_sample_station"
      [5] "number_of_cameras"       "general_location"       
      [7] "sample_station_comments" "sample_station_photos"  
      [9] "site_description_date"  

# read_deployments_csv is like read_deployments

    Code
      common_names
    Output
       [1] "wlrs_project_name"           "sample_station_label"       
       [3] "deployment_label"            "longitude_sample_station_dd"
       [5] "latitude_sample_station_dd"  "deployment_start"           
       [7] "camera_label"                "camera_make"                
       [9] "camera_model"                "time_zone"                  
      [11] "timelapse_time"              "video_length_per_trigger_s" 
      [13] "photos_per_trigger"          "trigger_timing_s"           
      [15] "trigger_sensitivity"         "quiet_period_s"             
      [17] "camera_visit_comments"       "deployment_end"             
      [19] "deployment_duration_days"    "deployment_duration_valid"  
      [21] "geometry"                   

---

    Code
      setdiff(names(ret), names(ssi1))
    Output
       [1] "surveyor_set"                    "visit_type_set"                 
       [3] "battery_level_set"               "battery_changed_set"            
       [5] "snow_stake_set"                  "time_lapse_end"                 
       [7] "time_lapse_interval"             "form_status"                    
       [9] "visit_type_check"                "battery_level_check"            
      [11] "camera_status_description_check" "camera_status_check"            
      [13] "surveyor_check"                  "sd_removed_check"               

---

    Code
      setdiff(names(ssi1), names(ret))
    Output
       [1] "study_area_name"                "surveyors"                     
       [3] "date_time_checked"              "total_visit_or_deployment_time"
       [5] "unit_of_total_time_code"        "visit_type"                    
       [7] "camera_status_on_arrival"       "battery_level"                 
       [9] "batteries_changed"              "number_of_photos"              
      [11] "timelapse_photos"               "bait_lure_type"                
      [13] "camera_visit_photos"            "sd_downloaded_y_n"             
      [15] "images_classified_y_n"          "timelapse_template_used"       
      [17] "data_qc_complete"               "general_sampling_comments"     
      [19] "study_area_photos"              "utm_zone_sample_station"       
      [21] "easting_sample_station"         "northing_sample_station"       
      [23] "station_status"                 "number_of_cameras"             
      [25] "set_date"                       "general_location"              
      [27] "elevation_m"                    "slope_percent"                 
      [29] "aspect_degrees"                 "crown_closure_percent"         
      [31] "camera_bearing_degrees"         "camera_height_cm"              
      [33] "distance_to_feature_m"          "visible_range_m"               
      [35] "habitat_feature"                "lock"                          
      [37] "code"                           "sample_station_comments"       
      [39] "sample_station_photos"          "site_description_comments"     
      [41] "site_description_date"          "access_notes"                  

