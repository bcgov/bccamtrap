# write_image_data() works with excel template

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      2       McKay Lake           A4    16-Dec-2022       00:00:00
      3       McKay Lake           A4    17-Dec-2022       00:00:00
      4       McKay Lake           B3    28-Nov-2022       14:52:04
      5       McKay Lake           B3    30-Nov-2022       00:00:00
      6       McKay Lake           B4    16-Dec-2022       13:16:17
      7       McKay Lake           B4    16-Dec-2022       13:16:19
      8       McKay Lake           C1    17-Dec-2022       12:00:00
      9       McKay Lake           C1    18-Dec-2022       12:00:00
      10      McKay Lake           C2    16-Dec-2022       16:18:28
      11      McKay Lake           C2    16-Dec-2022       16:18:29
      12      McKay Lake           C3    28-Nov-2022       13:00:49
      13      McKay Lake           C3    28-Nov-2022       14:01:10
      14      McKay Lake           C4    17-Dec-2022       12:00:00
      15      McKay Lake           C4    18-Dec-2022       12:00:00
      16      McKay Lake           C5    16-Dec-2022       12:00:00
      17      McKay Lake           C5    17-Dec-2022       12:00:00
      18      McKay Lake           D2    28-Nov-2022       15:50:38
      19      McKay Lake           D2    28-Nov-2022       15:50:40
      20      McKay Lake           D3    28-Nov-2022       11:19:24
      21      McKay Lake           D3    28-Nov-2022       11:21:42
      22      McKay Lake           D5    16-Dec-2022       12:00:00
      23      McKay Lake           D5    17-Dec-2022       12:00:00
         Air Temperature (C) Sequence Definition (s) Species Code Count
      2                   NA                      NA           NA    NA
      3                   NA                      NA           NA    NA
      4                   NA                      NA           NA    NA
      5                   NA                      NA           NA    NA
      6                   NA                      NA           NA     1
      7                   NA                      NA           NA    NA
      8                   NA                      NA           NA    NA
      9                   NA                      NA           NA    NA
      10                  NA                      NA           NA     1
      11                  NA                      NA           NA    NA
      12                  NA                      NA           NA    NA
      13                  NA                      NA           NA    NA
      14                  NA                      NA           NA    NA
      15                  NA                      NA           NA    NA
      16                  NA                      NA           NA    NA
      17                  NA                      NA           NA    NA
      18                  NA                      NA           NA     1
      19                  NA                      NA           NA    NA
      20                  NA                      NA           NA     1
      21                  NA                      NA           NA    NA
      22                  NA                      NA           NA    NA
      23                  NA                      NA           NA    NA
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
      13              NA       NA          NA            NA                        NA
      14              NA       NA          NA            NA                        NA
      15              NA       NA          NA            NA                        NA
      16              NA       NA          NA            NA                        NA
      17              NA       NA          NA            NA                        NA
      18              NA       NA          NA            NA                        NA
      19              NA       NA          NA            NA                        NA
      20              NA       NA          NA            NA                        NA
      21              NA       NA          NA            NA                        NA
      22              NA       NA          NA            NA                        NA
      23              NA       NA          NA            NA                        NA
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
      13             NA               NA                           NA             NA
      14             NA               NA                           NA             NA
      15             NA               NA                           NA             NA
      16             NA               NA                           NA             NA
      17             NA               NA                           NA             NA
      18             NA               NA                           NA             NA
      19             NA               NA                           NA             NA
      20             NA               NA                           NA             NA
      21             NA               NA                           NA             NA
      22             NA               NA                           NA             NA
      23             NA               NA                           NA             NA
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
      13               NA                           NA
      14               NA                           NA
      15               NA                           NA
      16               NA                           NA
      17               NA                           NA
      18               NA                           NA
      19               NA                           NA
      20               NA                           NA
      21               NA                           NA
      22               NA                           NA
      23               NA                           NA
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
      13                              NA                                NA
      14                              NA                                NA
      15                              NA                                NA
      16                              NA                                NA
      17                              NA                                NA
      18                              NA                                NA
      19                              NA                                NA
      20                              NA                                NA
      21                              NA                                NA
      22                              NA                                NA
      23                              NA                                NA
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
      13                              NA            NA        NA
      14                              NA            NA        NA
      15                              NA            NA        NA
      16                              NA            NA        NA
      17                              NA            NA        NA
      18                              NA            NA        NA
      19                              NA            NA        NA
      20                              NA            NA        NA
      21                              NA            NA        NA
      22                              NA            NA        NA
      23                              NA            NA        NA
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
      13                        NA                  NA                        NA
      14                        NA                  NA                        NA
      15                        NA                  NA                        NA
      16                        NA                  NA                        NA
      17                        NA                  NA                        NA
      18                        NA                  NA                        NA
      19                        NA                  NA                        NA
      20                        NA                  NA                        NA
      21                        NA                  NA                        NA
      22                        NA                  NA                        NA
      23                        NA                  NA                        NA
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
      13       NA       NA                       NA
      14       NA       NA                       NA
      15       NA       NA                       NA
      16       NA       NA                       NA
      17       NA       NA                       NA
      18       NA       NA                       NA
      19       NA       NA                       NA
      20       NA       NA                       NA
      21       NA       NA                       NA
      22       NA       NA                       NA
      23       NA       NA                       NA

