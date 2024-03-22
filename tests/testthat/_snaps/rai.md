# sample_rai works

    Code
      sample_rai(imgs1)
    Output
      # A tibble: 29 x 7
         deployment_label sample_start_date sample_end_date sample_period_length
         <chr>            <date>            <date>                         <int>
       1 A4_20230517      2022-12-16        2023-05-17                       153
       2 A4_20230517      2022-12-16        2023-05-17                       153
       3 A4_20230517      2022-12-16        2023-05-17                       153
       4 A4_20230517      2022-12-16        2023-05-17                       153
       5 B3_20220517      2022-11-28        2023-05-17                       160
       6 B3_20220517      2022-11-28        2023-05-17                       160
       7 B3_20220517      2022-11-28        2023-05-17                       160
       8 B4_20230517      2022-12-16        2023-05-17                       143
       9 B4_20230517      2022-12-16        2023-05-17                       143
      10 C1_20230517      2022-12-17        2023-05-17                       145
      # i 19 more rows
      # i 3 more variables: species <chr>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, deployment_label = "A4_20230517")
    Output
      # A tibble: 4 x 7
        deployment_label sample_start_date sample_end_date sample_period_length
        <chr>            <date>            <date>                         <int>
      1 A4_20230517      2022-12-16        2023-05-17                       153
      2 A4_20230517      2022-12-16        2023-05-17                       153
      3 A4_20230517      2022-12-16        2023-05-17                       153
      4 A4_20230517      2022-12-16        2023-05-17                       153
      # i 3 more variables: species <chr>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, species = "Roosevelt Elk")
    Output
      # A tibble: 10 x 7
         deployment_label sample_start_date sample_end_date sample_period_length
         <chr>            <date>            <date>                         <int>
       1 A4_20230517      2022-12-16        2023-05-17                       153
       2 B3_20220517      2022-11-28        2023-05-17                       160
       3 B4_20230517      2022-12-16        2023-05-17                       143
       4 C1_20230517      2022-12-17        2023-05-17                       145
       5 C2_20230517      2022-12-16        2023-05-17                       151
       6 C3_20230517      2022-11-28        2023-05-17                       166
       7 C4_20230517      2022-12-17        2023-05-17                       147
       8 D2_20230517      2022-11-28        2023-05-17                       164
       9 D3_20230517      2022-11-28        2023-05-17                       161
      10 D5_20230517      2022-12-16        2023-05-17                       152
      # i 3 more variables: species <chr>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, by_deployment_label = FALSE, by_species = FALSE)
    Output
      # A tibble: 1 x 5
        sample_start_date sample_end_date sample_period_length total_count   rai
        <date>            <date>                         <int>       <dbl> <dbl>
      1 2022-11-28        2023-05-17                       166         300  1.81

---

    Code
      sample_rai(imgs1, by_deployment_label = FALSE)
    Output
      # A tibble: 7 x 6
        sample_start_date sample_end_date sample_period_length species     total_count
        <date>            <date>                         <int> <chr>             <dbl>
      1 2022-11-28        2023-05-17                       164 Avian (com~           1
      2 2022-12-16        2023-05-17                       153 Beaver                1
      3 2022-12-16        2023-05-17                       152 Black Bear            2
      4 2022-12-16        2023-05-17                       151 Domestic (~           3
      5 2022-11-28        2023-05-17                       166 Mule Deer            92
      6 2022-11-28        2023-05-17                       166 Roosevelt ~         200
      7 2022-11-28        2023-05-17                       160 Unknown               1
      # i 1 more variable: rai <dbl>

---

    Code
      sample_rai(imgs1, by_species = FALSE)
    Output
      # A tibble: 11 x 6
         deployment_label sample_start_date sample_end_date sample_period_length
         <chr>            <date>            <date>                         <int>
       1 A4_20230517      2022-12-16        2023-05-17                       153
       2 B3_20220517      2022-11-28        2023-05-17                       160
       3 B4_20230517      2022-12-16        2023-05-17                       143
       4 C1_20230517      2022-12-17        2023-05-17                       145
       5 C2_20230517      2022-12-16        2023-05-17                       151
       6 C3_20230517      2022-11-28        2023-05-17                       166
       7 C4_20230517      2022-12-17        2023-05-17                       147
       8 C5_20230517      2022-12-16        2023-05-17                       145
       9 D2_20230517      2022-11-28        2023-05-17                       164
      10 D3_20230517      2022-11-28        2023-05-17                       161
      11 D5_20230517      2022-12-16        2023-05-17                       152
      # i 2 more variables: total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs1, sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 15 x 7
         deployment_label sample_start_date sample_end_date sample_period_length
         <chr>            <date>            <date>                         <int>
       1 A4_20230517      2022-12-16        2023-02-05                        52
       2 A4_20230517      2022-12-16        2023-02-05                        52
       3 B3_20220517      2022-12-16        2023-02-05                        48
       4 B3_20220517      2022-12-16        2023-02-05                        48
       5 B4_20230517      2022-12-16        2023-02-05                        48
       6 C1_20230517      2022-12-17        2023-02-05                        48
       7 C1_20230517      2022-12-17        2023-02-05                        48
       8 C2_20230517      2022-12-16        2023-02-05                        50
       9 C3_20230517      2022-12-16        2023-02-05                        52
      10 C4_20230517      2022-12-17        2023-02-05                        48
      11 D2_20230517      2022-12-16        2023-02-05                        49
      12 D2_20230517      2022-12-16        2023-02-05                        49
      13 D3_20230517      2022-12-16        2023-02-05                        48
      14 D3_20230517      2022-12-16        2023-02-05                        48
      15 D5_20230517      2022-12-16        2023-02-05                        52
      # i 3 more variables: species <chr>, total_count <dbl>, rai <dbl>

---

    Code
      sample_rai(imgs2, deployment_label = "19_1_20230605", species = "Roosevelt Elk",
        sample_start_date = "2022-12-16", sample_end_date = "2023-02-05")
    Output
      # A tibble: 1 x 7
        deployment_label sample_start_date sample_end_date sample_period_length
        <chr>            <date>            <date>                         <int>
      1 19_1_20230605    2022-12-16        2023-02-05                        52
      # i 3 more variables: species <chr>, total_count <dbl>, rai <dbl>

