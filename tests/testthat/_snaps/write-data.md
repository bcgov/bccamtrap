# write_image_data() works with excel template

    Code
      openxlsx2::read_xlsx(out_xls, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      2       McKay Lake           A4    16-Dec-2022       00:00:00
      3       McKay Lake           B3    28-Nov-2022       14:52:04
      4       McKay Lake           B4    16-Dec-2022       13:16:17
      5       McKay Lake           C1    17-Dec-2022       12:00:00
      6       McKay Lake           C2    16-Dec-2022       16:18:28
      7       McKay Lake           C3    28-Nov-2022       13:00:49
      8       McKay Lake           C4    17-Dec-2022       12:00:00
      9       McKay Lake           C5    16-Dec-2022       12:00:00
      10      McKay Lake           D2    28-Nov-2022       15:50:38
      11      McKay Lake           D3    28-Nov-2022       11:19:24
      12      McKay Lake           D5    16-Dec-2022       12:00:00
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

---

    Code
      openxlsx2::read_xlsx(out_xls2, sheet = "Sequence Image Data")
    Output
         Study Area Name Camera Label Detection Date Detection Time
      2     Taylor River         19_1    10-Nov-2022       15:15:53
      3     Taylor River         19_1    08-Apr-2023       12:00:00
      4     Taylor River         19_2    15-Nov-2022       12:44:41
      5     Taylor River         19_2    26-Feb-2023       13:55:06
      6     Taylor River         19_2    24-May-2023       23:18:47
      7     Taylor River           20    10-Nov-2022       13:59:30
      8     Taylor River           20    26-Jan-2023       15:23:37
      9     Taylor River           20    27-Feb-2023       12:00:00
      10    Taylor River         21_1    10-Nov-2022       11:44:09
      11    Taylor River         21_1    06-Feb-2023       12:00:00
      12    Taylor River         21_2    18-Nov-2022       14:43:32
      13    Taylor River           24    18-Nov-2022       11:53:31
      14    Taylor River           25    18-Nov-2022       12:40:40
      15    Taylor River           26    07-Nov-2022       11:49:14
      16    Taylor River           27    07-Nov-2022       13:20:15
      17    Taylor River           28    15-Nov-2022       11:18:26
      18    Taylor River         29_1    07-Nov-2022       14:44:46
      19    Taylor River         29_2    07-Nov-2022       15:27:00
      20    Taylor River         29_2    10-Nov-2022       15:48:50
      21    Taylor River         29_3    18-Nov-2022       16:13:52
      22    Taylor River           31    15-Nov-2022       13:49:06
      23    Taylor River           31    25-Jan-2023       13:32:05
      24    Taylor River           35    18-Nov-2022       11:01:49
         Air Temperature (C) Sequence Definition (s) Species Code Count
      2                   NA                      NA           NA     1
      3                   NA                      NA           NA    NA
      4                   NA                      NA           NA     1
      5                   NA                      NA           NA    NA
      6                   NA                      NA           NA    NA
      7                   NA                      NA           NA     1
      8                   NA                      NA           NA    NA
      9                   NA                      NA           NA    NA
      10                  NA                      NA           NA     1
      11                  NA                      NA           NA    NA
      12                  NA                      NA           NA     1
      13                  NA                      NA           NA     1
      14                  NA                      NA           NA     1
      15                  NA                      NA           NA     2
      16                  NA                      NA           NA     1
      17                  NA                      NA           NA     1
      18                  NA                      NA           NA     1
      19                  NA                      NA           NA    NA
      20                  NA                      NA           NA     1
      21                  NA                      NA           NA     1
      22                  NA                      NA           NA     1
      23                  NA                      NA           NA    NA
      24                  NA                      NA           NA     1
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
      24              NA       NA          NA            NA                        NA
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
      24             NA               NA                           NA             NA
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
      24               NA                           NA
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
      24                              NA                                NA
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
      24                              NA            NA        NA
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
      24                        NA                  NA                        NA
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
      24       NA       NA                       NA

