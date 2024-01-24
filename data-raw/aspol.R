## code to prepare `aspol` dataset goes here
pkgs <- c(
  "NLP",
  "usethis",
  "dplyr",
  "stringr"
)
uninst <- pkgs[!pkgs %in% installed.packages()]
if (length(uninst) > 0) {install.packages(uninst)}
lapply(pkgs, library, character.only =TRUE)


# Path to somewhere on local machine with all the lemmatized files
txt_dir <- "C:/Users/maxs/Documents/UEF_11-2023/data/muokattu/aspoliittiset_lemm"

txt_files <- list.files(txt_dir, pattern = "_lemm\\.txt$", full.names = TRUE)

doc_list <- lapply(txt_files, NLP::CoNLLUTextDocument)

names(doc_list) <- basename(txt_files)  # List names make up the row names

data_list <- lapply(doc_list, NLP::content)

aspol <- do.call("rbind", data_list)

# Row names have incremental number added to them
aspol <- cbind(doc = gsub("\\.\\d+$", "", rownames(aspol)), aspol)

# Column is prettier than row name
rownames(aspol) <- NULL

aspol <- aspol |>
  tidyr::as_tibble() |>
  mutate(kunta = str_trim(str_to_title(str_replace_all(str_extract(doc, "[a-ö_-]+"), "_", " ")))) |>
  select(kunta, sent:MISC, doc)  # kunta first, doc last

load("data/sanalista.rda")

aspol <-  aspol |>
  dplyr::mutate(sanalistassa = str_detect(str_to_lower(LEMMA), str_c(sanalista$Hakusana, collapse = "|")))

# TODO: Deal with shared programs
yhteiset_ohjelmat <- tribble(
  ~kunta, ~seutu,
  "Alavus", "K",
  "Aura", "Turun Seutu",
  "Harjavalta", "Porin Seutukunta",
  "Ilmajoki", "K",
  "Kaarina", "Turun Seutu",
  "Kangasala", "Tampereen Seutu",
  "Kuortane", "K",
  "Kurikka", "K",
  "Lapua", "K",
  "Lempäälä", "Tampereen Seutu",
  "Lieto", "Turun Seutu",
  "Masku", "Turun Seutu",
  "Mynämäki", "Turun Seutu",
  "Naantali", "Turun Seutu",
  "Nakkila", "Porin Seutukunta",
  "Nokia", "Tampereen Seutu",
  "Nousiainen", "Turun Seutu",
  "Orivesi", "Tampereen Seutu",
  "Paimio", "Turun Seutu",
  "Parainen", "Turun Seutu",
  "Pirkkala", "Tampereen Seutu",
  "Pomarkku", "Porin Seutukunta",
  "Pori", "Porin Seutukunta",
  "Raisio", "Turun Seutu",
  "Rusko", "Turun Seutu",
  "Sauvo", "Turun Seutu",
  "Seinäjoki", "K",
  "Tampere", "Tampereen Seutu",
  "Turku", "Turun Seutu",
  "Ulvila", "Porin Seutukunta",
  "Vesilahti", "Tampereen Seutu",
  "Ylöjärvi", "Tampereen Seutu"
)
# aspol |> distinct(kunta) |> left_join(yhteiset_ohjelmat, by = join_by("kunta" == "seutu")) |> print(n=60)

# Large, over 30Mb file
# aspol |>
#   filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ", "ADV"),
#          sanalistassa,
#          !str_detect(LEMMA, "x|\\.")) |>
#   readr::write_csv2("data-raw/aspol.csv")

usethis::use_data(aspol, overwrite = TRUE)
