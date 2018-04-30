
cache <- new.env(hash = TRUE, parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  cache[["stack"]] <- list()
  cache[["trace"]] <- new.env(hash = TRUE, parent = emptyenv())
  invisible()
}

.onUnload <- function (libpath) {
  library.dynam.unload("typeR", libpath)
}
