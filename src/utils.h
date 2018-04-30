#include <R.h>
#include <Rinternals.h>

SEXP clone_env(SEXP src_env, SEXP src_varnames, SEXP dest_env,
               SEXP dest_varnames);
SEXP is_evaluated(SEXP varname, SEXP env);
