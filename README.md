
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfintext

<!-- badges: start -->
<!-- badges: end -->

This package contains data set `aspol` created from Finnish housing
policy documents.

Additionally package ships with word list from Institute for the
languages of Finland `sanalista`.

## Installation

You can install the development version of rfintext like so:

``` r
# install.packages("devtools")
devtools::install_github("StranMax/rfintext")
```

``` r
library(rfintext)
library(tidyverse)
```

Number of documents currently 65

``` r
aspol
#> # A tibble: 479,457 × 12
#>    kunta   sent ID    FORM  LEMMA UPOSTAG XPOSTAG FEATS HEAD  DEPREL DEPS  MISC 
#>    <chr>  <int> <chr> <chr> <chr> <chr>   <chr>   <chr> <chr> <chr>  <chr> <chr>
#>  1 Enont…     1 1     ENON… ENon… PROPN   N       Case… 2     nmod:… _     "_"  
#>  2 Enont…     1 2     KUNTA kunta NOUN    N       Case… 4     nsubj… _     "Spa…
#>  3 Enont…     1 3     VUOK… vuok… NOUN    N       Case… 4     nmod:… _     "Spa…
#>  4 Enont…     1 4     KEHI… kehi… NOUN    N       Case… 0     root   _     "Spa…
#>  5 Enont…     1 5     2017… 2017… NUM     Num     NumT… 4     nummod _     "Spa…
#>  6 Enont…     2 1     EN    ei    AUX     V       Numb… 2     aux    _     "_"  
#>  7 Enont…     2 2     ONTE… ontea VERB    V       Conn… 0     root   _     "Spa…
#>  8 Enont…     3 1     1     1     NUM     Num     NumT… 0     root   _     "Spa…
#>  9 Enont…     4 1     Sisä… sisä… NOUN    N       Case… 3     compo… _     "Spa…
#> 10 Enont…     4 2     1     1     NUM     Num     NumT… 3     nummod _     "_"  
#> # ℹ 479,447 more rows
```

``` r
sanalista
#> # A tibble: 104,336 × 4
#>    Hakusana        Homonymia Sanaluokka Taivutustiedot
#>    <chr>               <dbl> <chr>      <chr>         
#>  1 3D-tulostin            NA S          <NA>          
#>  2 3D-tulostus            NA S          <NA>          
#>  3 4H-kerho               NA S          <NA>          
#>  4 4H-kerholainen         NA S          <NA>          
#>  5 4H-neuvoja             NA S          <NA>          
#>  6 4H-toiminta            NA S          <NA>          
#>  7 aah                    NA P          99            
#>  8 aakkonen               NA S          38            
#>  9 aakkosellinen          NA A          38            
#> 10 aakkosellisesti        NA P          99            
#> # ℹ 104,326 more rows
```

``` r
aspol <-  aspol |>
  dplyr::mutate(sanalistassa = str_detect(str_to_lower(LEMMA), str_c(sanalista$Hakusana, collapse = "|")))
```

``` r
aspol |>
  dplyr::count(sanalistassa)
#> # A tibble: 2 × 2
#>   sanalistassa      n
#>   <lgl>         <int>
#> 1 FALSE        138956
#> 2 TRUE         340501
```

``` r
aspol |>
  dplyr::filter(sanalistassa == FALSE) |>
  dplyr::count(LEMMA, UPOSTAG, XPOSTAG, sort = TRUE)
#> # A tibble: 14,480 × 4
#>    LEMMA UPOSTAG XPOSTAG     n
#>    <chr> <chr>   <chr>   <int>
#>  1 .     PUNCT   Punct   26866
#>  2 ,     PUNCT   Punct   15789
#>  3 !     PUNCT   Punct    8090
#>  4 )     PUNCT   Punct    4108
#>  5 (     PUNCT   Punct    3399
#>  6 %     SYM     Punct    3061
#>  7 •     PUNCT   Punct    2190
#>  8 :     PUNCT   Punct    1775
#>  9 -     PUNCT   Punct    1740
#> 10 1     NUM     Num      1129
#> # ℹ 14,470 more rows
```

``` r
aspol |>
  dplyr::filter(sanalistassa,
                UPOSTAG %in% c("NOUN", "ADJ", "VERB", "ADV")) |>
  dplyr::count(LEMMA, UPOSTAG, XPOSTAG, sort = TRUE) |>
  print(n=50)
#> # A tibble: 23,790 × 4
#>    LEMMA              UPOSTAG XPOSTAG     n
#>    <chr>              <chr>   <chr>   <int>
#>  1 asunto             NOUN    N        4037
#>  2 kaupunki           NOUN    N        3998
#>  3 vuosi              NOUN    N        3679
#>  4 asuminen           NOUN    N        3139
#>  5 alue               NOUN    N        3017
#>  6 kunta              NOUN    N        2725
#>  7 myös               ADV     Adv      2012
#>  8 tavoite            NOUN    N        1894
#>  9 uusi               ADJ     A        1560
#> 10 osa                NOUN    N        1491
#> 11 tulla              VERB    V        1382
#> 12 olla               VERB    V        1325
#> 13 palvelu            NOUN    N        1272
#> 14 ohjelma            NOUN    N        1251
#> 15 tontti             NOUN    N        1236
#> 16 asukas             NOUN    N        1212
#> 17 määrä              NOUN    N        1116
#> 18 rakentaminen       NOUN    N        1092
#> 19 noin               ADV     Adv       983
#> 20 asunto#tuotanto    NOUN    N         916
#> 21 tarve              NOUN    N         874
#> 22 asua               VERB    V         873
#> 23 suuri              ADJ     A         871
#> 24 asunto#poliittinen ADJ     A         829
#> 25 henkilö            NOUN    N         821
#> 26 vuokra#asunto      NOUN    N         819
#> 27 tukea              VERB    V         755
#> 28 hyvä               ADJ     A         741
#> 29 maa                NOUN    N         734
#> 30 seutu              NOUN    N         734
#> 31 väestö             NOUN    N         730
#> 32 kehittäminen       NOUN    N         717
#> 33 keskusta           NOUN    N         705
#> 34 oma                ADJ     A         701
#> 35 aika               NOUN    N         674
#> 36 tehdä              VERB    V         673
#> 37 kasvu              NOUN    N         659
#> 38 kasvaa             VERB    V         658
#> 39 eri                ADJ     A         657
#> 40 saada              VERB    V         655
#> 41 rakentaa           VERB    V         652
#> 42 edistää            VERB    V         643
#> 43 oy                 NOUN    N         636
#> 44 toimen#pide        NOUN    N         636
#> 45 osuus              NOUN    N         624
#> 46 vastata            VERB    V         610
#> 47 asunto#kunta       NOUN    N         602
#> 48 asuin#alue         NOUN    N         593
#> 49 maan#käyttö        NOUN    N         582
#> 50 tarvita            VERB    V         565
#> # ℹ 23,740 more rows
```
