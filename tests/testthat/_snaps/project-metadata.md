# read_project_info works

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

# read_project_info works as sf

    Code
      names(ssi_sf1)
    Output
       [1] "study_area_name"           "study_area_photos"        
       [3] "sample_station_label"      "utm_zone_sample_station"  
       [5] "easting_sample_station"    "northing_sample_station"  
       [7] "station_status"            "number_of_cameras"        
       [9] "set_date"                  "general_location"         
      [11] "elevation_m"               "slope_percent"            
      [13] "aspect_degrees"            "crown_closure_percent"    
      [15] "camera_bearing_degrees"    "camera_height_cm"         
      [17] "distance_to_feature_m"     "visible_range_m"          
      [19] "habitat_feature"           "lock"                     
      [21] "code"                      "sample_station_comments"  
      [23] "sample_station_photos"     "site_description_comments"
      [25] "site_description_date"     "access_notes"             
      [27] "geometry"                 

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
      [27] "geometry"                   

