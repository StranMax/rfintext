
calculate_term_per_doc <- function(df, doc, term) {
  df |> dplyr::count({{doc}}, {{term}}, name = "dtc")
}

dtc_to_dtm <- function(df, doc, term) {
  df |> tidytext::cast_dfm(document = {{doc}}, term = {{term}}, value = .data$dtc)
}

#' Title
#'
#' @param df data frame
#' @param doc document column
#' @param term term column
#'
#' @return quanteda dfm object
#' @export
#'
#' @examples
corpus_to_dtm <- function(df, doc, term) {
  df |> calculate_term_per_doc({{doc}}, {{term}}) |> dtc_to_dtm({{doc}}, {{term}})
}
