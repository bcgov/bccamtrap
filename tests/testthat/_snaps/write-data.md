# fill_spi_template() works

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
    Output
         Study Area Name Study Area Photos Sample Station Label
      X           Hidden                NA                   AX
      X           Hidden                NA                   BX
      X           Hidden                NA                   BX
      X           Hidden                NA                   CX
      X           Hidden                NA                   CX
      X           Hidden                NA                   CX
      X           Hidden                NA                   CX
      X           Hidden                NA                   CX
      XX          Hidden                NA                   DX
      XX          Hidden                NA                   DX
      XX          Hidden                NA                   DX
      XX          Hidden                NA                   DX
      XX          Hidden                NA                   CX
         UTM Zone Sample Station Easting Sample Station Northing Sample Station
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
         Longitude Sample Station (DD) Latitude Sample Station (DD) Number of Cameras
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      X                      -XXX.XXXX                     XX.XXXXX                NA
      XX                     -XXX.XXXX                     XX.XXXXX                NA
      XX                     -XXX.XXXX                     XX.XXXXX                NA
      XX                     -XXX.XXXX                     XX.XXXXX                NA
      XX                     -XXX.XXXX                     XX.XXXXX                NA
      XX                     -XXX.XXXX                     XX.XXXXX                NA
         Sample Station Comments Sample Station Photos Site Description Comments
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
         Site Description Date
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
    Output
         Study Area Name Camera Label Parent Sample Station Label UTM Zone Camera
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
         Easting Camera Northing Camera Longitude Camera (DD) Latitude Camera (DD)
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
         Make of Camera Code Model of Camera Camera Comments
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
         Site Description Comments Site Description Date
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
    Output
         Study Area Name Camera Label        Date Time Visit End Date End Time
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
         Total Visit or Deployment Time Unit of Total Time Code Quiet Period (s)
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
         Trigger Sensitivity Trigger Timing (s) Photos per Trigger
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
         Video Length per Trigger (s) Bait Lure Type Camera Visit Comments
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
         Camera Visit Photos Insert Predefined Camera Visit Column
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Dec-XXXX       XX:XX:XX
         Air Temperature (C) Sequence Definition (s) Species Code Count
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA     X
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA     X
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA    NA
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA    NA
         Life Stage Code Sex Code Adult Males Adult Females Adults - Unclassified Sex
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
         Juvenile Males Juvenile Females Juveniles - Unclassified Sex Yearling Males
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
         Yearling Females Yearlings - Unclassified Sex
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
         Males - Unclassified Life Stage Females - Unclassified Life Stage
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
         Unclassified Life Stage and Sex Activity Code Animal ID
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
         Human Transport Mode Code Human Use Type Code Survey Observation Photos
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
         Surveyor Comments Add your new column here
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      X        NA       NA                       NA
      XX       NA       NA                       NA
      XX       NA       NA                       NA
      XX       NA       NA                       NA

# write_to_spi_sheet() works

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
    Output
         Study Area Name Study Area Photos Sample Station Label
      X           Hidden                NA                 XX_X
      X           Hidden                NA                 XX_X
      X           Hidden                NA                   XX
      X           Hidden                NA                 XX_X
      X           Hidden                NA                 XX_X
      X           Hidden                NA                   XX
      X           Hidden                NA                   XX
      X           Hidden                NA                   XX
      XX          Hidden                NA                   XX
      XX          Hidden                NA                   XX
      XX          Hidden                NA                 XX_X
      XX          Hidden                NA                 XX_X
      XX          Hidden                NA                 XX_X
      XX          Hidden                NA                   XX
      XX          Hidden                NA                   XX
      XX          Hidden                NA                   XX
      XX          Hidden                NA                   XX
      XX          Hidden                NA                 XX_X
      XX          Hidden                NA           MOTI Cam_X
      XX          Hidden                NA           MOTI Cam_X
      XX          Hidden                NA           MOTI Cam_X
         UTM Zone Sample Station Easting Sample Station Northing Sample Station
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      X                       NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
      XX                      NA                     NA                      NA
         Longitude Sample Station (DD) Latitude Sample Station (DD) Number of Cameras
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      X                      -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
      XX                     -XXX.XXXX                     XX.XXXXX                 X
         Sample Station Comments Sample Station Photos Site Description Comments
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      X                       NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
      XX                      NA                    NA                        NA
         Site Description Date
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      X                     NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA
      XX                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
    Output
         Study Area Name Camera Label Parent Sample Station Label UTM Zone Camera
      X           Hidden        UBC X                          NA              NA
      X           Hidden        UBC X                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      X           Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden        UBC X                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden        UBC X                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden        UBC X                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
      XX          Hidden      EcoXXXX                          NA              NA
         Easting Camera Northing Camera Longitude Camera (DD) Latitude Camera (DD)
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      X              NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
      XX             NA              NA             -XXX.XXXX             XX.XXXXX
         Make of Camera Code Model of Camera Camera Comments
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      X                   NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
      XX                  NA              NA              NA
         Site Description Comments Site Description Date
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      X                         NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA
      XX                        NA                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
    Output
         Study Area Name Camera Label        Date Time Visit End Date End Time
      X           Hidden        UBC X XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden        UBC X XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X           Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jul-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jul-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jul-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden        UBC X XX-Nov-XXXX   NA    XX-Jun-XXXX       NA
      XX          Hidden      EcoXXXX XX-Nov-XXXX   NA    XX-Jul-XXXX       NA
      XX          Hidden        UBC X XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden        UBC X XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jul-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jul-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden        UBC X XX-Jun-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden        UBC X XX-Jun-XXXX   NA    XX-Oct-XXXX       NA
      XX          Hidden      EcoXXXX XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
      XX          Hidden        UBC X XX-Jun-XXXX   NA    XX-Nov-XXXX       NA
         Total Visit or Deployment Time Unit of Total Time Code Quiet Period (s)
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      X                              NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
      XX                             NA                      NA               NA
         Trigger Sensitivity Trigger Timing (s) Photos per Trigger
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      X                   NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
      XX                  NA                 NA                 NA
         Video Length per Trigger (s) Bait Lure Type Camera Visit Comments
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      X                            NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
      XX                           NA             NA                    NA
         Camera Visit Photos Insert Predefined Camera Visit Column
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      X                   NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA
      XX                  NA                                    NA

---

    Code
      write_to_spi_sheet(imgs, out_xls, Surveyor = surveyor)
    Condition
      Error in `write_to_spi_sheet()`:
      ! `camera_label` must be present in `x`. Use `merge_deployment_images()`

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      X           Hidden        UBC X    XX-Nov-XXXX       XX:XX:XX
      X           Hidden        UBC X    XX-Apr-XXXX       XX:XX:XX
      X           Hidden        UBC X    XX-Nov-XXXX       XX:XX:XX
      X           Hidden        UBC X    XX-Feb-XXXX       XX:XX:XX
      X           Hidden        UBC X    XX-May-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Jan-XXXX       XX:XX:XX
      X           Hidden      EcoXXXX    XX-Feb-XXXX       XX:XX:XX
      XX            <NA>         <NA>    XX-Nov-XXXX       XX:XX:XX
      XX            <NA>         <NA>    XX-Feb-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden        UBC X    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX            <NA>         <NA>    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden        UBC X    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
      XX            <NA>         <NA>    XX-Nov-XXXX       XX:XX:XX
      XX          Hidden        UBC X    XX-Jan-XXXX       XX:XX:XX
      XX          Hidden      EcoXXXX    XX-Nov-XXXX       XX:XX:XX
         Air Temperature (C) Sequence Definition (s) Species Code Count
      X                   NA                      NA           NA     X
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA     X
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA     X
      X                   NA                      NA           NA    NA
      X                   NA                      NA           NA    NA
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA    NA
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA    NA
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA     X
      XX                  NA                      NA           NA    NA
      XX                  NA                      NA           NA     X
         Life Stage Code Sex Code Adult Males Adult Females Adults - Unclassified Sex
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      X               NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
      XX              NA       NA          NA            NA                        NA
         Juvenile Males Juvenile Females Juveniles - Unclassified Sex Yearling Males
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      X              NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
      XX             NA               NA                           NA             NA
         Yearling Females Yearlings - Unclassified Sex
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      X                NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
      XX               NA                           NA
         Males - Unclassified Life Stage Females - Unclassified Life Stage
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      X                               NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
      XX                              NA                                NA
         Unclassified Life Stage and Sex Activity Code Animal ID
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      X                               NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
      XX                              NA            NA        NA
         Human Transport Mode Code Human Use Type Code Survey Observation Photos
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      X                         NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
      XX                        NA                  NA                        NA
         Surveyor Comments Add your new column here
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      X    Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA
      XX   Hidden       NA                       NA

# fill_spi_template_ff() works

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
    Output
        Study Area Name Study Area Photos Sample Station Label
      2    2080 labieux                NA                555-1
      3       Habaneros                NA                   A1
      4     jdsklfjdslj                NA            Test12345
      5      Lantzville                NA                 1234
      6         Nahmint                NA   NAH_NahmintRiver_1
      7      Lantzville                NA          Bearden1234
      8      Lantzville                NA                Test2
      9            Test                NA                Test3
        UTM Zone Sample Station Easting Sample Station Northing Sample Station
      2                      NA                     NA                      NA
      3                      NA                     NA                      NA
      4                      NA                     NA                      NA
      5                      NA                     NA                      NA
      6                      NA                     NA                      NA
      7                      NA                     NA                      NA
      8                      NA                     NA                      NA
      9                      NA                     NA                      NA
        Longitude Sample Station (DD) Latitude Sample Station (DD) Number of Cameras
      2                     -123.9939                     49.20063                NA
      3                     -124.1368                     49.24628                NA
      4                     -123.8791                     49.10714                NA
      5                     -124.1118                     49.25425                NA
      6                     -124.1118                     49.25425                NA
      7                     -124.1101                     49.25476                NA
      8                     -124.1193                     49.24874                NA
      9                     -124.0978                     49.24451                NA
        Sample Station Comments Sample Station Photos Site Description Comments
      2                      NA                    NA                        NA
      3                      NA                    NA                        NA
      4                      NA                    NA                        NA
      5                      NA                    NA                        NA
      6                      NA                    NA                        NA
      7                      NA                    NA                        NA
      8                      NA                    NA                        NA
      9                      NA                    NA                        NA
        Site Description Date
      2                    NA
      3                    NA
      4                    NA
      5                    NA
      6                    NA
      7                    NA
      8                    NA
      9                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
    Output
        Study Area Name Camera Label Parent Sample Station Label UTM Zone Camera
      2       Habaneros         Test                          NA              NA
      3    2080 labieux         Test                          NA              NA
      4      Lantzville         Test                          NA              NA
        Easting Camera Northing Camera Longitude Camera (DD) Latitude Camera (DD)
      2             NA              NA             -124.1101             49.25476
      3             NA              NA             -124.1193             49.24874
      4             NA              NA             -124.0978             49.24451
        Make of Camera Code Model of Camera Camera Comments Site Description Comments
      2                  NA              NA              NA                        NA
      3                  NA              NA              NA                        NA
      4                  NA              NA              NA                        NA
        Site Description Date
      2                    NA
      3                    NA
      4                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
    Output
        Study Area Name Camera Label        Date Time Visit End Date End Time
      2       Habaneros         Test 13-Mar-2024   NA           <NA>       NA
      3    2080 labieux         Test 10-Mar-2024   NA           <NA>       NA
      4      Lantzville         Test 07-Mar-2024   NA    15-Mar-2024       NA
        Total Visit or Deployment Time Unit of Total Time Code Quiet Period (s)
      2                             NA                      NA               NA
      3                             NA                      NA               NA
      4                             NA                      NA               NA
        Trigger Sensitivity Trigger Timing (s) Photos per Trigger
      2                  NA                 NA                 NA
      3                  NA                 NA                 NA
      4                  NA                 NA                 NA
        Video Length per Trigger (s) Bait Lure Type Camera Visit Comments
      2                           NA             NA                    NA
      3                           NA             NA                    NA
      4                           NA             NA                    NA
        Camera Visit Photos Insert Predefined Camera Visit Column
      2                  NA                                    NA
      3                  NA                                    NA
      4                  NA                                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      2       McKay Lake           NA    16-Dec-2022       00:00:00
      3       McKay Lake           NA    28-Nov-2022       14:52:04
      4       McKay Lake           NA    16-Dec-2022       13:16:17
      5       McKay Lake           NA    17-Dec-2022       12:00:00
      6       McKay Lake           NA    16-Dec-2022       16:18:28
      7       McKay Lake           NA    28-Nov-2022       13:00:49
      8       McKay Lake           NA    17-Dec-2022       12:00:00
      9       McKay Lake           NA    16-Dec-2022       12:00:00
      10      McKay Lake           NA    28-Nov-2022       15:50:38
      11      McKay Lake           NA    28-Nov-2022       11:19:24
      12      McKay Lake           NA    16-Dec-2022       12:00:00
         Air Temperature (C) Sequence Definition (s) Species Code Count
      2                   NA                      NA           NA    NA
      3                   NA                      NA           NA    NA
      4                   NA                      NA           NA     1
      5                   NA                      NA           NA    NA
      6                   NA                      NA           NA     1
      7                   NA                      NA           NA    NA
      8                   NA                      NA           NA    NA
      9                   NA                      NA           NA    NA
      10                  NA                      NA           NA     1
      11                  NA                      NA           NA     1
      12                  NA                      NA           NA    NA
         Life Stage Code Sex Code Adult Males Adult Females Adults - Unclassified Sex
      2               NA       NA          NA            NA                        NA
      3               NA       NA          NA            NA                        NA
      4               NA       NA          NA            NA                        NA
      5               NA       NA          NA            NA                        NA
      6               NA       NA          NA            NA                        NA
      7               NA       NA          NA            NA                        NA
      8               NA       NA          NA            NA                        NA
      9               NA       NA          NA            NA                        NA
      10              NA       NA          NA            NA                        NA
      11              NA       NA          NA            NA                        NA
      12              NA       NA          NA            NA                        NA
         Juvenile Males Juvenile Females Juveniles - Unclassified Sex Yearling Males
      2              NA               NA                           NA             NA
      3              NA               NA                           NA             NA
      4              NA               NA                           NA             NA
      5              NA               NA                           NA             NA
      6              NA               NA                           NA             NA
      7              NA               NA                           NA             NA
      8              NA               NA                           NA             NA
      9              NA               NA                           NA             NA
      10             NA               NA                           NA             NA
      11             NA               NA                           NA             NA
      12             NA               NA                           NA             NA
         Yearling Females Yearlings - Unclassified Sex
      2                NA                           NA
      3                NA                           NA
      4                NA                           NA
      5                NA                           NA
      6                NA                           NA
      7                NA                           NA
      8                NA                           NA
      9                NA                           NA
      10               NA                           NA
      11               NA                           NA
      12               NA                           NA
         Males - Unclassified Life Stage Females - Unclassified Life Stage
      2                               NA                                NA
      3                               NA                                NA
      4                               NA                                NA
      5                               NA                                NA
      6                               NA                                NA
      7                               NA                                NA
      8                               NA                                NA
      9                               NA                                NA
      10                              NA                                NA
      11                              NA                                NA
      12                              NA                                NA
         Unclassified Life Stage and Sex Activity Code Animal ID
      2                               NA            NA        NA
      3                               NA            NA        NA
      4                               NA            NA        NA
      5                               NA            NA        NA
      6                               NA            NA        NA
      7                               NA            NA        NA
      8                               NA            NA        NA
      9                               NA            NA        NA
      10                              NA            NA        NA
      11                              NA            NA        NA
      12                              NA            NA        NA
         Human Transport Mode Code Human Use Type Code Survey Observation Photos
      2                         NA                  NA                        NA
      3                         NA                  NA                        NA
      4                         NA                  NA                        NA
      5                         NA                  NA                        NA
      6                         NA                  NA                        NA
      7                         NA                  NA                        NA
      8                         NA                  NA                        NA
      9                         NA                  NA                        NA
      10                        NA                  NA                        NA
      11                        NA                  NA                        NA
      12                        NA                  NA                        NA
         Surveyor Comments Add your new column here
      2        NA       NA                       NA
      3        NA       NA                       NA
      4        NA       NA                       NA
      5        NA       NA                       NA
      6        NA       NA                       NA
      7        NA       NA                       NA
      8        NA       NA                       NA
      9        NA       NA                       NA
      10       NA       NA                       NA
      11       NA       NA                       NA
      12       NA       NA                       NA

# fill_spi_template_ff() works with project subsetting and no image data

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
    Output
        Study Area Name Study Area Photos Sample Station Label
      2    2080 labieux                NA                555-1
      3      Lantzville                NA          Bearden1234
        UTM Zone Sample Station Easting Sample Station Northing Sample Station
      2                      NA                     NA                      NA
      3                      NA                     NA                      NA
        Longitude Sample Station (DD) Latitude Sample Station (DD) Number of Cameras
      2                     -123.9939                     49.20063                NA
      3                     -124.1101                     49.25476                NA
        Sample Station Comments Sample Station Photos Site Description Comments
      2                      NA                    NA                        NA
      3                      NA                    NA                        NA
        Site Description Date
      2                    NA
      3                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Information")
    Output
        Study Area Name Camera Label Parent Sample Station Label UTM Zone Camera
      2    2080 labieux         Test                          NA              NA
      3      Lantzville         Test                          NA              NA
        Easting Camera Northing Camera Longitude Camera (DD) Latitude Camera (DD)
      2             NA              NA             -124.1193             49.24874
      3             NA              NA             -124.0978             49.24451
        Make of Camera Code Model of Camera Camera Comments Site Description Comments
      2                  NA              NA              NA                        NA
      3                  NA              NA              NA                        NA
        Site Description Date
      2                    NA
      3                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Camera Setup and Checks")
    Output
        Study Area Name Camera Label        Date Time Visit End Date End Time
      2    2080 labieux         Test 10-Mar-2024   NA           <NA>       NA
      3      Lantzville         Test 07-Mar-2024   NA    15-Mar-2024       NA
        Total Visit or Deployment Time Unit of Total Time Code Quiet Period (s)
      2                             NA                      NA               NA
      3                             NA                      NA               NA
        Trigger Sensitivity Trigger Timing (s) Photos per Trigger
      2                  NA                 NA                 NA
      3                  NA                 NA                 NA
        Video Length per Trigger (s) Bait Lure Type Camera Visit Comments
      2                           NA             NA                    NA
      3                           NA             NA                    NA
        Camera Visit Photos Insert Predefined Camera Visit Column
      2                  NA                                    NA
      3                  NA                                    NA

---

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
       [1] Study Area Name                   Camera Label                     
       [3] Detection Date                    Detection Time                   
       [5] Air Temperature (C)               Sequence Definition (s)          
       [7] Species Code                      Count                            
       [9] Life Stage Code                   Sex Code                         
      [11] Adult Males                       Adult Females                    
      [13] Adults - Unclassified Sex         Juvenile Males                   
      [15] Juvenile Females                  Juveniles - Unclassified Sex     
      [17] Yearling Males                    Yearling Females                 
      [19] Yearlings - Unclassified Sex      Males - Unclassified Life Stage  
      [21] Females - Unclassified Life Stage Unclassified Life Stage and Sex  
      [23] Activity Code                     Animal ID                        
      [25] Human Transport Mode Code         Human Use Type Code              
      [27] Survey Observation Photos         Surveyor                         
      [29] Comments                          Add your new column here         
      <0 rows> (or 0-length row.names)

