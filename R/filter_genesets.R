gmt_file_locs <- c(file.path('~/libs/genesets/data-raw'))
for (d in gmt_file_locs) {
  print(d)
  stopifnot(dir.exists(d))
}


#' Read in a .gmt file
#'
#' Copied from NKI-CCB/flexgsea
#'
read_gmt <- function(file, progress = interactive()) {
  lines <- readr::read_lines(file, progress = progress)
  lines <- stringr::str_split(lines, "\t", 3)
  pw_names <- sapply(lines, `[[`, 1)
  pw_genes <- stringr::str_split(sapply(lines, `[[`, 3), "\t")
  names(pw_genes) <- pw_names
  pw_genes
}


#' Read in a .gmt file
#'
#'
find_gmt <- function(pattern = 'msigdb', type = 'symbols') {
  list.files(gmt_file_locs, pattern = sprintf('%s.*%s\\.gmt', pattern, type),
    full.names = T)
}


#' Filter a .gmt for genesets of interest
#'
#'
filter_gmt <- function(pattern='HALLMARK', gmt_pattern='*', type='symbols') {
  gmt <- find_gmt(gmt_pattern, type)
  gs <- unlist(lapply(gmt, function(gmt_s) read_gmt(gmt_s)), recursive = F)
  return(gs[grepl(pattern, names(gs))])
}
