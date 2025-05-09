
load_blast <- function(x, format = "6") {

  ## Load BLAST results in format 6
  if(format == "6") {

    headers <- c("qseqid", "sseqid", "pident", "length", "mismatch", 
    "gapopen", "qstart", "qend", "sstart", "send", "evalue", "bitscore")

    res <- fread(x, header = FALSE, col.names = headers)
  }

  return(res)
}


