//
//  HHBaseViewController.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBHamburgerButton.h"

@class HHMenuItem;

@interface HHBaseViewController : UIViewController

@property (strong, nonatomic) HHMenuItem *menuItem; /**< 菜单项模型 */

@property (strong, nonatomic) LBHamburgerButton *buttonHamburger;   /**< 菜单按钮 */

@end
