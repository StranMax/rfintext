
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfintext

<!-- badges: start -->
<!-- badges: end -->

Main purpose for this package is:  
\* To share text mining data sets easily.  
\* Provide a few simple pre processing functions. Nothing special only
wrappers around dplyr functionality.  
\* Document all the work done.

This package contains data set `aspol` created from Finnish housing
policy documents. Other data sets might be added later. Currently all
the functionalities are tested with aspol data set only.

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

Example from dataset, sentence nro 43 from Espoo document:

``` r
aspol |> filter(kunta == "Espoo", sent == 43)
#> # A tibble: 26 × 13
#>    kunta  sent ID    FORM                  LEMMA                 UPOSTAG XPOSTAG FEATS                                                                  HEAD  DEPREL    DEPS  MISC                 doc              
#>    <chr> <int> <chr> <chr>                 <chr>                 <chr>   <chr>   <chr>                                                                  <chr> <chr>     <chr> <chr>                <chr>            
#>  1 Espoo    43 1     Asumisen              asuminen              NOUN    _       Case=Gen|Derivation=Minen|Number=Sing                                  4     nmod:poss _     "_"                  espoo_2023.conllu
#>  2 Espoo    43 2     ja                    ja                    CCONJ   _       _                                                                      3     cc        _     "_"                  espoo_2023.conllu
#>  3 Espoo    43 3     maankäytön            maan#käyttö           NOUN    _       Case=Gen|Number=Sing                                                   1     conj      _     "_"                  espoo_2023.conllu
#>  4 Espoo    43 4     periaatteiden         periaate              NOUN    _       Case=Gen|Number=Plur                                                   5     nmod:gobj _     "_"                  espoo_2023.conllu
#>  5 Espoo    43 5     laadinnassa           laadinta              NOUN    _       Case=Ine|Number=Sing                                                   6     nmod      _     "_"                  espoo_2023.conllu
#>  6 Espoo    43 6     tärkeimpiä            tärkeä                ADJ     _       Case=Par|Degree=Sup|Number=Plur                                        8     amod      _     "SpacesAfter=\\r\\n" espoo_2023.conllu
#>  7 Espoo    43 7     ratkaistavia          ratkaista             VERB    _       Case=Par|Degree=Pos|Number=Plur|PartForm=Pres|VerbForm=Part|Voice=Pass 8     acl       _     "_"                  espoo_2023.conllu
#>  8 Espoo    43 8     asioita               asia                  NOUN    _       Case=Par|Number=Plur                                                   12    nsubj:cop _     "_"                  espoo_2023.conllu
#>  9 Espoo    43 9     ovat                  olla                  AUX     _       Mood=Ind|Number=Plur|Person=3|Tense=Pres|VerbForm=Fin|Voice=Act        12    aux       _     "_"                  espoo_2023.conllu
#> 10 Espoo    43 10    olleet                olla                  AUX     _       Case=Nom|Degree=Pos|Number=Plur|PartForm=Past|VerbForm=Part|Voice=Act  12    cop       _     "_"                  espoo_2023.conllu
#> 11 Espoo    43 11    asuntotuotannon       asunto#tuotanto       NOUN    _       Case=Gen|Number=Sing                                                   12    nmod:poss _     "_"                  espoo_2023.conllu
#> 12 Espoo    43 12    monipuolisuuteen      monipuolisuus         NOUN    _       Case=Ill|Derivation=Inen,Vs|Number=Sing                                0     root      _     "SpaceAfter=No"      espoo_2023.conllu
#> 13 Espoo    43 13    ,                     ,                     PUNCT   _       _                                                                      14    punct     _     "SpacesAfter=\\r\\n" espoo_2023.conllu
#> 14 Espoo    43 14    maanhankintaan        maan#hankinta         NOUN    _       Case=Ill|Number=Sing                                                   12    conj      _     "SpaceAfter=No"      espoo_2023.conllu
#> 15 Espoo    43 15    ,                     ,                     PUNCT   _       _                                                                      17    punct     _     "_"                  espoo_2023.conllu
#> 16 Espoo    43 16    tasaiseen             tasainen              ADJ     _       Case=Ill|Degree=Pos|Derivation=Inen|Number=Sing                        17    amod      _     "_"                  espoo_2023.conllu
#> 17 Espoo    43 17    vuokratulovirtaan     vuokra#tulo#virta     NOUN    _       Case=Ill|Number=Sing                                                   12    conj      _     "_"                  espoo_2023.conllu
#> 18 Espoo    43 18    sekä                  sekä                  CCONJ   _       _                                                                      20    cc        _     "_"                  espoo_2023.conllu
#> 19 Espoo    43 19    riittävään            riittävä              ADJ     _       Case=Ill|Degree=Pos|Number=Sing                                        20    amod      _     "_"                  espoo_2023.conllu
#> 20 Espoo    43 20    yritystonttivarantoon yritys#tontti#varanto NOUN    _       Case=Ill|Number=Sing                                                   12    conj      _     "_"                  espoo_2023.conllu
#> 21 Espoo    43 21    ja                    ja                    CCONJ   _       _                                                                      23    cc        _     "_"                  espoo_2023.conllu
#> 22 Espoo    43 22    yritystonttien        yritys#tontti         NOUN    _       Case=Gen|Number=Plur                                                   23    nmod:gobj _     "_"                  espoo_2023.conllu
#> 23 Espoo    43 23    luovutukseen          luovutus              NOUN    _       Case=Ill|Number=Sing                                                   12    conj      _     "_"                  espoo_2023.conllu
#> 24 Espoo    43 24    liittyvät             liittyä               VERB    _       Case=Nom|Degree=Pos|Number=Plur|PartForm=Pres|VerbForm=Part|Voice=Act  25    acl       _     "_"                  espoo_2023.conllu
#> 25 Espoo    43 25    kysymykset            kysymys               NOUN    _       Case=Nom|Number=Plur                                                   12    conj      _     "SpaceAfter=No"      espoo_2023.conllu
#> 26 Espoo    43 26    .                     .                     PUNCT   _       _                                                                      12    punct     _     "SpacesAfter=\\r\\n" espoo_2023.conllu
```

``` r
aspol |>
  dplyr::filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ", "ADV")) |>
  dplyr::count(LEMMA, UPOSTAG, sort = TRUE)
#> # A tibble: 20,180 × 3
#>    LEMMA           UPOSTAG     n
#>    <chr>           <chr>   <int>
#>  1 kaupunki        NOUN     4081
#>  2 asunto          NOUN     3954
#>  3 vuosi           NOUN     3683
#>  4 asuminen        NOUN     3080
#>  5 alue            NOUN     2888
#>  6 kunta           NOUN     2601
#>  7 myös            ADV      1945
#>  8 tavoite         NOUN     1911
#>  9 uusi            ADJ      1504
#> 10 olla            VERB     1491
#> 11 osa             NOUN     1406
#> 12 tulla           VERB     1306
#> 13 ohjelma         NOUN     1258
#> 14 asukas          NOUN     1252
#> 15 palvelu         NOUN     1236
#> 16 tontti          NOUN     1214
#> 17 rakentaminen    NOUN     1103
#> 18 noin            ADV      1101
#> 19 määrä           NOUN     1092
#> 20 asunto#tuotanto NOUN      921
#> # ℹ 20,160 more rows
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
  filter(LEMMA == "asunto") |>
  count(FORM, FEATS, sort = TRUE)
#> # A tibble: 81 × 3
#>    FORM       FEATS                    n
#>    <chr>      <chr>                <int>
#>  1 asuntojen  Case=Gen|Number=Plur   880
#>  2 asuntoa    Case=Par|Number=Sing   516
#>  3 asuntoja   Case=Par|Number=Plur   472
#>  4 asunnot    Case=Nom|Number=Plur   317
#>  5 asunnon    Case=Gen|Number=Sing   306
#>  6 Asuntojen  Case=Gen|Number=Plur   240
#>  7 asunto-    Case=Nom|Number=Sing   190
#>  8 asunnoista Case=Ela|Number=Plur   171
#>  9 asunto     Case=Nom|Number=Sing   123
#> 10 Asunnot    Case=Nom|Number=Plur    98
#> 11 asunnoissa Case=Ine|Number=Plur    72
#> 12 asuntoihin Case=Ill|Number=Plur    63
#> 13 asuntoon   Case=Ill|Number=Sing    59
#> 14 Asunto-    Case=Nom|Number=Sing    41
#> 15 Asunnon    Case=Gen|Number=Sing    40
#> 16 Asuntoja   Case=Par|Number=Plur    39
#> 17 asunnossa  Case=Ine|Number=Sing    37
#> 18 Asunto     Case=Nom|Number=Sing    30
#> 19 asunnosta  Case=Ela|Number=Sing    26
#> 20 asunnoiksi Case=Tra|Number=Plur    23
#> # ℹ 61 more rows
```

``` r
aspol |>
  group_by(FORM) |>
  summarise(perusmuoto = length(unique(UPOSTAG))) |>
  arrange(desc(perusmuoto))
#> # A tibble: 69,686 × 2
#>    FORM  perusmuoto
#>    <chr>      <int>
#>  1 .              9
#>  2 /              9
#>  3 o              9
#>  4 -              6
#>  5 @              6
#>  6 Yli            6
#>  7 –              6
#>  8 !              5
#>  9 %              5
#> 10 )              5
#> # ℹ 69,676 more rows
```

``` r
aspol |>
  filter(LEMMA == "olla") |>
  count(FORM, LEMMA, UPOSTAG, FEATS, sort = TRUE)
#> # A tibble: 130 × 5
#>    FORM     LEMMA UPOSTAG FEATS                                                                     n
#>    <chr>    <chr> <chr>   <chr>                                                                 <int>
#>  1 on       olla  AUX     Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin|Voice=Act        9847
#>  2 ovat     olla  AUX     Mood=Ind|Number=Plur|Person=3|Tense=Pres|VerbForm=Fin|Voice=Act        1653
#>  3 oli      olla  AUX     Mood=Ind|Number=Sing|Person=3|Tense=Past|VerbForm=Fin|Voice=Act         762
#>  4 ole      olla  AUX     Connegative=Yes|Mood=Ind|Tense=Pres|VerbForm=Fin                        487
#>  5 ollut    olla  AUX     Case=Nom|Degree=Pos|Number=Sing|PartForm=Past|VerbForm=Part|Voice=Act   450
#>  6 olla     olla  AUX     InfForm=1|Number=Sing|VerbForm=Inf|Voice=Act                            447
#>  7 on       olla  AUX     Mood=Ind|Number=Sing|Person=0|Tense=Pres|VerbForm=Fin|Voice=Act         255
#>  8 olemassa olla  VERB    Case=Ine|InfForm=3|Number=Sing|VerbForm=Inf|Voice=Act                   229
#>  9 olevien  olla  VERB    Case=Gen|Degree=Pos|Number=Plur|PartForm=Pres|VerbForm=Part|Voice=Act   172
#> 10 olisi    olla  AUX     Mood=Cnd|Number=Sing|Person=3|VerbForm=Fin|Voice=Act                    148
#> 11 olevat   olla  VERB    Case=Nom|Degree=Pos|Number=Plur|PartForm=Pres|VerbForm=Part|Voice=Act   134
#> 12 olevan   olla  VERB    Case=Gen|Degree=Pos|Number=Sing|PartForm=Pres|VerbForm=Part|Voice=Act   122
#> 13 ole      olla  VERB    Connegative=Yes|Mood=Ind|Tense=Pres|VerbForm=Fin                        119
#> 14 olevia   olla  VERB    Case=Par|Degree=Pos|Number=Plur|PartForm=Pres|VerbForm=Part|Voice=Act   108
#> 15 oleva    olla  VERB    Case=Nom|Degree=Pos|Number=Sing|PartForm=Pres|VerbForm=Part|Voice=Act   100
#> 16 olevaa   olla  VERB    Case=Par|Degree=Pos|Number=Sing|PartForm=Pres|VerbForm=Part|Voice=Act    77
#> 17 olevan   olla  AUX     Case=Gen|Degree=Pos|Number=Sing|PartForm=Pres|VerbForm=Part|Voice=Act    71
#> 18 olivat   olla  AUX     Mood=Ind|Number=Plur|Person=3|Tense=Past|VerbForm=Fin|Voice=Act          71
#> 19 olleet   olla  AUX     Case=Nom|Degree=Pos|Number=Plur|PartForm=Past|VerbForm=Part|Voice=Act    66
#> 20 on       olla  VERB    Mood=Ind|Number=Sing|Person=3|Tense=Pres|VerbForm=Fin|Voice=Act          58
#> # ℹ 110 more rows
```
