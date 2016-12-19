//
//  ViewTestViewController.m
//  GJRunTime
//
//  Created by 郭家正 on 16/12/19.
//  Copyright © 2016年 郭家正. All rights reserved.
//

#import "ViewTestViewController.h"

@interface ViewTestViewController ()

@end

@implementation ViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
