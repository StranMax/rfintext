## code to prepare `strategia` dataset goes here
pkgs <- c(
  "NLP",
  "usethis",
  "dplyr",
  "tidyr",
  "stringr"
)
uninst <- pkgs[!pkgs %in% installed.packages()]
if (length(uninst) > 0) {install.packages(uninst)}
lapply(pkgs, library, character.only =TRUE)

# Path to somewhere on local machine with all the lemmatized files
txt_dir <- "C:/Users/maxs/Documents/data/kuntastrategiat_kopio"

txt_files <- list.files(txt_dir, pattern = "\\.conllu$", full.names = TRUE)

doc_list <- lapply(txt_files, NLP::CoNLLUTextDocument)

names(doc_list) <- basename(txt_files)  # List names make up the row names

data_list <- lapply(doc_list, NLP::content)

strategia <- do.call("rbind", data_list)

# Row names have incremental number added to them
strategia <- cbind(doc = gsub("\\.\\d+$", "", rownames(strategia)), strategia)

# Column is prettier than row name
rownames(strategia) <- NULL

strategia <- strategia |>
  tidyr::as_tibble() |>
  mutate(kunta = str_trim(str_to_title(str_replace_all(str_extract(doc, "[A-Äa-ö_-]+"), "_", " ")))) |>
  select(kunta, sent:MISC, doc)  # kunta first, doc last


usethis::use_data(strategia, overwrite = TRUE)
