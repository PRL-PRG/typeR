
stack_push <- function(element) {
    updated_stack <- append(list(element), get_stack())
    assign("stack", updated_stack, envir = cache)
  }

stack_pop <- function() {
    stack <- get_stack()
    element <- stack[[1]]
    assign("stack", stack[-1], envir = cache)
    element
  }

get_stack <- function() {
    get("stack", envir = cache)
  }

stage_trace <- function(name, pkg, args, env) {
    #cat("Entering", pkg, "::", name, "\n")
    parent_env <- parent.frame()
    stack_push(list(pkg, name, clone_env(parent_env)))
  }

commit_trace <- function(name, pkg, args, retv, seed, env) {
    #cat("Exiting", pkg, "::", name, "\n")
    element <- stack_pop()
    arguments <- extract_values(element[[3]])
    store_trace(element[[1]], element[[2]], list(arguments, "retval" = retv))
  }


store_trace <- function(pkg, name, arguments) {
  if(is.null(pkg)) pkg <- "unknown"
  print(pkg)
  if (!exists(pkg, envir = cache[["trace"]]))
    assign(pkg, new.env(hash = TRUE, parent = emptyenv()), envir = cache[["trace"]])
  if (!exists(name, envir = cache[["trace"]][[pkg]]))
    assign(name, list(), envir = cache[["trace"]][[pkg]])

  traces <- append(cache[["trace"]][[pkg]][[name]], list(arguments))
  assign(name, traces, envir = cache[["trace"]][[pkg]])
}


extract_values <- function(env) {
  values <- list()
  for (name in ls(env)) {
    #print(name)
    if (is_evaluated(name, env))
      values[[name]] <- get(name, envir = env)
    else
      values[[name]] <- "__typeR_unevaluated_promise__"
  }
  values
}

get_trace <- function(pkg, funname) {
    if(!exists(pkg, envir = cache[["trace"]]))
      NULL
    if(!exists(funname, envir = cache[["trace"]][[pkg]]))
      NULL
    cache[["trace"]][[pkg]][[funname]]
  }
