
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfintext

<!-- badges: start -->
<!-- badges: end -->

This package contains analysis ready data set `aspol` created from
Finnish housing policy documents.

## Installation

You can install the development version of rfintext like so:

``` r
# install.packages("devtools")
devtools::install_github("StranMax/rfintext")
```

``` r
library(rfintext)
```

``` r
head(aspol)
#>       kunta sent ID                  FORM                  LEMMA UPOSTAG
#> 1 Enontekiö    1  1            ENONTEKIÖN              ENonTEKiÖ   PROPN
#> 2 Enontekiö    1  2                 KUNTA                  kunta    NOUN
#> 3 Enontekiö    1  3       VUOKRA-ASUMISEN        vuokra#Asuminen    NOUN
#> 4 Enontekiö    1  4 KEHITTÄMISSUUNNITELMA kehittämis#suunnitelma    NOUN
#> 5 Enontekiö    1  5             2017-2025              2017-2025     NUM
#> 6 Enontekiö    2  1                    EN                     ei     AUX
#>   XPOSTAG                                                    FEATS HEAD
#> 1       N                                     Case=Gen|Number=Sing    2
#> 2       N                                     Case=Nom|Number=Sing    4
#> 3       N                    Case=Gen|Derivation=Minen|Number=Sing    4
#> 4       N                                     Case=Nom|Number=Sing    0
#> 5     Num                                             NumType=Card    4
#> 6       V Number=Sing|Person=1|Polarity=Neg|VerbForm=Fin|Voice=Act    2
#>      DEPREL DEPS                     MISC
#> 1 nmod:poss    _                        _
#> 2 nsubj:cop    _       SpacesAfter=\\r\\n
#> 3 nmod:poss    _       SpacesAfter=\\r\\n
#> 4      root    _       SpacesAfter=\\r\\n
#> 5    nummod    _ SpacesAfter=\\r\\n\\r\\n
#> 6       aux    _                        _
```
