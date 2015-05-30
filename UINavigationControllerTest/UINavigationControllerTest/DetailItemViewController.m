//
//  DetailItemViewController.m
//  UINavigationControllerTest
//
//  Created by Zirconi on 15/5/29.
//  Copyright (c) 2015年 Zirconi. All rights reserved.
//

#import "DetailItemViewController.h"

@interface DetailItemViewController ()
@property (nonatomic, weak) IBOutlet UILabel *label;
@end

@implementation DetailItemViewController

-(void)setItem:(NSString *)item
{
    _item = item;
    [self.label setText:_item];
    [self.navigationController navigationItem].title = _item;
}
@end
