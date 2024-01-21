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

aspol <- tidyr::as_tibble(aspol)
aspol <- aspol |>
  mutate(kunta = str_trim(str_to_title(str_replace_all(str_extract(doc, "[a-ö_-]+"), "_", " "))))
# kunta first, drop doc column
aspol <- aspol |>
  select(kunta, sent:MISC)

usethis::use_data(aspol, overwrite = TRUE)
