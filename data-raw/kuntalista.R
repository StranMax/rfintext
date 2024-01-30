## code to prepare `kuntalista` dataset goes here
pkgs <- c(
  "readr"
)
uninst <- pkgs[!pkgs %in% installed.packages()]
if (length(uninst) > 0) install.packages()
lapply(pkgs, library, character.only = TRUE)

kuntalista <- readr::read_csv2("data-raw/kuntalista.csv")

kuntalista$`Asuntopoliittinen ohjelma`[kuntalista$`Asuntopoliittinen ohjelma` %in% c("Vanha ohjelma", "Ei voimassa")] <- "Ohjelma laadittu"
kuntalista$`Asuntopoliittinen ohjelma`[kuntalista$`Asuntopoliittinen ohjelma` == "Kyllä"] <- "Ohjelma laadittu"
kuntalista$`Asuntopoliittinen ohjelma`[is.na(kuntalista$`Asuntopoliittinen ohjelma`)] <- "Ei vastausta"
kuntalista$`Asuntopoliittinen ohjelma`[kuntalista$`Asuntopoliittinen ohjelma` == "Yhteinen"] <- "Seutukuntaohjelma"
kuntalista$`Asuntopoliittinen ohjelma`[kuntalista$`Asuntopoliittinen ohjelma` == "Ei"] <- "Ei ohjelmaa"

kuntalista$Kunta[kuntalista$Kunta == "Maarianhamina - Mariehamn"] <- "Maarianhamina"
colnames(kuntalista) <- c("kunta", "aspol")

usethis::use_data(kuntalista, overwrite = TRUE)
