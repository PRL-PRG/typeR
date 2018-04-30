#include "utils.h"
#include <R_ext/Rdynload.h>
//#include <R_ext/Visibility.h>

static const R_CallMethodDef CallEntries[] = {
    {"clone_env", (DL_FUNC)&clone_env, 4},
    {"is_evaluated", (DL_FUNC)&is_evaluated, 2},
    {NULL, NULL, 0}};

void R_init_typer(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
    R_forceSymbols(dll, TRUE);
}
