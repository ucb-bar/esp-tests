#include "dataset1-ptr.h"
#include "dataset1.h"

/* Define constant pointers in a separate translation unit to ensure
   that the indirection is not optimized away */

int * const input1_data_ptr = input1_data;
int * const input2_data_ptr = input2_data;
int * const results_data_ptr = results_data;
int * const verify_data_ptr = verify_data;
