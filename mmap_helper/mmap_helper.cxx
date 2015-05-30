#include "mmap_helper.hxx"
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>

mmap_helper::mmap_helper(const char *path, uint32_t type)
{
    _mem = NULL;
    _len = 0;
    _reason = 0;
    _type = 0;

    if(!path)
    {
        _reason = EINVAL;
        return;
    }
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
    _type = flag;
    struct stat buf;
    int ret = stat(path, &buf);
    if(ret != 0)
    {
        _reason = errno;
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
    _len = buf.st_size;
    close(ret);
}

mmap_helper::mmap_helper(const char *path, uint32_t len, bool newfile)
{
    _mem = NULL;
    _len = 0;
    _reason = 0;
    _type = 0;

    if(!path || !len)
    {
        _reason = EINVAL;
        return;
    }
    int ret = access(path, F_OK);
    if(ret == 0)
    {
        _reason = EEXIST;
        return;
    }
    ret = open(path, O_RDWR | O_CREAT, 0755);
    if(ret < 0)
    {
        _reason = errno;
        return;
    }
    ftruncate(ret, len);
    _mem = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, ret, 0);
    if(!_mem)
    {
        _reason = errno;
        return;
    }
    _len = len;
    _type = MAP_TYPE_SHARED;
    close(ret);
}

mmap_helper::~mmap_helper()
{
    munmap(_mem, _len);
}

void mmap_helper::sync()
{
    if(_type == MAP_TYPE_SHARED && _mem && _len)
    {
        msync(_mem, _len, MS_SYNC);
    }
}
