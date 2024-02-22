
#' Title
#'
#' @param data data frame
#' @param classes column giving classes
#' @param id column identifying documents
#' @param ratio ratio for training data, defaults to 0.7
#'
#' @return character vector of id names
#' @export
#'
#' @examples
split_train_test <- function(data, classes, id, ratio = 0.7) {
  train_idx <- data |> dplyr::pull({{classes}}) |> caret::createDataPartition(p = ratio, times = 1) |> unlist()
  data |> dplyr::slice(train_idx) |> dplyr::pull({{id}})
}


#' Title
#'
#' @param x quanteda dfm object
#' @param y data frame with classes
#' @param trainNames character vector of document names
#'
#' @return list of xgb.DMatrices for training and testing
#' @export
#'
#' @examples
get_train_test_data <- function(x, y, trainNames) {

  trainX <- x |> quanteda::dfm_subset(docname_ %in% trainNames) |> as.matrix()
  trainY <- y[y$kunta %in% trainNames, ]$luokka |> as.integer() - 1

  testX <- x |> quanteda::dfm_subset(!docname_ %in% trainNames) |> as.matrix()
  testY <- y[!y$kunta %in% trainNames, ]$luokka |> as.integer() - 1

  xgb_train <-  xgboost::xgb.DMatrix(data = trainX, label = trainY)
  xgb_test <- xgboost::xgb.DMatrix(data = testX, label = testY)

  list("Train" = xgb_train, "Test" = xgb_test)
}

#' Title
#'
#' @param xgb_model model returned by xgb.train
#' @param xgb_data_test xgb.DMatrix test data
#'
#' @return mean error value
#' @export
#'
#' @examples
compute_error <- function(xgb_model, xgb_data_test) {
  label = xgboost::getinfo(xgb_data_test, "label")
  pred <- stats::predict(xgb_model, xgb_data_test)
  err <- as.numeric(sum(as.integer(pred > 0.5) != label))/length(label)
  err
}

#' Title
#'
#' @param xgb_data_train xgb.DMatrix with train data
#' @param ... xgb model parameters
#'
#' @return xgb model
#' @export
#'
#' @examples
mod <- function(xgb_data_train, ...) {
  xgboost::xgb.train(data = xgb_data_train, params = ...)
}
