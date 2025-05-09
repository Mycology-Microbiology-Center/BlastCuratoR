
#' Update internal thresholds
#'
#' @description Development function to manage the internal thresholds dataset.
#'   Saves `new_thresholds` into `R/sysdata.rda` via `usethis::use_data(..., internal = TRUE)`.
#' @param new_thresholds A named list with updated threshold values.
#' @return Invisibly returns `new_thresholds`.
#' @keywords internal
update_thresholds <- function(new_thresholds) {

  usethis::use_data(new_thresholds,
    name = "thresholds", internal = TRUE, overwrite = TRUE, compress = "xz")

  message("Internal thresholds updated. Please rebuild and reinstall the package.")

  invisible(new_thresholds)
}
