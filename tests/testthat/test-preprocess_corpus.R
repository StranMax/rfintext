test_that("remove_common_terms works", {
  # docf <- dplyr::distinct(aspol, kunta, LEMMA) |> count(LEMMA, name = "docf")
  aspol_filtered <- aspol |>
    remove_uncommon_terms() |>
    remove_common_terms() |>
    dplyr::distinct(kunta, LEMMA) |>
    dplyr::count(LEMMA, name = "docf")
  expect_lte(max(aspol_filtered$docf), 63)
  expect_gte(min(aspol_filtered$docf), 5)
})
