


#' Title
#'
#' @param dtm document term matrix (quanteda::dfm or tm::tm)
#' @param K_values vector for k values
#' @param n_seeds number of different random initializations for every k value
#' @param seed if seeds should be reproducible
#'
#' @return tibble with LDA models and semantic coherence
#' @export
#'
#' @importFrom dplyr .data
#'
#' @examples
#' \dontrun{
#' dtm <- aspol |>
#' preprocess_corpus(kunta) |>
#'  dplyr::count(kunta, LEMMA) |>
#'  tidytext::cast_dfm(kunta, LEMMA, n)
#'
#'  future::plan(future::multisession, workers = future::availableCores(logical = FALSE) - 1)
#'
#'  progressr::with_progressor({calculate_semantic_coherence(dtm = dtm, K_values = seq(5, 10, by = 5),
#'                               n_seeds = 1, seed = 1234)})
#'}
calculate_semantic_coherence <- function(dtm, K_values, n_seeds, seed) {

  # Better to leave plan() settings for end user. See Example usage
  # oplan <- future::plan(future::multisession, workers = future::availableCores(logical = FALSE) - 1)
  # on.exit(plan(oplan), add = TRUE)  # Clean after your self, restore default plan

  if (!is.na(seed)) set.seed(seed)
  random_seeds <- sample.int(9999999, n_seeds)

  grid_search <- tidyr::expand_grid(K = K_values, S = random_seeds)

  p <- progressr::progressor(steps = nrow(grid_search))

  # ptm <- proc.time()
  lda_models <- grid_search |>
    dplyr::mutate(
      # LDA models
      lda = furrr::future_map2(
        .data$K, .data$S, \(k, s)  {
          p()
          topicmodels::LDA(dtm, k = k, control = list(seed = s))
        },
        .options = furrr::furrr_options(seed = NULL)  # We WANT to use same seed here for all workers
      ),
      # Model coherence
      mean_coherence = furrr::future_map_dbl(
        .data$lda, \(x) {
          mean(topicdoc::topic_coherence(x, dtm))
        }
      )
    )
  # proc.time() - ptm

  lda_models
}
