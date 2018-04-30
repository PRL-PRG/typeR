is_evaluated <-
  function(name, env) {
     if (is.character(name)) {
       name <- as.symbol(name)
     }
    .Call("is_evaluated", PACKAGE = "typeR", name, env)
  }
