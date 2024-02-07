
calculate_doc_freq <- function(df, doc = .data$kunta) {
  dc <- df |>
    dplyr::distinct({{doc}}, .data$LEMMA) |>
    dplyr::count(.data$LEMMA, name = "dc_n")

  suppressMessages(
    df |> dplyr::left_join(dc)
  )
}

calculate_doc <- function(df, doc = .data$kunta) {
  dplyr::pull(df, {{doc}}) |>
    unique() |>
    length()
}

filter_common_terms <- function(df, doc = .data$kunta, ratio = 0.5) {
  total_doc <- calculate_doc(df)

  df |> calculate_doc_freq() |> dplyr::filter((.data$dc_n / total_doc) < ratio)
}

filter_uncommon_terms <- function(df, doc = .data$kunta, ratio = 0.05) {
  total_doc <- calculate_doc(df)

  limit <- max(c(5, total_doc * ratio))

  df |> calculate_doc_freq() |> dplyr::filter(.data$dc_n >= limit)

}

filter_short_term <- function(df, len = 2) {
  df |> dplyr::filter(nchar(.data$FORM) > len, nchar(.data$LEMMA) > len)
}

filter_upostag <- function(df, upostag) {
  function(df) {
    df |> dplyr::filter(.data$UPOSTAG %in% upostag)
  }
}
filter_noun <- filter_upostag(df, "NOUN")
filter_verb <- filter_upostag(df, "VERB")
filter_adj <- filter_upostag(df, "ADJ")

#' Preprocess corpus object
#'
#' Preprocessing pipeline:
#' 1. Filter short terms
#' 2. Filter common terms appearing in most documents
#' 3. Filter terms appearing in few documents
#' 4. Filter only nouns
#'
#' @param df Data frame in tidytext format one token per document per line
#'
#' @return cleaned data frame
#' @export
#'
#' @importFrom dplyr .data
#'
#' @examples
#'
preprocess_corpus <- function(df) {
  df |>
    filter_short_term() |>
    filter_common_terms() |>
    filter_uncommon_terms() |>
    filter_noun()
}
