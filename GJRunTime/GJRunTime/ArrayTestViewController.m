//
//  ArrayTestViewController.m
//  GJRunTime
//
//  Created by 郭家正 on 16/12/19.
//  Copyright © 2016年 郭家正. All rights reserved.
//

#import "ArrayTestViewController.h"

@interface ArrayTestViewController ()

@end

@implementation ArrayTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = @[@"a",@"b"];
    NSLog(@"index at array count :%@",array[[array count]]);
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
