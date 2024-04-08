
#' Calclulate document frequency
#'
#' Adds document frequencies to new column. Document frequency describes in how
#' many documents term appears. Useful in finding very common terms appearing
#' in almost all the documents and very rare terms appearing in only single or
#' very few documents.
#'
#' @param df tidy data frame with one term per row
#' @param doc column with document id
#' @param term column with terms
#'
#' @return tidy data frame with added column df giving document frequencies for
#'         terms and df_ratio giving relative document frequency
#' @export
#'
#' @examples
calculate_doc_freq <- function(df, doc, term) {
  dc <- df |>
    dplyr::distinct({{doc}}, {{term}}) |>
    dplyr::count({{term}}, name = "df")

  suppressMessages(
    df |>
      dplyr::left_join(dc) |>
      dplyr::mutate(df_ratio = df / length(unique({{doc}})))
  )
}

#' Remove short terms
#'
#' @param df data frame
#'
#' @return data frame
#' @export
#'
#' @examples
remove_short_term <- function(df) {
   df |> dplyr::filter(nchar(.data$FORM) >= 2, nchar(.data$LEMMA) >= 3)
}

#' Remove terms containing numbers
#'
#' @param df data frame
#' @param term column with the terms
#'
#' @return data frame
#' @export
#'
#' @examples
remove_numbers <- function(df, term) {
   df |> dplyr::filter(!stringr::str_detect({{term}}, "[0-9]"))
}

#' Remove foreign terms
#'
#' Foreign terms are defined as having UPOSTAX=="X" and FEATS=="Foreign=Yes"
#'
#' @param df tidy data frame with one term per row
#'
#' @return data frame with foreign terms removed
#' @export
#'
#' @examples
remove_foreign <- function(df) {
  df |> dplyr::filter(.data$UPOSTAG != "X", !stringr::str_detect(.data$FEATS, "Foreign=Yes"))
}

#' Title
#'
#' @param df data frame
#' @param upostag character vector of upostag classes
#'
#' @return data frame
#' @export
#'
#' @examples
filter_upostag <- function(df, upostag) {
 df |> dplyr::filter(.data$UPOSTAG %in% upostag)

}

#' Preprocess corpus object
#'
#' Preprocessing pipeline:
#' 1. Filter short terms
#' 2. Filter common terms appearing in most documents
#' 3. Filter terms appearing in few documents
#' 4. Filter only nouns
#'
#' @param df Data frame in tidytext format one token per document per line
#' @param doc column with document id
#'
#' @return cleaned data frame
#' @export
#'
#' @importFrom dplyr .data
#'
#' @examples
#' preprocess_corpus(aspol, kunta)
#'
preprocess_corpus <- function(df, doc) {
  df |>
    dplyr::filter(UPOSTAG %in% c("NOUN", "VERB", "ADJ")) |>
    # remove_numbers(term = .data$FORM) |>
    dplyr::filter(!stringr::str_detect(.data$FORM, "[0-9]")) |>
    # remove_foreign() |>
    dplyr::filter(!stringr::str_detect(.data$FEATS, "Foreign=Yes")) |>
    calculate_doc_freq({{doc}}, .data$LEMMA) |>
    dplyr::filter(df >= 5, df <= 65) |>
    # remove_short_term()
    dplyr::filter(nchar(.data$FORM) >= 3, nchar(.data$LEMMA) >= 4)
}
