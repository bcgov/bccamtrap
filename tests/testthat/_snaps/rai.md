# sample_rai works

    Code
      sample_rai(imgs1)
    Output
      # A tibble: 29 x 8
         deployment_label sample_start_date sample_end_date trap_days species      
         <chr>            <date>            <date>              <int> <chr>        
       1 A4_20230517      2022-12-16        2023-05-17            153 Beaver       
       2 A4_20230517      2022-12-16        2023-05-17            153 Mule Deer    
       3 A4_20230517      2022-12-16        2023-05-17            153 Roosevelt Elk
       4 A4_20230517      2022-12-16        2023-05-17            153 Unknown      
       5 B3_20220517      2022-11-28        2023-05-17            160 Mule Deer    
       6 B3_20220517      2022-11-28        2023-05-17            160 Roosevelt Elk
       7 B3_20220517      2022-11-28        2023-05-17            160 Unknown      
       8 B4_20230517      2022-12-16        2023-05-17            143 Mule Deer    
       9 B4_20230517      2022-12-16        2023-05-17            143 Roosevelt Elk
      10 C1_20230517      2022-12-17        2023-05-17            145 Black Bear   
      # i 19 more rows
      # i 3 more variables: n_detections <int>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, deployment_label = "A4_20230517")
    Output
      # A tibble: 4 x 8
        deployment_label sample_start_date sample_end_date trap_days species      
        <chr>            <date>            <date>              <int> <chr>        
      1 A4_20230517      2022-12-16        2023-05-17            153 Beaver       
      2 A4_20230517      2022-12-16        2023-05-17            153 Mule Deer    
      3 A4_20230517      2022-12-16        2023-05-17            153 Roosevelt Elk
      4 A4_20230517      2022-12-16        2023-05-17            153 Unknown      
      # i 3 more variables: n_detections <int>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, species = "Roosevelt Elk")
    Output
      # A tibble: 10 x 8
         deployment_label sample_start_date sample_end_date trap_days species      
         <chr>            <date>            <date>              <int> <chr>        
       1 A4_20230517      2022-12-16        2023-05-17            153 Roosevelt Elk
       2 B3_20220517      2022-11-28        2023-05-17            160 Roosevelt Elk
       3 B4_20230517      2022-12-16        2023-05-17            143 Roosevelt Elk
       4 C1_20230517      2022-12-17        2023-05-17            145 Roosevelt Elk
       5 C2_20230517      2022-12-16        2023-05-17            151 Roosevelt Elk
       6 C3_20230517      2022-11-28        2023-05-17            166 Roosevelt Elk
       7 C4_20230517      2022-12-17        2023-05-17            147 Roosevelt Elk
       8 D2_20230517      2022-11-28        2023-05-17            164 Roosevelt Elk
       9 D3_20230517      2022-11-28        2023-05-17            161 Roosevelt Elk
      10 D5_20230517      2022-12-16        2023-05-17            152 Roosevelt Elk
      # i 3 more variables: n_detections <int>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, by_deployment = FALSE, by_species = FALSE)
    Output
      # A tibble: 1 x 6
        sample_start_date sample_end_date trap_days n_detections total_count   rai
        <date>            <date>              <int>        <int>       <dbl> <dbl>
      1 2022-11-28        2023-05-17            166          175         300  1.81

---

    Code
      sample_rai(imgs1, by_deployment = FALSE)
    Output
      # A tibble: 7 x 7
        sample_start_date sample_end_date trap_days species   n_detections total_count
        <date>            <date>              <int> <chr>            <int>       <dbl>
      1 2022-11-28        2023-05-17            164 Avian (c~            1           1
      2 2022-12-16        2023-05-17            153 Beaver               1           1
      3 2022-12-16        2023-05-17            152 Black Be~            2           2
      4 2022-12-16        2023-05-17            151 Domestic~            1           3
      5 2022-11-28        2023-05-17            166 Mule Deer           69          92
      6 2022-11-28        2023-05-17            166 Roosevel~           96         200
      7 2022-11-28        2023-05-17            160 Unknown              5           1
      # i 1 more variable: rai <dbl>

---

    Code
      sample_rai(imgs1, by_species = FALSE)
    Output
      # A tibble: 11 x 7
         deployment_label sample_start_date sample_end_date trap_days n_detections
         <chr>            <date>            <date>              <int>        <int>
       1 A4_20230517      2022-12-16        2023-05-17            153           28
       2 B3_20220517      2022-11-28        2023-05-17            160            9
       3 B4_20230517      2022-12-16        2023-05-17            143           10
       4 C1_20230517      2022-12-17        2023-05-17            145           25
       5 C2_20230517      2022-12-16        2023-05-17            151           20
       6 C3_20230517      2022-11-28        2023-05-17            166           27
       7 C4_20230517      2022-12-17        2023-05-17            147           14
       8 C5_20230517      2022-12-16        2023-05-17            145            3
       9 D2_20230517      2022-11-28        2023-05-17            164           19
      10 D3_20230517      2022-11-28        2023-05-17            161           11
      11 D5_20230517      2022-12-16        2023-05-17            152            9
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 15 x 8
         deployment_label sample_start_date sample_end_date trap_days species      
         <chr>            <date>            <date>              <int> <chr>        
       1 A4_20230517      2022-12-16        2023-02-05             52 Mule Deer    
       2 A4_20230517      2022-12-16        2023-02-05             52 Roosevelt Elk
       3 B3_20220517      2022-12-16        2023-02-05             48 Mule Deer    
       4 B3_20220517      2022-12-16        2023-02-05             48 Roosevelt Elk
       5 B4_20230517      2022-12-16        2023-02-05             48 Roosevelt Elk
       6 C1_20230517      2022-12-17        2023-02-05             48 Mule Deer    
       7 C1_20230517      2022-12-17        2023-02-05             48 Roosevelt Elk
       8 C2_20230517      2022-12-16        2023-02-05             50 Mule Deer    
       9 C3_20230517      2022-12-16        2023-02-05             52 Roosevelt Elk
      10 C4_20230517      2022-12-17        2023-02-05             48 Roosevelt Elk
      11 D2_20230517      2022-12-16        2023-02-05             49 Mule Deer    
      12 D2_20230517      2022-12-16        2023-02-05             49 Roosevelt Elk
      13 D3_20230517      2022-12-16        2023-02-05             48 Mule Deer    
      14 D3_20230517      2022-12-16        2023-02-05             48 Roosevelt Elk
      15 D5_20230517      2022-12-16        2023-02-05             52 Mule Deer    
      # i 3 more variables: n_detections <int>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs2, deployment_label = "19_1_20230605", species = "Roosevelt Elk",
        sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 1 x 8
        deployment_label sample_start_date sample_end_date trap_days species      
        <chr>            <date>            <date>              <int> <chr>        
      1 19_1_20230605    2022-12-16        2023-02-05             52 Roosevelt Elk
      # i 3 more variables: n_detections <int>, total_count <dbl>, rai <dbl>

# rai_by_time works

    Code
      rm_id_cols(rai_by_time(imgs1))
    Output
      # A tibble: 1,368 x 7
         species      date       max_snow_index mean_temperature total_count trap_days
         <chr>        <date>              <dbl>            <dbl>       <dbl>     <int>
       1 Avian (comm~ 2022-11-28              1             3              0         1
       2 Avian (comm~ 2022-11-29              1            -3.67           0         3
       3 Avian (comm~ 2022-11-30              2            -3.5            0         2
       4 Avian (comm~ 2022-12-01              2            -4.33           0         3
       5 Avian (comm~ 2022-12-02              2            -6              0         1
       6 Avian (comm~ 2022-12-03              3            -1.33           0         3
       7 Avian (comm~ 2022-12-04              2            -4              0         3
       8 Avian (comm~ 2022-12-05              2            -5.33           0         3
       9 Avian (comm~ 2022-12-06              2            -1.33           0         3
      10 Avian (comm~ 2022-12-07              2            -1.67           0         3
      # i 1,358 more rows
      # i 1 more variable: rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs2))
    Output
      # A tibble: 2,205 x 7
         species      date       max_snow_index mean_temperature total_count trap_days
         <chr>        <date>              <dbl>            <dbl>       <dbl>     <int>
       1 Avian (comm~ 2022-11-07              2             6              0         1
       2 Avian (comm~ 2022-11-08              2            -1.75           0         4
       3 Avian (comm~ 2022-11-09              2            -3.25           0         4
       4 Avian (comm~ 2022-11-10              2             1.2            0         5
       5 Avian (comm~ 2022-11-11              2             1              0         7
       6 Avian (comm~ 2022-11-12              2             1.57           0         7
       7 Avian (comm~ 2022-11-13              2             2.57           0         7
       8 Avian (comm~ 2022-11-14              2             1.71           0         7
       9 Avian (comm~ 2022-11-15              2             0.5            0         8
      10 Avian (comm~ 2022-11-16              2            -1              0        10
      # i 2,195 more rows
      # i 1 more variable: rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs_bd))
    Output
      # A tibble: 2,496 x 7
         species    date       max_snow_index mean_temperature total_count trap_days
         <chr>      <date>              <dbl>            <dbl>       <dbl>     <int>
       1 Black Bear 2020-10-02              0               15           0         1
       2 Black Bear 2020-10-03              0               12           0         1
       3 Black Bear 2020-10-04              0               11           0         1
       4 Black Bear 2020-10-05              0               12           0         1
       5 Black Bear 2020-10-06              0               12           0         1
       6 Black Bear 2020-10-07              0               12           0         1
       7 Black Bear 2020-10-08              0               11           0         1
       8 Black Bear 2020-10-09              0               11           0         1
       9 Black Bear 2020-10-10              0                7           0         1
      10 Black Bear 2020-10-11              0                6           0         1
      # i 2,486 more rows
      # i 1 more variable: rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs1, sample_start_date = "2022-12-16",
        sample_end_date = "2023-02-05"))
    Output
      # A tibble: 156 x 7
         species   date       max_snow_index mean_temperature total_count trap_days
         <chr>     <date>              <dbl>            <dbl>       <dbl>     <int>
       1 Mule Deer 2022-12-16              3           -2               1         7
       2 Mule Deer 2022-12-17              3           -2.18            0        11
       3 Mule Deer 2022-12-18              3           -3.91            0        11
       4 Mule Deer 2022-12-19              3           -7.73            2        11
       5 Mule Deer 2022-12-20              3           -7.6             0         5
       6 Mule Deer 2022-12-21              3           -8.25            0         4
       7 Mule Deer 2022-12-22              3          -11.5             0         4
       8 Mule Deer 2022-12-23              3           -6.38            0         8
       9 Mule Deer 2022-12-24              3           -1.7             2        10
      10 Mule Deer 2022-12-25              3           -0.818           0        11
      # i 146 more rows
      # i 1 more variable: rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs2, deployment_label = "19_1_20230605", species = "Roosevelt Elk",
        sample_start_date = "2022-12-16", sample_end_date = "2023-02-05"))
    Output
      # A tibble: 52 x 7
         species      date       max_snow_index mean_temperature total_count trap_days
         <chr>        <date>              <dbl>            <dbl>       <dbl>     <int>
       1 Roosevelt E~ 2022-12-16              4               -1           0         1
       2 Roosevelt E~ 2022-12-17              4               -1           0         1
       3 Roosevelt E~ 2022-12-18              4               -1           0         1
       4 Roosevelt E~ 2022-12-19              4               -5           0         1
       5 Roosevelt E~ 2022-12-20              4               -4           0         1
       6 Roosevelt E~ 2022-12-21              4               -6           0         1
       7 Roosevelt E~ 2022-12-22              4               -6           0         1
       8 Roosevelt E~ 2022-12-23              5               -5           0         1
       9 Roosevelt E~ 2022-12-24              5               -1           0         1
      10 Roosevelt E~ 2022-12-25              5                0           1         1
      # i 42 more rows
      # i 1 more variable: rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs1, by_species = FALSE))
    Output
      # A tibble: 171 x 6
         date       max_snow_index mean_temperature total_count trap_days   rai
         <date>              <dbl>            <dbl>       <dbl>     <int> <dbl>
       1 2022-11-28              1             3              1         1 1    
       2 2022-11-29              1            -3.67           1         3 0.333
       3 2022-11-30              2            -3.5            0         2 0    
       4 2022-12-01              2            -4.33           5         3 1.67 
       5 2022-12-02              2            -6              0         1 0    
       6 2022-12-03              3            -1.33           1         3 0.333
       7 2022-12-04              2            -4              0         3 0    
       8 2022-12-05              2            -5.33           4         3 1.33 
       9 2022-12-06              2            -1.33           0         3 0    
      10 2022-12-07              2            -1.67           0         3 0    
      # i 161 more rows

---

    Code
      rm_id_cols(rai_by_time(imgs_bd, by_deployment = TRUE, sample_start_date = "2021-12-16",
        sample_end_date = "2022-05-05"))
    Output
      # A tibble: 282 x 6
         deployment_label        date       snow_index temperature species total_count
         <chr>                   <date>          <dbl>       <dbl> <chr>         <dbl>
       1 COU_AlberniInlet_1_202~ 2021-12-16          0          -1 Mule D~           0
       2 COU_AlberniInlet_1_202~ 2021-12-16          0          -1 <NA>              0
       3 COU_AlberniInlet_1_202~ 2021-12-17          0          -2 Mule D~           0
       4 COU_AlberniInlet_1_202~ 2021-12-17          0          -2 <NA>              0
       5 COU_AlberniInlet_1_202~ 2021-12-18          0          -1 Mule D~           0
       6 COU_AlberniInlet_1_202~ 2021-12-18          0          -1 <NA>              0
       7 COU_AlberniInlet_1_202~ 2021-12-19          0          -1 Mule D~           0
       8 COU_AlberniInlet_1_202~ 2021-12-19          0          -1 <NA>              0
       9 COU_AlberniInlet_1_202~ 2021-12-20          0          -4 Mule D~           0
      10 COU_AlberniInlet_1_202~ 2021-12-20          0          -4 <NA>              0
      # i 272 more rows

---

    Code
      rm_id_cols(rai_by_time(imgs2, "week", species = "Roosevelt Elk", by_deployment = FALSE,
        roll = TRUE))
    Output
      # A tibble: 36 x 14
         species       week      start_date end_date   max_snow_index mean_temperature
         <chr>         <chr>     <date>     <date>              <dbl>            <dbl>
       1 Roosevelt Elk 2022-W-45 2022-11-07 2022-11-13              2           0.8   
       2 Roosevelt Elk 2022-W-46 2022-11-14 2022-11-20              3          -0.195 
       3 Roosevelt Elk 2022-W-47 2022-11-21 2022-11-27              3           3.68  
       4 Roosevelt Elk 2022-W-48 2022-11-28 2022-12-04              4          -1.07  
       5 Roosevelt Elk 2022-W-49 2022-12-05 2022-12-11              5          -0.0230
       6 Roosevelt Elk 2022-W-50 2022-12-12 2022-12-18              5          -0.347 
       7 Roosevelt Elk 2022-W-51 2022-12-19 2022-12-25              5          -3.06  
       8 Roosevelt Elk 2022-W-52 2022-12-26 2022-12-31              5           1.63  
       9 Roosevelt Elk 2023-W-01 2023-01-02 2023-01-08              5           1.68  
      10 Roosevelt Elk 2023-W-02 2023-01-09 2023-01-15              5           2.89  
      # i 26 more rows
      # i 8 more variables: total_count <dbl>, trap_days <int>, rai <dbl>,
      #   roll_mean_max_snow <dbl>, roll_mean_temp <dbl>, roll_trap_days <int>,
      #   roll_count <dbl>, roll_rai <dbl>

---

    Code
      rm_id_cols(rai_by_time(imgs_bd, "year", by_species = TRUE, by_deployment = TRUE,
        roll = TRUE))
    Output
      # A tibble: 12 x 15
         deployment_label           species year  start_date end_date   max_snow_index
         <chr>                      <chr>   <chr> <date>     <date>              <dbl>
       1 COU_AlberniInlet_1_2021_2~ Black ~ 2020  2020-10-02 2020-12-31              0
       2 COU_AlberniInlet_1_2021_2~ Black ~ 2021  2021-01-01 2021-12-31              0
       3 COU_AlberniInlet_1_2021_2~ Black ~ 2022  2022-01-01 2022-09-12              0
       4 COU_AlberniInlet_1_2021_2~ Mule D~ 2020  2020-10-02 2020-12-31              0
       5 COU_AlberniInlet_1_2021_2~ Mule D~ 2021  2021-01-01 2021-12-31              0
       6 COU_AlberniInlet_1_2021_2~ Mule D~ 2022  2022-01-01 2022-09-12              0
       7 COU_AlberniInlet_1_2021_2~ Red Sq~ 2020  2020-10-02 2020-12-31              0
       8 COU_AlberniInlet_1_2021_2~ Red Sq~ 2021  2021-01-01 2021-12-31              0
       9 COU_AlberniInlet_1_2021_2~ Red Sq~ 2022  2022-01-01 2022-09-12              0
      10 COU_AlberniInlet_1_2021_2~ <NA>    2020  2020-10-02 2020-12-31              0
      11 COU_AlberniInlet_1_2021_2~ <NA>    2021  2021-01-01 2021-12-31              0
      12 COU_AlberniInlet_1_2021_2~ <NA>    2022  2022-01-01 2022-09-12              0
      # i 9 more variables: mean_temperature <dbl>, total_count <dbl>,
      #   trap_days <int>, rai <dbl>, roll_mean_max_snow <lgl>, roll_mean_temp <lgl>,
      #   roll_trap_days <lgl>, roll_count <lgl>, roll_rai <dbl>

---

    Code
      dplyr::select(rai_by_time(imgs_bd, "month", by_species = TRUE, by_deployment = TRUE,
        roll = TRUE), dplyr::contains("roll"))
    Output
      # A tibble: 88 x 5
         roll_mean_max_snow roll_mean_temp roll_trap_days roll_count roll_rai
                      <dbl>          <dbl>          <int>      <dbl>    <dbl>
       1                 NA          NA                NA         NA   NA    
       2                 NA          NA                NA         NA   NA    
       3                 NA          NA                NA         NA   NA    
       4                  0           2.67              7          1    0.143
       5                  0           2.74              7          1    0.143
       6                  0           4.57              7          1    0.143
       7                  0           6.15              7          1    0.143
       8                  0           6.86              7          1    0.143
       9                  0           7.48              7          1    0.143
      10                  0           7.02              7          1    0.143
      # i 78 more rows

