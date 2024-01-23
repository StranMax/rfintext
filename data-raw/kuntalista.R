## code to prepare `kuntalista` dataset goes here
pkgs <- c(
  "readr"
)
uninst <- pkgs[!pkgs %in% installed.packages()]
if (length(uninst) > 0) install.packages()
lapply(pkgs, library, charatcer.only = TRUE)

kuntalista <- readr::read_csv2("data-raw/kuntalista.csv")

usethis::use_data(kuntalista, overwrite = TRUE)
