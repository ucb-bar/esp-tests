#include "wg_array.h"
#include <stdio.h>
#include <stdint.h>
#include "input_dst_vector.h"
#include "input_d_data.h"
#include "input_d_index.h"
#include "input_d_perm.h"
#include "input_x_vec.h"
#include "input_dim.h"
#include "input_jds_ptr_int.h"
#include "input_sh_zcnt_int.h"
#include "util.h"
extern void _pocl_launcher_spmv_jds_naive_workgroup_fast(void** args, void* wg_struct);
#define WG_LENGTH 36

int main() {
  char test_dst_vector[sizeof(dst_vector)];
  void* args[WG_LENGTH] = { &test_dst_vector, &d_data, &d_index, &d_perm, &x_vec, &dim, &jds_ptr_int, &sh_zcnt_int};
  setStats(1);
  for(int i = 0; i < WG_LENGTH; i++) {
    _pocl_launcher_spmv_jds_naive_workgroup_fast(args, wg_array[i]);
  }
  setStats(0);
  for(int i = 0; i < sizeof(dst_vector); i++) {
    if(dst_vector[i] != test_dst_vector[i]) { 
      printf("FAIL\n");
      return 1;
    }
  }
  printf("PASS\n");
  return 0;
}
