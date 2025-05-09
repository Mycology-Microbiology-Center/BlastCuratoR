
#' Apply curation thresholds to a single BLAST query
#'
#' @param x A data.table with BLAST hits for one query (sorted by e-value or bitscore)
#' @param thresholds Curation thresholds (default: internal `thresholds`)
#' @return A data.table with curated hits
#' @export


apply_thresholds <- function(x, thresholds = thresholds) {
  # x = BLAST results of a single query in long format (each row is a hit)

  # Validate inputs
  # ...



  return(res)
}
