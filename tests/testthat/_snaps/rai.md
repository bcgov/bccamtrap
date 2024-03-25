# sample_rai works

    Code
      sample_rai(imgs1)
    Output
      # A tibble: 29 x 7
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
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, deployment_label = "A4_20230517")
    Output
      # A tibble: 4 x 7
        deployment_label sample_start_date sample_end_date trap_days species      
        <chr>            <date>            <date>              <int> <chr>        
      1 A4_20230517      2022-12-16        2023-05-17            153 Beaver       
      2 A4_20230517      2022-12-16        2023-05-17            153 Mule Deer    
      3 A4_20230517      2022-12-16        2023-05-17            153 Roosevelt Elk
      4 A4_20230517      2022-12-16        2023-05-17            153 Unknown      
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, species = "Roosevelt Elk")
    Output
      # A tibble: 10 x 7
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
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, by_deployment = FALSE, by_species = FALSE)
    Output
      # A tibble: 1 x 5
        sample_start_date sample_end_date trap_days total_count   rai
        <date>            <date>              <int>       <dbl> <dbl>
      1 2022-11-28        2023-05-17            166         300  1.81

---

    Code
      sample_rai(imgs1, by_deployment = FALSE)
    Output
      # A tibble: 7 x 6
        sample_start_date sample_end_date trap_days species        total_count     rai
        <date>            <date>              <int> <chr>                <dbl>   <dbl>
      1 2022-11-28        2023-05-17            164 Avian (commen~           1 0.00610
      2 2022-12-16        2023-05-17            153 Beaver                   1 0.00654
      3 2022-12-16        2023-05-17            152 Black Bear               2 0.0132 
      4 2022-12-16        2023-05-17            151 Domestic (com~           3 0.0199 
      5 2022-11-28        2023-05-17            166 Mule Deer               92 0.554  
      6 2022-11-28        2023-05-17            166 Roosevelt Elk          200 1.20   
      7 2022-11-28        2023-05-17            160 Unknown                  1 0.00625

---

    Code
      sample_rai(imgs1, by_species = FALSE)
    Output
      # A tibble: 11 x 6
         deployment_label sample_start_date sample_end_date trap_days total_count
         <chr>            <date>            <date>              <int>       <dbl>
       1 A4_20230517      2022-12-16        2023-05-17            153          50
       2 B3_20220517      2022-11-28        2023-05-17            160          10
       3 B4_20230517      2022-12-16        2023-05-17            143          17
       4 C1_20230517      2022-12-17        2023-05-17            145          38
       5 C2_20230517      2022-12-16        2023-05-17            151          30
       6 C3_20230517      2022-11-28        2023-05-17            166          58
       7 C4_20230517      2022-12-17        2023-05-17            147          32
       8 C5_20230517      2022-12-16        2023-05-17            145           5
       9 D2_20230517      2022-11-28        2023-05-17            164          22
      10 D3_20230517      2022-11-28        2023-05-17            161          20
      11 D5_20230517      2022-12-16        2023-05-17            152          18
      # i 1 more variable: rai <dbl>

---

    Code
      sample_rai(imgs1, sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 15 x 7
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
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs2, deployment_label = "19_1_20230605", species = "Roosevelt Elk",
        sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 1 x 7
        deployment_label sample_start_date sample_end_date trap_days species      
        <chr>            <date>            <date>              <int> <chr>        
      1 19_1_20230605    2022-12-16        2023-02-05             52 Roosevelt Elk
      # i 2 more variables: total_count <dbl>, rai <dbl>

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
      # A tibble: 104 x 7
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
      # i 94 more rows
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
      # A tibble: 72 x 14
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
      # i 62 more rows
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

---

    Code
      rai_by_time(imgs2, by = "date", species = "Roosevelt Elk", by_deployment = FALSE,
        roll = TRUE)[["roll_rai"]]
    Output
        [1]          NA          NA          NA 0.114285714 0.097560976 0.000000000
        [7] 0.019607843 0.017857143 0.016393443 0.014492754 0.025974026 0.105882353
       [13] 0.097826087 0.082474227 0.078431373 0.085714286 0.161904762 0.152380952
       [19] 0.085714286 0.089108911 0.096774194 0.104651163 0.101265823 0.013698630
       [25] 0.014492754 0.015384615 0.015151515 0.013888889 0.025974026 0.024691358
       [31] 0.011904762 0.011494253 0.011111111 0.010869565 0.064516129 0.053191489
       [37] 0.052083333 0.061224490 0.061224490 0.134020619 0.148936170 0.141304348
       [43] 0.142857143 0.146067416 0.134831461 0.144444444 0.086956522 0.083333333
       [49] 0.040404040 0.039603960 0.038461538 0.038095238 0.095238095 0.114285714
       [55] 0.304761905 0.419047619 0.428571429 0.428571429 0.428571429 0.361904762
       [61] 0.323809524 0.123809524 0.009615385 0.029126214 0.029411765 0.029702970
       [67] 0.030000000 0.080808081 0.081632653 0.081632653 0.051020408 0.051020408
       [73] 0.051020408 0.051020408 0.000000000 0.081632653 0.081632653 0.080808081
       [79] 0.080000000 0.079207921 0.078431373 0.077669903 0.000000000 0.000000000
       [85] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
       [91] 0.000000000 0.000000000 0.009523810 0.009523810 0.009523810 0.009523810
       [97] 0.009615385 0.009615385 0.009615385 0.000000000 0.000000000 0.000000000
      [103] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [109] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [115] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.019417476
      [121] 0.048076923 0.047619048 0.047619048 0.047619048 0.048076923 0.048543689
      [127] 0.117647059 0.158415842 0.297029703 0.297029703 0.297029703 0.294117647
      [133] 0.291262136 0.201923077 0.190476190 0.076190476 0.076190476 0.076190476
      [139] 0.076190476 0.076190476 0.076190476 0.019047619 0.028846154 0.038834951
      [145] 0.078431373 0.078431373 0.078431373 0.079207921 0.118811881 0.088235294
      [151] 0.077669903 0.048076923 0.048076923 0.048543689 0.057692308 0.019230769
      [157] 0.019230769 0.019417476 0.009803922 0.009900990 0.019801980 0.030000000
      [163] 0.030303030 0.030612245 0.030612245 0.030612245 0.030612245 0.020408163
      [169] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [175] 0.000000000 0.009803922 0.009708738 0.009615385 0.028571429 0.047619048
      [181] 0.047619048 0.047619048 0.095238095 0.095238095 0.095238095 0.085714286
      [187] 0.076190476 0.076190476 0.076190476 0.019047619 0.019047619 0.019047619
      [193] 0.009523810 0.000000000 0.009523810 0.009523810 0.009523810 0.028571429
      [199] 0.038095238 0.038095238 0.038095238 0.038095238 0.047619048 0.057142857
      [205] 0.047619048 0.047619048 0.047619048 0.051546392 0.058139535 0.053333333
      [211] 0.046875000 0.037735849 0.071428571 0.096774194 0.178571429 0.178571429
      [217] 0.178571429 0.178571429 0.178571429 0.107142857 0.214285714 0.142857143
      [223] 0.107142857 0.107142857 0.107142857 0.107142857 0.107142857 0.035714286
      [229] 0.035714286 0.035714286 0.035714286 0.035714286 0.035714286 0.035714286
      [235] 0.000000000 0.000000000 0.035714286 0.035714286 0.071428571 0.071428571
      [241] 0.115384615 0.125000000          NA          NA          NA          NA
      [247]          NA          NA 0.000000000 0.000000000 0.000000000 0.000000000
      [253] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [259] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [265] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [271] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [277] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [283] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [289] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [295] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [301] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [307] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [313] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [319] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [325] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [331] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [337] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [343] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [349] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [355] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [361] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [367] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [373] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [379] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [385] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [391] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [397] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [403] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [409] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [415] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [421] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [427] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [433] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [439] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [445] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [451] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [457] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [463] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [469] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [475] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [481] 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000 0.000000000
      [487] 0.000000000          NA          NA          NA

