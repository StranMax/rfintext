
#' Document term table in tidy format of Finnish housing policy documents
#'
#' aspol and aspol_filtered which is analysis ready data set of housing policy
#' documents. More info of format in \url{https://universaldependencies.org/format.html}
#'
#' @source Finnish municipalities
#'
#' @format A data frame with rows and columns:
#' \describe{
#'   \item{kunta}{Municipality name}
#'   \item{sent}{Sentence number per document/municipality}
#'   \item{ID}{Word index, integer starting at 1 for each new sentence}
#'   \item{FORM}{Word form or punctuation symbol}
#'   \item{LEMMA}{Lemma or stem of word form}
#'   \item{UPOSTAG}{Universal part-of-speech tag}
#'   \item{XPOSTAG}{Language-specific part-of-speech}
#'   \item{FEATS}{List of morphological features}
#'   \item{HEAD}{Head of the current word, which is either a value of ID or zero (0)}
#'   \item{DEPREL}{Universal dependency relation to the HEAD}
#'   \item{DEPS}{Enhanced dependency graph in the form of a list of head-deprel pairs}
#'   \item{MISC}{Any other annotation}
#'   \item{doc}{Document name read from}
#' }
#' @examples
#' aspol
#'
#'
"aspol"
