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

pdf_dir <- "C:/Users/maxs/Documents/data/kuntastrategiat_kopio"
txt_file <-"C:/Users/maxs/Documents/data/kuntastrategiat_kopio/kuntastrategiat2.conllu"

strategia <- CoNLLUTextDocument(txt_file) |>
  content() |>
  as_tibble()

kunnat <- list.files(pdf_dir, pattern = ".pdf$", full.names = FALSE)

# Beginning of every doc coded by text "Tästä alkaa dokumentti file_name.pdf."
# Looks ugly as hell but for now on it will suffice
strategia$kunta[strategia$FORM=="Tästä" & strategia$ID==1] <- kunnat

strategia <- strategia |> fill(kunta)

strategia <- strategia |> select(kunta, everything()) |> filter(!is.na(kunta))

# Removing document boundary coding
to_drop <- strategia |> filter(
  (ID==1 & FORM == "Tästä") | (ID==2 & FORM=="alkaa") |
    (ID==3 & FORM=="dokumentti") | (ID==4 & FORM==paste0(kunta, "."))
  )

strategia <- strategia |> anti_join(to_drop)

usethis::use_data(strategia, overwrite = TRUE)
