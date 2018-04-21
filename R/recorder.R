
stack_push <-
  function(element) {
    updated_stack <- append(list(element), get_stack())
    assign("stack", updated_stack, envir = cache)
  }

stack_pop <-
  function() {
    stack <- get_stack()
    element <- stack[[1]]
    assign("stack", stack[-1], envir = cache)
    element
  }

get_stack <-
  function() {
    get("stack", envir = cache)
  }

stage_trace <-
  function(name, pkg, args, env) {
    cat("Entering", pkg, "::", name, "\n")
    parent_env <- parent.frame()
    stack_push(list(pkg, name, clone_env(parent_env)))
  }

commit_trace <-
  function(name, pkg, args, retv, seed, env) {
    cat("Exiting", pkg, "::", name, "\n")
    element <- stack_pop()
  }
