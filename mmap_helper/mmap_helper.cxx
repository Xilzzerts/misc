#include "mmap_helper.hxx"
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

mmap_helper::mmap_helper(const char *path, uint32_t type)
{
    if(!path)
    {
        _reason = EINVAL;
        return;
    }
    _mem = NULL;
    _len = 0;
    _reason = 0;
    uint32_t flag;
    switch(type)
    {
        case MAP_TYPE_SHARED:
            flag = MAP_SHARED;
            break;
        case MAP_TYPE_PRIVATE:
            flag = MAP_PRIVATE;
            break;
        default:
            flag = MAP_PRIVATE;
    }
    struct stat buf;
    int ret = stat(path, &buf);
    if(ret != 0)
    {
        _reason = ENOENT;
        return;
    }
    ret = open(path, O_RDWR);
    if(ret < 0)
    {
        _reason = errno;
        return;
    }
    _mem = mmap(NULL, buf.st_size, PROT_WRITE | PROT_READ, flag, ret, 0);
    if(!_mem)
    {
        _reason = errno;
        return;
    }
    close(ret);
}

mmap_helper::~mmap_helper()
{
    munmap(_mem, _len);
}
