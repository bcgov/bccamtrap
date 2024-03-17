# read_sample_station_info works

    Code
      names(ssi1)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "study_area_photos"           "sample_station_label"       
       [5] "utm_zone_sample_station"     "easting_sample_station"     
       [7] "northing_sample_station"     "latitude_sample_station_dd" 
       [9] "longitude_sample_station_dd" "station_status"             
      [11] "number_of_cameras"           "set_date"                   
      [13] "general_location"            "elevation_m"                
      [15] "slope_percent"               "aspect_degrees"             
      [17] "crown_closure_percent"       "camera_bearing_degrees"     
      [19] "camera_height_cm"            "distance_to_feature_m"      
      [21] "visible_range_m"             "habitat_feature"            
      [23] "lock"                        "code"                       
      [25] "sample_station_comments"     "sample_station_photos"      
      [27] "site_description_comments"   "site_description_date"      
      [29] "access_notes"               

---

    Code
      names(ssi2)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "study_area_photos"           "sample_station_label"       
       [5] "utm_zone_sample_station"     "easting_sample_station"     
       [7] "northing_sample_station"     "latitude_sample_station_dd" 
       [9] "longitude_sample_station_dd" "station_status"             
      [11] "number_of_cameras"           "set_date"                   
      [13] "general_location"            "elevation_m"                
      [15] "slope_percent"               "aspect_degrees"             
      [17] "crown_closure_percent"       "camera_bearing_degrees"     
      [19] "camera_height_cm"            "distance_to_feature_m"      
      [21] "visible_range_m"             "habitat_feature"            
      [23] "lock"                        "code"                       
      [25] "sample_station_comments"     "sample_station_photos"      
      [27] "site_description_comments"   "site_description_date"      
      [29] "access_notes"               

# read_sample_station_info works as sf

    Code
      names(ssi_sf1)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "study_area_photos"           "sample_station_label"       
       [5] "utm_zone_sample_station"     "easting_sample_station"     
       [7] "northing_sample_station"     "latitude_sample_station_dd" 
       [9] "longitude_sample_station_dd" "station_status"             
      [11] "number_of_cameras"           "set_date"                   
      [13] "general_location"            "elevation_m"                
      [15] "slope_percent"               "aspect_degrees"             
      [17] "crown_closure_percent"       "camera_bearing_degrees"     
      [19] "camera_height_cm"            "distance_to_feature_m"      
      [21] "visible_range_m"             "habitat_feature"            
      [23] "lock"                        "code"                       
      [25] "sample_station_comments"     "sample_station_photos"      
      [27] "site_description_comments"   "site_description_date"      
      [29] "access_notes"                "geometry"                   

---

    Code
      names(ssi_sf2)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "study_area_photos"           "sample_station_label"       
       [5] "utm_zone_sample_station"     "latitude_sample_station_dd" 
       [7] "longitude_sample_station_dd" "station_status"             
       [9] "number_of_cameras"           "set_date"                   
      [11] "general_location"            "elevation_m"                
      [13] "slope_percent"               "aspect_degrees"             
      [15] "crown_closure_percent"       "camera_bearing_degrees"     
      [17] "camera_height_cm"            "distance_to_feature_m"      
      [19] "visible_range_m"             "habitat_feature"            
      [21] "lock"                        "code"                       
      [23] "sample_station_comments"     "sample_station_photos"      
      [25] "site_description_comments"   "site_description_date"      
      [27] "access_notes"                "easting_sample_station"     
      [29] "northing_sample_station"     "geometry"                   

# read_camera_info works

    Code
      names(ci1)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "parent_sample_station_label" "camera_label"               
       [5] "utm_zone_camera"             "easting_camera"             
       [7] "northing_camera"             "longitude_camera_dd"        
       [9] "latitude_camera_dd"          "make_of_camera_code"        
      [11] "model_of_camera"             "camera_comments"            
      [13] "site_description_comments"   "site_description_date"      

---

    Code
      names(ci2)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "parent_sample_station_label" "camera_label"               
       [5] "utm_zone_camera"             "easting_camera"             
       [7] "northing_camera"             "longitude_camera_dd"        
       [9] "latitude_camera_dd"          "make_of_camera_code"        
      [11] "model_of_camera"             "camera_comments"            
      [13] "site_description_comments"   "site_description_date"      

# read_camera_info works as sf

    Code
      names(ci_sf1)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "parent_sample_station_label" "camera_label"               
       [5] "utm_zone_camera"             "easting_camera"             
       [7] "northing_camera"             "longitude_camera_dd"        
       [9] "latitude_camera_dd"          "make_of_camera_code"        
      [11] "model_of_camera"             "camera_comments"            
      [13] "site_description_comments"   "site_description_date"      
      [15] "geometry"                   

---

    Code
      names(ci_sf2)
    Output
       [1] "wlrs_project_name"           "study_area_name"            
       [3] "parent_sample_station_label" "camera_label"               
       [5] "utm_zone_camera"             "longitude_camera_dd"        
       [7] "latitude_camera_dd"          "make_of_camera_code"        
       [9] "model_of_camera"             "camera_comments"            
      [11] "site_description_comments"   "site_description_date"      
      [13] "easting_camera"              "northing_camera"            
      [15] "geometry"                   

# read_cam_setup_checks works

    Code
      names(csc1)
    Output
       [1] "wlrs_project_name"              "study_area_name"               
       [3] "sample_station_label"           "deployment_label"              
       [5] "camera_label"                   "surveyors"                     
       [7] "date_time_checked"              "sampling_start"                
       [9] "sampling_end"                   "total_visit_or_deployment_time"
      [11] "unit_of_total_time_code"        "visit_type"                    
      [13] "camera_status_on_arrival"       "battery_level"                 
      [15] "batteries_changed"              "number_of_photos"              
      [17] "quiet_period_s"                 "trigger_sensitivity"           
      [19] "trigger_timing_s"               "photos_per_trigger"            
      [21] "video_length_per_trigger_s"     "timelapse_photos"              
      [23] "timelapse_time"                 "time_zone"                     
      [25] "bait_lure_type"                 "camera_visit_comments"         
      [27] "camera_visit_photos"            "sd_downloaded_y_n"             
      [29] "images_classified_y_n"          "timelapse_template_used"       
      [31] "data_qc_complete"               "general_sampling_comments"     

---

    Code
      names(csc2)
    Output
       [1] "wlrs_project_name"              "study_area_name"               
       [3] "sample_station_label"           "deployment_label"              
       [5] "camera_label"                   "surveyors"                     
       [7] "date_time_checked"              "sampling_start"                
       [9] "sampling_end"                   "total_visit_or_deployment_time"
      [11] "unit_of_total_time_code"        "visit_type"                    
      [13] "camera_status_on_arrival"       "battery_level"                 
      [15] "batteries_changed"              "number_of_photos"              
      [17] "quiet_period_s"                 "trigger_sensitivity"           
      [19] "trigger_timing_s"               "photos_per_trigger"            
      [21] "video_length_per_trigger_s"     "timelapse_photos"              
      [23] "timelapse_time"                 "time_zone"                     
      [25] "bait_lure_type"                 "camera_visit_comments"         
      [27] "camera_visit_photos"            "sd_downloaded_y_n"             
      [29] "images_classified_y_n"          "timelapse_template_used"       
      [31] "general_sampling_comments"     

