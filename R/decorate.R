onentry_decorator <- create_decorator("onentry")
onexit_decorator <- create_decorator("onexit")

decorate_for_type_inference <-
  function(env, exclude=c()) {
    .Internal(options(genthat.tracing = FALSE))

    #names <- ls(env, all.names=TRUE)
    decorate_environment(env,
                         onentry_decorator,
                         stage_trace,
                         exclude=exclude)

    decorate_environment(env,
                         onexit_decorator,
                         commit_trace,
                         exclude=exclude)

    ## decorate_environment(env,
    ##                      create_decorator("on.exit"),
    ##                      commit_trace)

    .Internal(options(genthat.tracing = TRUE))
    NULL
  }

undecorate_for_type_inference <-
  function(env, exclude = c()) {
    .Internal(options(genthat.tracing = FALSE))

    names <- ls(env, all.names=TRUE)

    names <- names[!(names %in% exclude)]
    for (name in names) {
      fun <- env[[name]]
      if (is.function(fun) & is_decorated(fun, name, onentry_decorator, env=env)) {
        cat("Processing", name, "\n")
        reset_function(fun, name=name, decorator=onentry_decorator, env=env)
      }
      ## tryCatch({
      ##   fun <- env[[name]]
      ##   if (is.function(fun) & is_decorated(fun)) {
      ##     reset_function(fun, name=name, decorator=onentry_decorator, env=env)
      ##     fun
      ##     #cat("removed ", name, "\n")
      ##   }
      ## }, error=function(e) {
      ##   e$message
      ## })
    }

    .Internal(options(genthat.tracing = TRUE))
    invisible(NULL)
  }
