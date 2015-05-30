
//
//  DataItem.m
//  UINavigationControllerTest
//
//  Created by Zirconi on 15/5/29.
//  Copyright (c) 2015年 Zirconi. All rights reserved.
//

#import "DataItem.h"
@interface DataItem ()

@property (nonatomic, strong) NSMutableArray *content;

@end


@implementation DataItem

+(NSArray *)getItem
{
    static DataItem *item = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{item = [[self alloc]init];});
    return [item content];
}

-(instancetype) init
{
    self = [super init];
    if (self) {
        self.content = [[NSMutableArray alloc]init];
        [self.content addObject:@"testa"];
        [self.content addObject:@"testb"];
        [self.content addObject:@"testc"];
        [self.content addObject:@"testd"];
        [self.content addObject:@"teste"];
        [self.content addObject:@"testf"];
        [self.content addObject:@"testg"];
        
    }
    return self;
}

@end
