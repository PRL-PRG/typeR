#include "utils.h"

/* This function copies values of variables from one environment
   to another environment.
   Promises are not forced and active bindings are preserved. */

SEXP clone_env(SEXP src_env, SEXP src_varnames,
               SEXP dest_env, SEXP dest_varnames) {

    SEXP src_sym, dest_sym, value;

    for (int i = 0; i < LENGTH(src_varnames); i++) {
        src_sym = Rf_installChar(STRING_ELT(src_varnames, i));
        dest_sym = Rf_installChar(STRING_ELT(dest_varnames, i));

        value = Rf_findVar(src_sym, src_env);
        if (value == R_UnboundValue) {
            Rf_error("exported symbol '%s' has no value",
                     CHAR(PRINTNAME(src_sym)));
        } else {
            defineVar(dest_sym, value, dest_env);
        }
    }

    return dest_env;
}
