stage_trace <-
  function(name, pkg, args, env) {
    cat("Entering", pkg, "::", name, "\n")
  }

commit_trace <-
  function(name, pkg, args, retv, seed, env) {
    cat("Exiting", pkg, "::", name, "\n")
  }
