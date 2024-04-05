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
#   "devtools",
#   "tidyverse",
#   "tidytext",
#   "rfintext",
#   "topicmodels",
#   "topicdoc",
#   "quanteda",
#   "future",
#   "furrr"
# )
# uninst <- pkgs[!pkgs %in% installed.packages()]
# if (length(uninst) > 0) install.packages(uninst)
# lapply(pkgs, library, character.only = TRUE, quietly = TRUE)
#
# # plan(multicore, workers = availableCores(logical = FALSE) - 1)
# plan(multisession, workers = availableCores(logical = FALSE) - 1)
#
# bow <- aspol |>
#   preprocess_corpus(kunta) |>
#   count(kunta, LEMMA) |>
#   cast_dfm(kunta, LEMMA, n)
#
# set.seed(342024)
# random_seeds <- sample.int(9999999, 10)  # 3476154 5039353 8550496 7292293 5500417 7137547 6622604 9458765 3952778 8167640
#
# sink("log_lda_simulation_aspol.txt")
# ptm <- proc.time()
# lda_models <- expand_grid(K = 3:30, S = random_seeds) |>
#   mutate(
#     # LDA models
#     lda = future_map2(
#       K, S, \(k, s)  {
#         LDA(convert(bow, to = "tm"), k = k, control = list(seed = s))
#       },
#       .options = furrr_options(seed = NULL)
#     ),
#     # Model coherence
#     mean_coherence = future_map_dbl(
#       lda, \(x) {
#         mean(topic_coherence(x, bow))
#       }
#     )
#   )
# proc.time() - ptm
# sink()
# saveRDS(lda_models, "lda_models_aspol.rds")

lda_models <- readRDS("C:/Users/maxs/Documents/data/lda_simulation_aspol/lda_models_aspol.rds")
lda_models <- lda_models |> select(-lda)  # Over 100Mb in size with lda included
usethis::use_data(lda_models, overwrite = TRUE)
