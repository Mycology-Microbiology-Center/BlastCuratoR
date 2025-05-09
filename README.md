# BlastCuratoR

`BlastCuratoR` is an R package designed to standardize the curation of taxonomic annotations from metabarcoding marker-gene BLAST results.  

When running BLAST against a reference database, each query often returns multiple hits that vary in percent identity, E-value, bitscore, and other metrics. Directly adopting the top hit’s species-level assignment can lead to overconfident or erroneous annotations. `BlastCuratoR` applies a set of rules and confidence thresholds to perform automated curation of the taxonomy annotation results.  

Currently, threshold are focused on eukaryotic rRNA, with a special emphasis on fungal internal transcribed spacer (ITS) region.  
