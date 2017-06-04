//
//  ViewController.m
//  SearchBar
//
//  Created by xiacheng on 2017/6/4.
//  Copyright © 2017年 xiacheng. All rights reserved.
//

#import "ViewController.h"
#import "CountryListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CountryListViewController *vc = [CountryListViewController new];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
