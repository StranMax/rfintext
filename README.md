
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfintext

<!-- badges: start -->
<!-- badges: end -->

This package contains data set `aspol` created from Finnish housing
policy documents.

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

Number of documents currently 68

``` r
aspol
#> # A tibble: 451,660 × 13
#>    kunta   sent ID    FORM  LEMMA UPOSTAG XPOSTAG FEATS HEAD  DEPREL DEPS  MISC 
#>    <chr>  <int> <chr> <chr> <chr> <chr>   <chr>   <chr> <chr> <chr>  <chr> <chr>
#>  1 Enont…     1 1     ﻿Khall ﻿Khall PROPN   _       Case… 0     root   _     "_"  
#>  2 Enont…     1 2     19.4… 19.4… NUM     _       _     1     nmod   _     "_"  
#>  3 Enont…     1 3     $     $     PUNCT   _       _     4     punct  _     "_"  
#>  4 Enont…     1 4     126   126   NUM     _       NumT… 1     nummod _     "Spa…
#>  5 Enont…     2 1     (     (     PUNCT   _       _     2     punct  _     "Spa…
#>  6 Enont…     2 2     N     N     NOUN    _       Abbr… 0     root   _     "Spa…
#>  7 Enont…     3 1     Enon… Enon… PROPN   _       Case… 0     root   _     "Spa…
#>  8 Enont…     4 1     KUNTA kunta NOUN    _       Case… 0     root   _     "Spa…
#>  9 Enont…     5 1     VUOK… vuok… NOUN    _       Case… 2     nmod:… _     "Spa…
#> 10 Enont…     5 2     KEHI… kehi… NOUN    _       Case… 0     root   _     "Spa…
#> # ℹ 451,650 more rows
#> # ℹ 1 more variable: doc <chr>
```

``` r
aspol |>
  dplyr::filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ", "ADV")) |>
  dplyr::count(LEMMA, UPOSTAG, sort = TRUE)
#> # A tibble: 20,180 × 3
#>    LEMMA    UPOSTAG     n
#>    <chr>    <chr>   <int>
#>  1 kaupunki NOUN     4081
#>  2 asunto   NOUN     3954
#>  3 vuosi    NOUN     3683
#>  4 asuminen NOUN     3080
#>  5 alue     NOUN     2888
#>  6 kunta    NOUN     2601
#>  7 myös     ADV      1945
#>  8 tavoite  NOUN     1911
#>  9 uusi     ADJ      1504
#> 10 olla     VERB     1491
#> # ℹ 20,170 more rows
```

``` r
aspol |>
  group_by(LEMMA) |>
  summarise(taivutusmuodot = length(unique(FORM))) |>
  arrange(desc(taivutusmuodot))
#> # A tibble: 34,935 × 2
#>    LEMMA    taivutusmuodot
#>    <chr>             <int>
#>  1 olla                 85
#>  2 suuri                78
#>  3 asunto               74
#>  4 tehdä                72
#>  5 saada                70
#>  6 hyvä                 68
#>  7 rakentaa             65
#>  8 tämä                 64
#>  9 se                   63
#> 10 tavoite              61
#> # ℹ 34,925 more rows
```

``` r
aspol |>
  filter(LEMMA == "suuri") |>
  count(FORM, sort = TRUE)
#> # A tibble: 78 × 2
#>    FORM           n
#>    <chr>      <int>
#>  1 suuri        132
#>  2 suurin       128
#>  3 suurempi      79
#>  4 Suurin        55
#>  5 suuria        49
#>  6 suurempia     31
#>  7 suurten       30
#>  8 suurta        29
#>  9 suuret        26
#> 10 suurempien    20
#> # ℹ 68 more rows
```
