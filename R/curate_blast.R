
#' Curate BLAST results for all queries
#'
#' @param blast_results A data.table where each row is a BLAST hit
#' @param thresholds Curation thresholds (default: internal `thresholds`)
#' @return A named list of curated annotations for each query.
#' @export
#' 

curate_blast <- function(blast_results, thresholds = thresholds) {
  # blast_results = BLAST results with multiple queries

  # Handle empty input
  # if(nrow(blast_results) == 0){ ... }

  # Apply single-query function over all hits
  # ...

}

