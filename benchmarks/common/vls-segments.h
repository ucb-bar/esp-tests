#include <stdint.h>
#include <stdlib.h>

#define VLS_CONF_BASE 0x40200000
#define WAY_SIZE 0x40000 // 8 way, 2048kB -> 18 untag bits

static inline uintptr_t getnvlssegs(void)
{
  volatile uintptr_t *vls_conf = (volatile uintptr_t *) VLS_CONF_BASE;
  return *vls_conf;
}

static inline void *getvlspbase(uintptr_t segnum)
{
  volatile uintptr_t *vls_conf = (volatile uintptr_t *) VLS_CONF_BASE;
  return (void *) vls_conf[2*(segnum+1)];
}

static inline void setvlspbase(uintptr_t segnum, void *pbase)
{
  volatile uintptr_t *vls_conf = (volatile uintptr_t *) VLS_CONF_BASE;
  vls_conf[2*(segnum+1)] = (uintptr_t) pbase;
}

static inline uintptr_t getvlssize(uintptr_t segnum)
{
  volatile uintptr_t *vls_conf = (volatile uintptr_t *) VLS_CONF_BASE;
  return vls_conf[2*(segnum+1)+1];
}

static inline void setvlssize(uintptr_t segnum, size_t size)
{
  volatile uintptr_t *vls_conf = (volatile uintptr_t *) VLS_CONF_BASE;
  vls_conf[2*(segnum+1)+1] = size;
}

static inline void vlspin(void *start, size_t size)
{
  setvlspbase(0, start);
  setvlssize(0, size);
}
