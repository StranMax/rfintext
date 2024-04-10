## code to prepare `lda_models` dataset goes here

pkgs <- c(
  "tidyverse",
  "tidytext"
  )
lapply(pkgs, library, character.only = TRUE)

### Below is the script which is pre run on cloud computing environment with a lot of computing power
### Here we skip that and read the pre computed and saved rds file

# #!/usr/bin/env Rscript
# # LDA modeling
# # NOTE!
# # if topicmodels installation fails with message:
# # Error: package or namespace load failed for ‘topicmodels’ in dyn.load(file, DLLpath = DLLpath, ...):
# # unable to load shared object '/usr/local/lib/R/site-library/topicmodels/libs/topicmodels.so':
# #  libgsl.so.27: cannot open shared object file: No such file or directory
# #
# # try:
# #       sudo apt update && sudo apt install libgsl-dev (IN DOCKER RSTUDIO TERMINAL)
# #
#
#
# if (!require("devtools")) install.packages("devtools")
# devtools::install_github("StranMax/rfintext")
#
# pkgs <- c(
#   # "devtools",
#   "tidyverse",
#   "tidytext",
#   "rfintext",
#   "topicmodels",
#   "topicdoc",
#   "quanteda",
#   "future",
#   "furrr",
#   "progressr"
# )
# uninst <- pkgs[!pkgs %in% installed.packages()]
# if (length(uninst) > 0) install.packages(uninst)
# lapply(pkgs, library, character.only = TRUE, quietly = TRUE)
#
# bow <- aspol |>
#   preprocess_corpus(kunta) |>
#   count(kunta, LEMMA) |>
#   cast_dfm(kunta, LEMMA, n)
#
# with_progress({
#   lda_simulation <- calculate_semantic_coherence(bow, K_values = 3:30, n_seeds = 50, seed = 1042024)
# })
#
# saveRDS(lda_simulation, "lda_simulation_aspol.rds")

lda_models <- readRDS("C:/Users/maxs/Desktop/cpouta_volume_50_1/lda_simulation_aspol.rds")
lda_models <- lda_models |> select(-lda)  # Over 100Mb in size with lda included
usethis::use_data(lda_models, overwrite = TRUE)
