
clone_env <-
  function(src_env,
           src_varnames = ls(src_env),
           dest_env = new.env(hash = TRUE,
                              parent = emptyenv()),
           dest_varnames = src_varnames) {

    if (!is.environment(src_env))
      stop("source object is not an environment")

    if (!is.environment(dest_env))
      stop("destination object is not an environment")

    if (length(src_varnames) != length(dest_varnames))
      stop(cat("length of source variable names and destination",
               "variable names must match"))

    .Call("clone_env", src_env, src_varnames, dest_env, dest_varnames)
  }
