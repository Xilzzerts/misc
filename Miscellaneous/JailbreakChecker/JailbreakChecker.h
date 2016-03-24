//
//  JailbreakChecker.h
//  split
//
//  Created by Zirconi on 15-4-7.
//  Copyright (c) 2015年 Zirconi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define _CHECK_LOADED_DYLIB_
#define _CHECK_APPLICATION_LINK_

#ifdef _CHECK_APPLICATION_LINK_
#include <sys/stat.h>
#endif

#ifdef _CHECK_LOADED_DYLIB_
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/arch.h>
#endif

@interface JailbreakChecker : NSObject

-(BOOL) checkKeyFile;

#ifdef _CHECK_LOADED_DYLIB_
-(BOOL) checkDylib;
#endif

#ifdef _CHECK_APPLICATION_LINK_
-(BOOL) checkLink;
#endif
@end
