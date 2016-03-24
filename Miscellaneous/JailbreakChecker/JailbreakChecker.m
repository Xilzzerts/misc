//
//  JailbreakChecker.m
//  split
//
//  Created by Zirconi on 15-4-7.
//  Copyright (c) 2015年 Zirconi. All rights reserved.
//

#import "JailbreakChecker.h"


@interface JailbreakChecker ()
-(char *) _getString:(const char *) str;

@end

@implementation JailbreakChecker

/*
const char *file1 = "/Library/MobileSubstrate/MobileSubstrate.dylib";
const char *file2 = "/Applications/Cydia.app/";
const char *file3 = "/var/lib/cydia/";
const char *file4 = "/var/cache/apt";
const char *file5 = "/bin/bash";
const char *file6 = "/usr/sbin/sshd";
 */
const char *file1 = "0Mjcsbsz0NpcjmfTvctusbuf0NpcjmfTvctusbuf/ezmjc";
const char *file2 = "0Bqqmjdbujpot0Dzejb/bqq0";
const char *file3 = "0wbs0mjc0dzejb0";
const char *file4 = "0wbs0dbdif0bqu";
const char *file5 = "0cjo0cbti";
const char *file6 = "0vts0tcjo0ttie";
#ifdef _CHECK_LOADED_DYLIB_
const char *keylib = "yDpo/ezmjc";
#endif

#ifdef _CHECK_APPLICATION_LINK_
const char *dir = "0Bqqmjdbujpot";
#endif



-(char *) _getString:(const char *) str
{
    int len = strlen(str);
    char *buf = calloc(len + 1, 1);
    memcpy(buf, str, len);
    for (int i = 0; i < len; ++i) {
        --buf[i];
    }
    return buf;
}
-(BOOL) checkKeyFile;
{
    char *nfile1 = [self _getString:file1];
    char *nfile2 = [self _getString:file2];
    char *nfile3 = [self _getString:file3];
    char *nfile4 = [self _getString:file4];
    char *nfile5 = [self _getString:file5];
    char *nfile6 = [self _getString:file6];
    int ret1, ret2, ret3, ret4, ret5, ret6;
    ret1 = access(nfile1, R_OK);
    ret2 = access(nfile2, R_OK);
    ret3 = access(nfile3, R_OK);
    ret4 = access(nfile4, R_OK);
    ret5 = access(nfile5, R_OK);
    ret6 = access(nfile6, R_OK);
    free(nfile1);
    free(nfile2);
    free(nfile3);
    free(nfile4);
    free(nfile5);
    free(nfile6);
    if(!ret1 || !ret2 || !ret3 || !ret4 || !ret5 || !ret6)
        return YES;
    return NO;
}

#ifdef _CHECK_LOADED_DYLIB_
-(BOOL) checkDylib
{
    int count = _dyld_image_count();
    char *key = [self _getString:keylib];
    char *keyfile = [self _getString:file1];
    for(int i = 0; i < count; i++)
    {
        const char *dyld = _dyld_get_image_name(i);
        if(strcasestr(dyld, key))
        {
            free(key);
            free(keyfile);
            return YES;
        }
        if(strcasestr(dyld, keyfile))
        {
            free(key);
            free(keyfile);
            return YES;
        }
    }
    free(keyfile);
    free(key);
    return NO;
}
#endif

#ifdef _CHECK_APPLICATION_LINK_
-(BOOL) checkLink
{
    char *cdir = [self _getString:dir];
    struct stat buf;
    int ret = lstat(cdir, &buf);
    if (ret) {
        free(cdir);
        return NO;
    }
    if (S_ISLNK(buf.st_mode)) {
        free(cdir);
        return YES;
    }
    free(cdir);
    return NO;
}
#endif

@end
