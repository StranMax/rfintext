
#' Title
#'
#' @param dfm quanteda dfm object
#' @param k number of topics to classify
#'
#' @return named vector of k and coherence score
#' @export
#'
#' @examples
get_coherence <- function(dfm, k) {
  lda <- topicmodels::LDA(quanteda::convert(dfm, to = "tm"), k = k, control = list(seed = 1234))
  coherence <- mean(topicdoc::topic_coherence(lda, dfm))
  c(k = k, coh = coherence)
}

#' Title
#'
#' @param mx matrix with columns k and coh
#'
#' @return ggplot2 object
#' @export
#'
#' @examples
plot_coherence <- function(mx) {
  ggplot2::ggplot(as.data.frame(mx)) +
    ggplot2::geom_line(ggplot2::aes(x = .data$k, y = .data$coh))
}

#' Title
#'
#' @param dfm quanteda dfm object
#' @param k number of topics to classify
#'
#' @return data frame of document topic probablilities
#' @export
#'
#' @examples
get_doc_topic_prob <- function(dfm, k) {
  lda <- topicmodels::LDA(quanteda::convert(dfm, to = "tm"), k = k, control = list(seed = 1234))
  lda |>
    tidytext::tidy(matrix = "gamma") |>
    tidytext::cast_dfm(document, topic, gamma)
}
