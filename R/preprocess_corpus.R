
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

log_dropped <- function(df_old, df_new, print.message = TRUE) {
  if (print.message) message("Dropped ", nrow(df_old) - nrow(df_new), " rows")
}

#' Title
#'
#' @param df data frame
#' @param doc document
#' @param ratio ratio for common terms, default 0.99
#'
#' @return data frame
#' @export
#'
#' @examples
remove_common_terms <- function(df, doc = .data$kunta, ratio = 0.99) {
  total_doc <- calculate_doc(df)

  limit <- min(c(nrow(dplyr::distinct(df, {{doc}})) - 5, total_doc * ratio))

  df_new <-  df |> calculate_doc_freq() |> dplyr::filter(.data$dc_n <= limit)
  log_dropped(df, df_new)

  df_new
}

#' Title
#'
#' @param df data frame
#' @param doc document
#' @param ratio ratio for rare terms, default 0.05
#'
#' @return data frame
#' @export
#'
#' @examples
remove_uncommon_terms <- function(df, doc = .data$kunta, ratio = 0.05) {
  total_doc <- calculate_doc(df)

  limit <- max(c(5, total_doc * ratio))

  df_new <- df |> calculate_doc_freq() |> dplyr::filter(.data$dc_n >= limit)
  log_dropped(df, df_new)

  df_new
}

#' Title
#'
#' @param df data frame
#' @param len minimum length for terms/words
#'
#' @return data frame
#' @export
#'
#' @examples
remove_short_term <- function(df, len = 3) {
  df_new <- df |> dplyr::filter(nchar(.data$FORM) > len, nchar(.data$LEMMA) >= len)
  log_dropped(df, df_new)

  df_new
}

#' Title
#'
#' @param df data frame
#'
#' @return data frame
#' @export
#'
#' @examples
remove_numbers <- function(df) {
  df_new <- df |> dplyr::filter(!stringr::str_detect(.data$FORM, "[0-9]"))
  log_dropped(df, df_new)

  df_new
}

#' Title
#'
#' @param df data frame
#'
#' @return data frame
#' @export
#'
#' @examples
remove_foreign <- function(df) {
  df_new <- df |> dplyr::filter(.data$UPOSTAG != "X", !stringr::str_detect(.data$FEATS, "Foreign=Yes"))
  log_dropped(df, df_new)

  df_new
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
  # function(df) {
  df_new <- df |> dplyr::filter(.data$UPOSTAG %in% upostag)
  log_dropped(df, df_new)

  df_new
  # }
}
# filter_noun_adj_verb <- filter_upostag(df, c("NOUN", "VERB", "ADJ"))

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
#' preprocess_corpus(aspol)
#'
preprocess_corpus <- function(df) {
  df |>
    filter_upostag(c("NOUN", "VERB", "ADJ")) |>
    remove_numbers() |>
    remove_foreign() |>
    remove_uncommon_terms() |>
    remove_common_terms() |>
    remove_short_term()
}
