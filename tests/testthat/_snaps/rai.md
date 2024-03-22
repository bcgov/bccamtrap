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
      sample_rai(imgs1, by_deployment_label = FALSE, by_species = FALSE)
    Output
      # A tibble: 1 x 5
        sample_start_date sample_end_date trap_days total_count   rai
        <date>            <date>              <int>       <dbl> <dbl>
      1 2022-11-28        2023-05-17            166         300  1.81

---

    Code
      sample_rai(imgs1, by_deployment_label = FALSE)
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

