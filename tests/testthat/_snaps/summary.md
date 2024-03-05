# summary.sample_stations works

    Code
      summary(ss1)
    Output
      + Hidden -------------+
      |                     |
      |   Sample Stations   |
      |                     |
      +---------------------+
    Message
      i 12 sample stations in 13 locations.
    Output
      
    Message
      i Summary of station distances (m):
    Output
          Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
         50.26  1600.31  2694.84 12805.59  3896.18 71655.56 
    Message
      ! Run `check_stations_spatial()` to validate the spatial information.
    Output
      
    Message
      i Station status summary:
    Output
      Camera Active Camera Stolen 
                 12             1 
      
    Message
      i Set dates: Between 2022-11-28 and 2023-11-28
    Output
      
    Message
      ! Run `map_stations(object)` to view stations on a map.

---

    Code
      summary(ss2)
    Output
      + Hidden -------------+
      |                     |
      |   Sample Stations   |
      |                     |
      +---------------------+
    Message
      i 18 sample stations in 21 locations.
    Output
      
    Message
      i Summary of station distances (m):
    Output
           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
          5.098  3456.952  7303.056  8409.253 12798.212 22787.846 
    Message
      ! Run `check_stations_spatial()` to validate the spatial information.
    Output
      
    Message
      i Station status summary:
    Output
      Camera Active  Camera Moved 
                 18             3 
      
    Message
      i Set dates: Between 2022-11-07 and 2023-11-16
    Output
      
    Message
      ! Run `map_stations(object)` to view stations on a map.

---

    Code
      summary(ss1)
    Output
      + Hidden -------------+
      |                     |
      |   Sample Stations   |
      |                     |
      +---------------------+
    Message
      i 12 sample stations in 13 locations.
    Output
      
    Message
      i Summary of station distances (m):
    Output
          Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
         50.26  1600.31  2694.84 12805.59  3896.18 71655.56 
    Message
      x Detected 1 potential spatial outlier.
    Output
      
    Message
      i Station status summary:
    Output
      Camera Active Camera Stolen 
                 12             1 
      
    Message
      i Set dates: Between 2022-11-28 and 2023-11-28
    Output
      
    Message
      ! Run `map_stations(object)` to view stations on a map.

---

    Code
      summary(ss2)
    Output
      + Hidden -------------+
      |                     |
      |   Sample Stations   |
      |                     |
      +---------------------+
    Message
      i 18 sample stations in 21 locations.
    Output
      
    Message
      i Summary of station distances (m):
    Output
           Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
          5.098  3456.952  7303.056  8409.253 12798.212 22787.846 
    Message
      x Detected 0 potential spatial outliers.
    Output
      
    Message
      i Station status summary:
    Output
      Camera Active  Camera Moved 
                 18             3 
      
    Message
      i Set dates: Between 2022-11-07 and 2023-11-16
    Output
      
    Message
      ! Run `map_stations(object)` to view stations on a map.

# summary.deployments works

    Code
      summary(sessions1)
    Output
      + Hidden ---------+
      |                 |
      |   Deployments   |
      |                 |
      +-----------------+
    Message
      i 12 sample stations in 24 deploymentss.
      i Deployment lengths range between 151 and 195 days.
      x There is 1 invalid deployment.
      i Camera status on arrival summary:
    Output
      Active Stolen 
          23      1 
    Message
      i There are 30041 images. Photos per deployment range betwen 216 and 14444.

---

    Code
      summary(sessions2)
    Output
      + Hidden ---------+
      |                 |
      |   Deployments   |
      |                 |
      +-----------------+
    Message
      i 15 sample stations in 28 deploymentss.
      i Deployment lengths range between 113 and 245 days.
      i Camera status on arrival summary:
    Output
      Active 
          28 
    Message
      i There are 19201 images. Photos per deployment range betwen 189 and 3554.

# summary.image_data works

    Code
      summary(id1)
    Output
      + Hidden -----------+
      |                   |
      |   Image summary   |
      |                   |
      +-------------------+
    Message
      i 5111 images in 11 deployments at 11 sample stations.
      i Image counts by trigger mode:
    Output
      Motion Detection       Time Lapse 
                  3371             1740 
    Message
      i 71 images with lens obscured.
      i 0 images starred.
      ! 0 images flagged for review.
      i Dates are between 2022-11-28 and 2023-05-17.
      i Temperatures are between -14 and 27 C.
      i Snow depths are between 0 and 15 cm.
      i Species counts:
    Output
         Avian (comments)              Beaver          Black Bear Domestic (comments) 
                        1                   1                   2                   1 
                Mule Deer       Roosevelt Elk             Unknown                <NA> 
                       69                  96                   5                4936 
      
    Message
      ! Run `check_deployment_images()` to crosscheck images with deployments.

---

    Code
      summary(id2)
    Output
      + Hidden -----------+
      |                   |
      |   Image summary   |
      |                   |
      +-------------------+
    Message
      i 11833 images in 17 deployments at 15 sample stations.
      i Image counts by trigger mode:
    Output
      Motion Detection       Time Lapse 
                  8657             3176 
    Message
      i 117 images with lens obscured.
      i 4 images starred.
      ! 4 images flagged for review.
      i Dates are between 2022-11-07 and 2023-07-10.
      i Temperatures are between -10 and 37 C.
      i Snow depths are between 0 and 135 cm.
      i Species counts:
    Output
      Avian (comments)       Black Bear           Cougar        Mule Deer 
                     6              130               12              155 
      Other (comments)   Pacific Marten     Red Squirrel    Roosevelt Elk 
                     1                2                1               88 
                  <NA> 
                 11438 
      
    Message
      ! Run `check_deployment_images()` to crosscheck images with deployments.

