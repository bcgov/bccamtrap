# read_sample_station_info works

    Code
      names(ssi1)
    Output
       [1] "study_area_name"             "study_area_photos"          
       [3] "sample_station_label"        "utm_zone_sample_station"    
       [5] "easting_sample_station"      "northing_sample_station"    
       [7] "latitude_sample_station_dd"  "longitude_sample_station_dd"
       [9] "station_status"              "number_of_cameras"          
      [11] "set_date"                    "general_location"           
      [13] "elevation_m"                 "slope_percent"              
      [15] "aspect_degrees"              "crown_closure_percent"      
      [17] "camera_bearing_degrees"      "camera_height_cm"           
      [19] "distance_to_feature_m"       "visible_range_m"            
      [21] "habitat_feature"             "lock"                       
      [23] "code"                        "sample_station_comments"    
      [25] "sample_station_photos"       "site_description_comments"  
      [27] "site_description_date"       "access_notes"               

---

    Code
      names(ssi2)
    Output
       [1] "study_area_name"             "study_area_photos"          
       [3] "sample_station_label"        "utm_zone_sample_station"    
       [5] "easting_sample_station"      "northing_sample_station"    
       [7] "latitude_sample_station_dd"  "longitude_sample_station_dd"
       [9] "station_status"              "number_of_cameras"          
      [11] "set_date"                    "general_location"           
      [13] "elevation_m"                 "slope_percent"              
      [15] "aspect_degrees"              "crown_closure_percent"      
      [17] "camera_bearing_degrees"      "camera_height_cm"           
      [19] "distance_to_feature_m"       "visible_range_m"            
      [21] "habitat_feature"             "lock"                       
      [23] "code"                        "sample_station_comments"    
      [25] "sample_station_photos"       "site_description_comments"  
      [27] "site_description_date"       "access_notes"               

# read_sample_station_info works as sf

    Code
      names(ssi_sf1)
    Output
       [1] "study_area_name"             "study_area_photos"          
       [3] "sample_station_label"        "utm_zone_sample_station"    
       [5] "easting_sample_station"      "northing_sample_station"    
       [7] "latitude_sample_station_dd"  "longitude_sample_station_dd"
       [9] "station_status"              "number_of_cameras"          
      [11] "set_date"                    "general_location"           
      [13] "elevation_m"                 "slope_percent"              
      [15] "aspect_degrees"              "crown_closure_percent"      
      [17] "camera_bearing_degrees"      "camera_height_cm"           
      [19] "distance_to_feature_m"       "visible_range_m"            
      [21] "habitat_feature"             "lock"                       
      [23] "code"                        "sample_station_comments"    
      [25] "sample_station_photos"       "site_description_comments"  
      [27] "site_description_date"       "access_notes"               
      [29] "geometry"                   

---

    Code
      names(ssi_sf2)
    Output
       [1] "study_area_name"             "study_area_photos"          
       [3] "sample_station_label"        "utm_zone_sample_station"    
       [5] "latitude_sample_station_dd"  "longitude_sample_station_dd"
       [7] "station_status"              "number_of_cameras"          
       [9] "set_date"                    "general_location"           
      [11] "elevation_m"                 "slope_percent"              
      [13] "aspect_degrees"              "crown_closure_percent"      
      [15] "camera_bearing_degrees"      "camera_height_cm"           
      [17] "distance_to_feature_m"       "visible_range_m"            
      [19] "habitat_feature"             "lock"                       
      [21] "code"                        "sample_station_comments"    
      [23] "sample_station_photos"       "site_description_comments"  
      [25] "site_description_date"       "access_notes"               
      [27] "easting_sample_station"      "northing_sample_station"    
      [29] "geometry"                   

# read_camera_info works

    Code
      names(ci1)
    Output
       [1] "study_area_name"             "parent_sample_station_label"
       [3] "camera_label"                "utm_zone_camera"            
       [5] "easting_camera"              "northing_camera"            
       [7] "longitude_camera_dd"         "latitude_camera_dd"         
       [9] "make_of_camera_code"         "model_of_camera"            
      [11] "camera_comments"             "site_description_comments"  
      [13] "site_description_date"      

---

    Code
      names(ci2)
    Output
       [1] "study_area_name"             "parent_sample_station_label"
       [3] "camera_label"                "utm_zone_camera"            
       [5] "easting_camera"              "northing_camera"            
       [7] "longitude_camera_dd"         "latitude_camera_dd"         
       [9] "make_of_camera_code"         "model_of_camera"            
      [11] "camera_comments"             "site_description_comments"  
      [13] "site_description_date"      

# read_camera_info works as sf

    Code
      names(ci_sf1)
    Output
       [1] "study_area_name"             "parent_sample_station_label"
       [3] "camera_label"                "utm_zone_camera"            
       [5] "easting_camera"              "northing_camera"            
       [7] "longitude_camera_dd"         "latitude_camera_dd"         
       [9] "make_of_camera_code"         "model_of_camera"            
      [11] "camera_comments"             "site_description_comments"  
      [13] "site_description_date"       "geometry"                   

---

    Code
      names(ci_sf2)
    Output
       [1] "study_area_name"             "parent_sample_station_label"
       [3] "camera_label"                "utm_zone_camera"            
       [5] "longitude_camera_dd"         "latitude_camera_dd"         
       [7] "make_of_camera_code"         "model_of_camera"            
       [9] "camera_comments"             "site_description_comments"  
      [11] "site_description_date"       "easting_camera"             
      [13] "northing_camera"             "geometry"                   

# read_cam_setup_checks works

    Code
      names(csc1)
    Output
       [1] "study_area_name"                "sample_station_label"          
       [3] "deployment_label"               "camera_label"                  
       [5] "surveyors"                      "date_time_checked"             
       [7] "sampling_start"                 "sampling_end"                  
       [9] "total_visit_or_deployment_time" "unit_of_total_time_code"       
      [11] "visit_type"                     "camera_status_on_arrival"      
      [13] "battery_level"                  "batteries_changed"             
      [15] "number_of_photos"               "quiet_period_s"                
      [17] "trigger_sensitivity"            "trigger_timing_s"              
      [19] "photos_per_trigger"             "video_length_per_trigger_s"    
      [21] "timelapse_photos"               "timelapse_time"                
      [23] "time_zone"                      "bait_lure_type"                
      [25] "camera_visit_comments"          "camera_visit_photos"           
      [27] "sd_downloaded_y_n"              "images_classified_y_n"         
      [29] "timelapse_template_used"        "data_qc_complete"              
      [31] "general_sampling_comments"     

---

    Code
      names(csc2)
    Output
       [1] "study_area_name"                "sample_station_label"          
       [3] "deployment_label"               "camera_label"                  
       [5] "surveyors"                      "date_time_checked"             
       [7] "sampling_start"                 "sampling_end"                  
       [9] "total_visit_or_deployment_time" "unit_of_total_time_code"       
      [11] "visit_type"                     "camera_status_on_arrival"      
      [13] "battery_level"                  "batteries_changed"             
      [15] "number_of_photos"               "quiet_period_s"                
      [17] "trigger_sensitivity"            "trigger_timing_s"              
      [19] "photos_per_trigger"             "video_length_per_trigger_s"    
      [21] "timelapse_photos"               "timelapse_time"                
      [23] "time_zone"                      "bait_lure_type"                
      [25] "camera_visit_comments"          "camera_visit_photos"           
      [27] "sd_downloaded_y_n"              "images_classified_y_n"         
      [29] "timelapse_template_used"        "general_sampling_comments"     

