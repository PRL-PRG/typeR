context("test-trace.R")

test_that("trace works", {

  expect_null({

    env <- new.env(hash = TRUE, parent = baseenv())

    env$f1 <- function(x, y) {
      x + y
    }

    environment(env$f1) <- env

    env$f2 <- function(x , y) {
      list(f1(x, y), x - y)
    }

    environment(env$f2) <- env

    env$f3 <- function(str1, str2) {
      paste0(str1, "::", str2)
    }

    environment(env$f3) <- env

    decorate_for_type_inference(env)# exclude=c("withVisible", "tryCatch", "get"))

    print(env$f1)
    env$f3("a", "b")
    env$f2(3, 3)
    undecorate_for_type_inference(env)#, exclude=c("withVisible", "tryCatch", "get"))
    print(get_trace("unknown", "f1"))
    print(get_trace("unknown", "f2"))
    print(get_trace("unknown", "f3"))
    for(name in ls(env)) {
      print(env[[name]])
    }

  })

})
