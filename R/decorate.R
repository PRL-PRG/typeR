
decorate_for_type_inference <-
  function(env) {
    .Internal(options(genthat.tracing = FALSE))

    decorate_environment(env,
                         create_decorator("onentry"),
                         stage_trace)

    decorate_environment(env,
                         create_decorator("onexit"),
                         commit_trace)

    .Internal(options(genthat.tracing = TRUE))
  }
