## TODO make this configurable
gmt_file_locs <- c(file.path('~/libs/GSEAgenesets/data-raw'))


#' Read in a .gmt file
#'
#' Copied from NKI-CCB/flexgsea
#'
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
#' Copied from NKI-CCB/flexgsea
#'
#'
find_gmt <- function(pattern = '*', type = 'symbols') {
  list.files(gmt_file_locs, pattern = sprintf('%s.*%s\\.gmt', pattern, type),
    full.names = T)
}


#' Filter a .gmt for genesets of interest
#'
#'
filter_gmt <- function(pattern = 'HALLMARK', gmt = find_gmt('*', 'symbols')) {
  gs <- read_gmt(gmt)
  return(gs[grepl(pattern, names(gs))])
}
