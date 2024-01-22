## code to prepare `sanalista` dataset goes here
pkgs <- c(
  "dplyr",
  "readr"
)
uninst <- pkgs[!pkgs %in% installed.packages()]
if(length(uninst) > 0) install.packages()
lapply(pkgs, library, character.only =TRUE)

csv <- "https://kaino.kotus.fi/lataa/nykysuomensanalista2022.csv"

sanalista <- readr::read_delim(csv, delim = "\t")

usethis::use_data(sanalista, overwrite = TRUE)
