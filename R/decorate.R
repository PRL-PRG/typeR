

decorate_for_type_inference <-
  function(env) {
    options(genthat.tracing=FALSE)

    decorate_environment(env,
                         create_decorator("onentry"),
                         stage_trace)

    decorate_environment(env,
                         create_decorator("onexit"),
                         commit_trace)

    options(genthat.tracing=TRUE)
  }
