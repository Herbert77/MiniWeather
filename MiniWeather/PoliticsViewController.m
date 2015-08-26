//
//  PoliticsViewController.m
//  EBDropMenu
//
//  Created by edwin bosire on 31/05/2015.
//  Copyright (c) 2015 Edwin Bosire. All rights reserved.
//

#import "PoliticsViewController.h"

@interface PoliticsViewController ()

@end

@implementation PoliticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((width-4)/2.0, (height-4)/2.0, 4, 4)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
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
