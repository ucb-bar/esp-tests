#include "wg_array.h"
#include <stdio.h>
#include <stdint.h>
#include "input_A.h"
#include "input_lda.h"
#include "input_B.h"
#include "input_ldb.h"
#include "input_C.h"
#include "input_ldc.h"
#include "input_k.h"
#include "input_alpha.h"
#include "input_beta.h"
#include "util.h"
extern void _pocl_launcher_mysgemmNT_workgroup_fast(void** args, void* wg_struct);
#define WG_LENGTH 80

int main() {
  char test_C[sizeof(C)];
  void* args[WG_LENGTH] = { &A, &lda, &B, &ldb, &test_C, &ldc, &k, &alpha, &beta};
  setStats(1);
  for(int i = 0; i < WG_LENGTH; i++) {
    _pocl_launcher_mysgemmNT_workgroup_fast(args, wg_array[i]);
  }
  setStats(0);
  for(int i = 0; i < sizeof(C); i++) {
    if(C[i] != test_C[i]) { 
      printf("FAIL\n");
      return 1;
    }
  }
  printf("PASS\n");
  return 0;
}
