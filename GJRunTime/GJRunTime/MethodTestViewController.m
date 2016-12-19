//
//  MethodTestViewController.m
//  GJRunTime
//
//  Created by 郭家正 on 16/12/19.
//  Copyright © 2016年 郭家正. All rights reserved.
//

#import "MethodTestViewController.h"

@interface MethodTestViewController ()

@end

@implementation MethodTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(helloworld)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
