#ifndef FINSTRUMENT_H
#define FINSTRUMENT_H
unsigned long t_value_usec[2014];
extern int fins_indx;

void __cyg_profile_func_enter (void *this_fn, void *call_site) __attribute__((no_instrument_function));
void __cyg_profile_func_exit  (void *this_fn, void *call_site) __attribute__((no_instrument_function));
#endif
