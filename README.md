
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

Number of documents currently 66

``` r
aspol
#> # A tibble: 468,205 × 13
#>    kunta   sent ID    FORM  LEMMA UPOSTAG XPOSTAG FEATS HEAD  DEPREL DEPS  MISC 
#>    <chr>  <int> <chr> <chr> <chr> <chr>   <chr>   <chr> <chr> <chr>  <chr> <chr>
#>  1 Enont…     1 1     Khall Khall PROPN   _       Case… 0     root   _     "_"  
#>  2 Enont…     1 2     19.4… 19.4… NUM     _       _     1     nmod   _     "_"  
#>  3 Enont…     1 3     $     $     PUNCT   _       _     4     punct  _     "_"  
#>  4 Enont…     1 4     126   126   NUM     _       NumT… 1     nummod _     "Spa…
#>  5 Enont…     2 1     (     (     PUNCT   _       _     2     punct  _     "Spa…
#>  6 Enont…     2 2     N     N     NOUN    _       Abbr… 0     root   _     "Spa…
#>  7 Enont…     3 1     Enon… Enon… PROPN   _       Case… 0     root   _     "Spa…
#>  8 Enont…     4 1     KUNTA kunta NOUN    _       Case… 0     root   _     "Spa…
#>  9 Enont…     5 1     VUOK… vuok… NOUN    _       Case… 2     nmod:… _     "Spa…
#> 10 Enont…     5 2     KEHI… kehi… NOUN    _       Case… 0     root   _     "Spa…
#> # ℹ 468,195 more rows
#> # ℹ 1 more variable: doc <chr>
```

``` r
sanalista |> print(n=50)
#> # A tibble: 104,336 × 4
#>    Hakusana         Homonymia Sanaluokka Taivutustiedot
#>    <chr>                <dbl> <chr>      <chr>         
#>  1 3D-tulostin             NA S          <NA>          
#>  2 3D-tulostus             NA S          <NA>          
#>  3 4H-kerho                NA S          <NA>          
#>  4 4H-kerholainen          NA S          <NA>          
#>  5 4H-neuvoja              NA S          <NA>          
#>  6 4H-toiminta             NA S          <NA>          
#>  7 aah                     NA P          99            
#>  8 aakkonen                NA S          38            
#>  9 aakkosellinen           NA A          38            
#> 10 aakkosellisesti         NA P          99            
#> 11 aakkosellisuus          NA S          40            
#> 12 aakkosittain            NA P          99            
#> 13 aakkosjärjestys         NA S          <NA>          
#> 14 aakkosnimi              NA S          <NA>          
#> 15 aakkosnumeerinen        NA A          <NA>          
#> 16 aakkostaa               NA V          53            
#> 17 aakkosto                NA S          2             
#> 18 aakkostus               NA S          39            
#> 19 aalloittain             NA P          99            
#> 20 aalloittainen           NA A          38            
#> 21 aalloittaisuus          NA S          40            
#> 22 aallokas                NA A          41*A          
#> 23 aallokko                NA S          4*A           
#> 24 aallonharja             NA S          <NA>          
#> 25 aallonmurtaja           NA S          <NA>          
#> 26 aallonpituus            NA S          <NA>          
#> 27 aallonpohja             NA S          <NA>          
#> 28 aallota                 NA V          75*I          
#> 29 aallotar                NA S          32*C          
#> 30 aallottaa               NA V          53*C          
#> 31 aallotus                NA S          39            
#> 32 aaloe                   NA S          3             
#> 33 aalto                   NA S          1*I           
#> 34 aaltoallas              NA S          <NA>          
#> 35 aaltoalue               NA S          <NA>          
#> 36 aaltoenergia            NA S          <NA>          
#> 37 aaltoilla               NA V          67            
#> 38 aaltoilu                NA S          2             
#> 39 aaltoiluhäiriö          NA S          <NA>          
#> 40 -aaltoinen              NA A          38            
#> 41 aaltolevy               NA S          <NA>          
#> 42 aaltoliike              NA S          <NA>          
#> 43 aaltomainen             NA A          38            
#> 44 aaltomaisesti           NA P          99            
#> 45 aaltopahvi              NA S          <NA>          
#> 46 aaltopelti              NA S          <NA>          
#> 47 aaltopituus             NA S          <NA>          
#> 48 aaltosulje              NA S          <NA>          
#> 49 aaltosulku              NA S          <NA>          
#> 50 aaltosulkumerkki        NA S          <NA>          
#> # ℹ 104,286 more rows
```

``` r
aspol |>
  dplyr::filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ", "ADV")) |>
  dplyr::count(LEMMA, UPOSTAG, XPOSTAG, sort = TRUE) |>
  print(n = 50)
#> # A tibble: 20,691 × 4
#>    LEMMA              UPOSTAG XPOSTAG     n
#>    <chr>              <chr>   <chr>   <int>
#>  1 kaupunki           NOUN    _        4112
#>  2 asunto             NOUN    _        3873
#>  3 vuosi              NOUN    _        3718
#>  4 asuminen           NOUN    _        3161
#>  5 alue               NOUN    _        2991
#>  6 kunta              NOUN    _        2759
#>  7 myös               ADV     _        2053
#>  8 tavoite            NOUN    _        1969
#>  9 uusi               ADJ     _        1588
#> 10 olla               VERB    _        1536
#> 11 osa                NOUN    _        1503
#> 12 tulla              VERB    _        1422
#> 13 palvelu            NOUN    _        1288
#> 14 ohjelma            NOUN    _        1268
#> 15 asukas             NOUN    _        1267
#> 16 tontti             NOUN    _        1238
#> 17 rakentaminen       NOUN    _        1140
#> 18 määrä              NOUN    _        1111
#> 19 noin               ADV     _        1111
#> 20 asunto#tuotanto    NOUN    _         961
#> 21 tarve              NOUN    _         954
#> 22 suuri              ADJ     _         918
#> 23 asua               VERB    _         879
#> 24 asunto#poliittinen ADJ     _         851
#> 25 henkilö            NOUN    _         833
#> 26 vuokra#asunto      NOUN    _         831
#> 27 tukea              VERB    _         801
#> 28 hyvä               ADJ     _         767
#> 29 kehittäminen       NOUN    _         756
#> 30 väestö             NOUN    _         746
#> 31 seutu              NOUN    _         737
#> 32 oma                ADJ     _         722
#> 33 keskusta           NOUN    _         710
#> 34 kasvaa             VERB    _         692
#> 35 rakentaa           VERB    _         683
#> 36 kasvu              NOUN    _         677
#> 37 aika               NOUN    _         674
#> 38 maa                NOUN    _         673
#> 39 edistää            VERB    _         667
#> 40 eri                ADJ     _         666
#> 41 tehdä              VERB    _         664
#> 42 toimen#pide        NOUN    _         662
#> 43 saada              VERB    _         660
#> 44 asunto#kunta       NOUN    _         649
#> 45 asuin#alue         NOUN    _         641
#> 46 oy                 NOUN    _         634
#> 47 vastata            VERB    _         628
#> 48 osuus              NOUN    _         620
#> 49 maan#käyttö        NOUN    _         607
#> 50 tarvita            VERB    _         596
#> # ℹ 20,641 more rows
```
