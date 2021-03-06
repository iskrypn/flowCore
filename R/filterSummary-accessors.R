## ==========================================================================
## The filterSummary class provides a container for the output of summary
## on a filterResult
## ==========================================================================






## ==========================================================================
## Subsetting methods
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
## We need this to subset filterSummaries of multipleFilterResults
#' @export
setMethod("[[",
          signature=signature(x="filterSummary",
                              i="numeric"),
          definition=function(x, i, j, ...)
      {
          list(name=as.vector(x@name[i]), true=as.vector(x@true[i]),
               false=as.vector(x@count[i]-x@true[i]),
               count=x@count, p=as.vector(x@p[i]),
               q=as.vector(1-x@p[i]))
      })

## By name
#' @export
setMethod("[[",
          signature=signature(x="filterSummary",
                              i="character"),
          definition=function(x,i,j,...)
      {
          i <- which(i==names(x))
          x[[i]]
      })



## ==========================================================================
## This allows for a list-like accessor to the slots (and more...)
## Valid values are 'n', 'count', 'true', 'false', 'name', 'p' and 'q'
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#' @export
setMethod("$",
          signature=signature(x="filterSummary"),
          definition=function(x, name)
      {
          switch(name, "n"=x@count, "true"=x@true, "in"=x@true,
                 "false"=x@count-x@true, "out"=x@count-x@true,
                 "p"=x@p, "q"=1-x@p, "count"=x@count, "name"=x@name)
      })



## ==========================================================================
## Return a more machine-readable output in form of a data.frame
## - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#' @importFrom BiocGenerics toTable
#' @export
setMethod("toTable",
          signature=signature(x="filterSummary"),
          definition=function(x, ...) {
              data.frame(percent=x$p*100, count=x@count, true=x@true, false=x$false,
                         p=x$p, q=x$q)
          })
