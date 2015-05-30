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
    NSLog(@"1");
    _item = item;
    [self.navigationController navigationItem].title = _item;
}

-(void)viewDidLoad
{
    [self.label setText:_item];
}
@end
