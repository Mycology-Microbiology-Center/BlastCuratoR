
#' @title Determine the lowest level of taxonomic classification
#' @details ...
#' @param x A data.table with columns containing taxonomic information
#' @param conflicts How to resolve conflicts ("LCA", "first")?
#' @param tax_cols A character vector of taxonomic ranks to consider
#' 
#' @return A single-row data.table
#' @export

get_lowest_rank <- function(x, conflicts = "LCA", tax_cols = NULL) {

    ## Default taxonomic ranks
    if (is.null(tax_cols)) {
        tax_cols <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")
    }

    ## Compute annotation depth per row (deepest non-NA column index)
    depth_list <- lapply(seq_along(tax_cols), function(i) {
        ifelse(!is.na(x[[tax_cols[i]]]), i, 0)
    })

    depths <- Reduce(pmax, depth_list)
    max_depth <- max(depths, na.rm = TRUE)
    
    ## If no taxonomy annotations at all, return one row of NAs
    if (max_depth == 0) {
        return(as.data.table(
            as.list(setNames(rep(NA_character_, length(tax_cols)), tax_cols))
        ))
    }
    
    ## Subset rows with deepest annotation
    rows_max <- x[ depths == max_depth, ..tax_cols ]

    ## If a single row, return it
    if (nrow(rows_max) == 1L) {
        return( rows_max[1L] )
    }

    ## Resolve conflicts
    if (conflicts == "LCA") {
        
        ## Pull out the deepest tax slice as a character matrix
        M <- as.matrix(rows_max[, seq_len(max_depth), with = FALSE])
        
        ## First row values
        first_vals <- M[1, ]
        
        ## Flag all mismatches (ignore NAs)
        mismatch <- M != matrix(first_vals,
                                 nrow = nrow(M),
                                 ncol = ncol(M),
                                 byrow = TRUE) &
                    !is.na(M)
        
        ## Where are mismatches?
        has_mismatch <- colSums(mismatch) > 0
        
        ## Keep prefixes up to the first conflicting rank
        if (any(has_mismatch)) {
            first_conflict <- which(has_mismatch)[1]
            has_mismatch[ first_conflict:length(has_mismatch) ] <- TRUE
        }

        ## Build consensus: keep first_vals where no mismatch, else NA
        consensus <- ifelse(!has_mismatch, first_vals, NA_character_)
        
        ## Pad out any deeper ranks to NA
        full_consensus <- c(consensus,
                            rep(NA_character_, length(tax_cols) - max_depth))
        
        res <- as.data.table(as.list(setNames(full_consensus, tax_cols)))
    }

    ## Keep the first deepest row (if no LCA required)
    if (conflicts == "first") {
        res <- rows_max[1L]
    }

    return(res)
}

