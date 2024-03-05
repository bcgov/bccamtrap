# fill_spi_template() works

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sample Station Information")
    Output
           Study Area Name Study Area Photos Sample Station Label
      X  McKay Lake Parcel                NA                   AX
      X  McKay Lake Parcel                NA                   BX
      X  McKay Lake Parcel                NA                   BX
      X  McKay Lake Parcel                NA                   CX
      X  McKay Lake Parcel                NA                   CX
      X  McKay Lake Parcel                NA                   CX
      X  McKay Lake Parcel                NA                   CX
      X  McKay Lake Parcel                NA                   CX
      XX McKay Lake Parcel                NA                   DX
      XX McKay Lake Parcel                NA                   DX
      XX McKay Lake Parcel                NA                   DX
      XX McKay Lake Parcel                NA                   DX
      XX McKay Lake Parcel                NA                   CX
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
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      X  McKay Lake Parcel      EcoXXXX                          NA              NA
      XX McKay Lake Parcel      EcoXXXX                          NA              NA
      XX McKay Lake Parcel      EcoXXXX                          NA              NA
      XX McKay Lake Parcel      EcoXXXX                          NA              NA
      XX McKay Lake Parcel      EcoXXXX                          NA              NA
      XX McKay Lake Parcel      EcoXXXX                          NA              NA
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
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      X  McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Nov-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-Dec-XXXX   NA    XX-May-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA           <NA>       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
      XX McKay Lake Parcel      EcoXXXX XX-May-XXXX   NA    XX-Nov-XXXX       NA
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
      X       McKay Lake           AX    XX-Dec-XXXX       XX:XX:XX
      X       McKay Lake           BX    XX-Nov-XXXX       XX:XX:XX
      X       McKay Lake           BX    XX-Dec-XXXX       XX:XX:XX
      X       McKay Lake           CX    XX-Dec-XXXX       XX:XX:XX
      X       McKay Lake           CX    XX-Dec-XXXX       XX:XX:XX
      X       McKay Lake           CX    XX-Nov-XXXX       XX:XX:XX
      X       McKay Lake           CX    XX-Dec-XXXX       XX:XX:XX
      X       McKay Lake           CX    XX-Dec-XXXX       XX:XX:XX
      XX      McKay Lake           DX    XX-Nov-XXXX       XX:XX:XX
      XX      McKay Lake           DX    XX-Nov-XXXX       XX:XX:XX
      XX      McKay Lake           DX    XX-Dec-XXXX       XX:XX:XX
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

