#ifndef _MMAP_HELPER_H_
#define _MMAP_HELPER_H_
#include <stdint.h>
#include <sys/mman.h>

enum MMAP_TYPE
{
MAP_TYPE_SHARED,
MAP_TYPE_PRIVATE,
//MAP_TYPE_ANONYMOUS;
};


class mmap_helper
{
public:
    mmap_helper() = delete;
    mmap_helper(const char *path, uint32_t type);
    //arg3 is ignore, just for overload
    mmap_helper(const char *path, uint32_t len, bool newfile);
    mmap_helper(const mmap_helper &) = delete;
    mmap_helper &operator=(mmap_helper &) = delete;
    ~mmap_helper();
    void *get_mem(){return _mem;}
    uint32_t get_len(){return _len;}
    uint32_t get_error_reason(){return _reason;}
    void sync();
private:
    void *_mem;
    uint32_t _len;
    uint32_t _reason;
    uint32_t _type;
};
#endif
