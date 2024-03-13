# read_sample_station_csv is like read_sample_station

    Code
      common_names
    Output
       [1] "study_area_name"             "sample_station_label"       
       [3] "station_status"              "set_date"                   
       [5] "elevation_m"                 "slope_percent"              
       [7] "aspect_degrees"              "crown_closure_percent"      
       [9] "camera_bearing_degrees"      "camera_height_cm"           
      [11] "distance_to_feature_m"       "visible_range_m"            
      [13] "habitat_feature"             "lock"                       
      [15] "code"                        "access_notes"               
      [17] "site_description_comments"   "longitude_sample_station_dd"
      [19] "latitude_sample_station_dd"  "geometry"                   

---

    Code
      setdiff(names(ret), names(ssi1))
    Output
      [1] "project_id"     "linked_project"

---

    Code
      setdiff(names(ssi1), names(ret))
    Output
      [1] "study_area_photos"       "utm_zone_sample_station"
      [3] "easting_sample_station"  "northing_sample_station"
      [5] "number_of_cameras"       "general_location"       
      [7] "sample_station_comments" "sample_station_photos"  
      [9] "site_description_date"  

