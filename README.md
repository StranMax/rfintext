
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
  dplyr::count(LEMMA, UPOSTAG, sort = TRUE) |>
  print(n = 50)
#> # A tibble: 20,691 × 3
#>    LEMMA              UPOSTAG     n
#>    <chr>              <chr>   <int>
#>  1 kaupunki           NOUN     4112
#>  2 asunto             NOUN     3873
#>  3 vuosi              NOUN     3718
#>  4 asuminen           NOUN     3161
#>  5 alue               NOUN     2991
#>  6 kunta              NOUN     2759
#>  7 myös               ADV      2053
#>  8 tavoite            NOUN     1969
#>  9 uusi               ADJ      1588
#> 10 olla               VERB     1536
#> 11 osa                NOUN     1503
#> 12 tulla              VERB     1422
#> 13 palvelu            NOUN     1288
#> 14 ohjelma            NOUN     1268
#> 15 asukas             NOUN     1267
#> 16 tontti             NOUN     1238
#> 17 rakentaminen       NOUN     1140
#> 18 määrä              NOUN     1111
#> 19 noin               ADV      1111
#> 20 asunto#tuotanto    NOUN      961
#> 21 tarve              NOUN      954
#> 22 suuri              ADJ       918
#> 23 asua               VERB      879
#> 24 asunto#poliittinen ADJ       851
#> 25 henkilö            NOUN      833
#> 26 vuokra#asunto      NOUN      831
#> 27 tukea              VERB      801
#> 28 hyvä               ADJ       767
#> 29 kehittäminen       NOUN      756
#> 30 väestö             NOUN      746
#> 31 seutu              NOUN      737
#> 32 oma                ADJ       722
#> 33 keskusta           NOUN      710
#> 34 kasvaa             VERB      692
#> 35 rakentaa           VERB      683
#> 36 kasvu              NOUN      677
#> 37 aika               NOUN      674
#> 38 maa                NOUN      673
#> 39 edistää            VERB      667
#> 40 eri                ADJ       666
#> 41 tehdä              VERB      664
#> 42 toimen#pide        NOUN      662
#> 43 saada              VERB      660
#> 44 asunto#kunta       NOUN      649
#> 45 asuin#alue         NOUN      641
#> 46 oy                 NOUN      634
#> 47 vastata            VERB      628
#> 48 osuus              NOUN      620
#> 49 maan#käyttö        NOUN      607
#> 50 tarvita            VERB      596
#> # ℹ 20,641 more rows
```

``` r
aspol |>
  group_by(LEMMA) |>
  summarise(taivutusmuodot = length(unique(FORM))) |>
  arrange(desc(taivutusmuodot))
#> # A tibble: 35,454 × 2
#>    LEMMA    taivutusmuodot
#>    <chr>             <int>
#>  1 suuri                83
#>  2 olla                 82
#>  3 asunto               74
#>  4 tehdä                72
#>  5 hyvä                 71
#>  6 saada                70
#>  7 tavoite              69
#>  8 rakentaa             67
#>  9 tämä                 63
#> 10 tukea                62
#> # ℹ 35,444 more rows
```

``` r
aspol |>
  filter(LEMMA == "suuri") |>
  count(FORM, sort = TRUE) |>
  print(n = 50)
#> # A tibble: 83 × 2
#>    FORM              n
#>    <chr>         <int>
#>  1 "suuri"         136
#>  2 "suurin"        129
#>  3 "suurempi"       78
#>  4 "Suurin"         55
#>  5 "suuria"         53
#>  6 "suurempia"      32
#>  7 "suurten"        32
#>  8 "suurta"         31
#>  9 "suuret"         30
#> 10 "suurempien"     20
#> 11 "suuren"         20
#> 12 "suurelta"       16
#> 13 "suurempaa"      16
#> 14 "suurimmat"      16
#> 15 "suurimman"      15
#> 16 "Suuri"          13
#> 17 "Suurimmat"      13
#> 18 "suuremman"       9
#> 19 "suuremmat"       9
#> 20 "suuriin"         9
#> 21 "suureksi"        8
#> 22 "suurinta"        8
#> 23 "suurissa"        8
#> 24 "suurempaan"      7
#> 25 "suurimpana"      7
#> 26 "Suurimmassa"     6
#> 27 "suurimmaksi"     6
#> 28 "suurimmista"     6
#> 29 "suurista"        6
#> 30 "suurimmassa"     5
#> 31 "suurimpien"      5
#> 32 "suurimpiin"      5
#> 33 "\fSuurin"        4
#> 34 "Suuren"          4
#> 35 "Suuria"          4
#> 36 "Suurten"         4
#> 37 "suurella"        4
#> 38 "suuremmaksi"     4
#> 39 "suuremmissa"     4
#> 40 "Suuremmissa"     3
#> 41 "Suurempi"        3
#> 42 "Suurempien"      3
#> 43 "suureen"         3
#> 44 "suuremmasta"     3
#> 45 "suuressa"        3
#> 46 "suuresta"        3
#> 47 "suurien"         3
#> 48 "suurilla"        3
#> 49 "suurille"        3
#> 50 "suurilta"        3
#> # ℹ 33 more rows
```
