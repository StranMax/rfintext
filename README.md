
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
#> # A tibble: 479,457 × 14
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
#> # ℹ 2 more variables: doc <chr>, sanalistassa <lgl>
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
  dplyr::filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ", "ADV"), sanalistassa == FALSE) |>
  dplyr::count(LEMMA, UPOSTAG, XPOSTAG, sort = TRUE) |>
  print(n = 50)
#> # A tibble: 1,746 × 4
#>    LEMMA                                                UPOSTAG XPOSTAG     n
#>    <chr>                                                <chr>   <chr>   <int>
#>  1 "§"                                                  NOUN    N         776
#>  2 "kpl"                                                NOUN    N         356
#>  3 "mm."                                                ADV     Adv       287
#>  4 "1."                                                 ADJ     Num       212
#>  5 "esim."                                              ADV     Adv       210
#>  6 "3."                                                 ADJ     Num       186
#>  7 "2."                                                 ADJ     Num       171
#>  8 "N"                                                  NOUN    N         168
#>  9 "4."                                                 ADJ     Num       141
#> 10 "ta"                                                 NOUN    N         139
#> 11 "n."                                                 ADV     Adv       117
#> 12 "A"                                                  NOUN    N         103
#> 13 "5."                                                 ADJ     Num       100
#> 14 "✓"                                                  NOUN    N          98
#> 15 "m"                                                  NOUN    N          97
#> 16 "ara"                                                NOUN    N          77
#> 17 "T"                                                  NOUN    N          76
#> 18 "a"                                                  NOUN    N          76
#> 19 "k#m2"                                               NOUN    N          74
#> 20 "I"                                                  ADJ     Num        73
#> 21 "%"                                                  NOUN    N          69
#> 22 "ra"                                                 NOUN    N          63
#> 23 "M"                                                  NOUN    N          59
#> 24 "PL"                                                 NOUN    N          59
#> 25 "si"                                                 NOUN    N          59
#> 26 "x"                                                  NOUN    N          56
#> 27 "E"                                                  NOUN    N          55
#> 28 "6."                                                 ADJ     Num        53
#> 29 "7."                                                 ADJ     Num        49
#> 30 "kpl."                                               NOUN    N          49
#> 31 "W"                                                  NOUN    N          47
#> 32 "ns."                                                ADJ     A          47
#> 33 "ollen"                                              ADV     Adv        47
#> 34 "n"                                                  NOUN    N          46
#> 35 "\uf0b7"                                             NOUN    N          45
#> 36 "i"                                                  ADJ     Num        44
#> 37 "yh"                                                 NOUN    N          43
#> 38 "B"                                                  NOUN    N          42
#> 39 "e"                                                  NOUN    N          41
#> 40 "tarvittava"                                         ADJ     A          41
#> 41 "II"                                                 ADJ     Num        40
#> 42 "tar"                                                NOUN    N          39
#> 43 "U"                                                  NOUN    N          38
#> 44 "Y"                                                  NOUN    N          38
#> 45 "tus"                                                NOUN    N          38
#> 46 ".................................................." NOUN    Num        36
#> 47 "kes"                                                NOUN    N          36
#> 48 "km"                                                 NOUN    N          35
#> 49 "......................."                            NOUN    Num        31
#> 50 "D"                                                  NOUN    N          31
#> # ℹ 1,696 more rows
```

``` r
aspol |>
  dplyr::filter(sanalistassa,
                UPOSTAG %in% c("NOUN", "ADJ", "VERB", "ADV")) |>
  dplyr::count(LEMMA, UPOSTAG, XPOSTAG, sort = TRUE) |>
  print(n = 50)
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
