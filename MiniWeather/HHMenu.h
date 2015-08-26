//
//  HHMenu.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHMenu : UIView

@property (weak, nonatomic) HHBaseViewController *currentViewController;

@property (weak, nonatomic) NSMutableArray *controllerArray;

- (instancetype)initWithMenuItems:(NSArray *)menuItems forViewController:(UIViewController *)viewController;

- (void)showMenu;


@end
