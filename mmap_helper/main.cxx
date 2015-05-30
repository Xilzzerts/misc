#include "mmap_helper.hxx"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    mmap_helper f("./Makefile", MAP_TYPE_PRIVATE);
    void *mem = f.get_mem();
    uint32_t len = f.get_len();
    if(!mem)
    {
        printf("error %s\n", strerror(f.get_error_reason()));
        return -1;
    }
    printf("mem %s\n", (char *)mem);
    printf("file len %d\n", len);
    mmap_helper f2("./Makefile.bak", len, 1);
    void *mem2 = f2.get_mem();
    if(!mem2)
    {
        printf("error %s\n", strerror(f2.get_error_reason()));
        return -1;
    }
    memcpy(mem2, mem, len);
    f2.sync();
    return 0;
}
