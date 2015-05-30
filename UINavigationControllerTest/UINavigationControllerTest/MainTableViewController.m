//
//  MainTableViewController.m
//  UINavigationControllerTest
//
//  Created by Zirconi on 15/5/29.
//  Copyright (c) 2015年 Zirconi. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailItemViewController.h"
#import "DataItem.h"

@interface MainTableViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation MainTableViewController

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    cell.textLabel.text = [[DataItem getItem]objectAtIndex:[indexPath row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[DataItem getItem]count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailItemViewController *detail = [[DetailItemViewController alloc]init];
    detail.item = [[DataItem getItem]objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView]registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self navigationController].navigationItem.title = @"MainTable";
    }
    return self;
}
@end
