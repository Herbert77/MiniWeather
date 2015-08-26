//
//  HHMenuItem.m
//  HHDropMenu
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHMenuItem.h"

@implementation HHMenuItem

+ (instancetype)initWithIconImageName:(NSString *)imageName withColorScheme:(UIColor *)color {
    
    HHMenuItem *menu = [HHMenuItem new];
    
    if (menu) {
        
        menu.iconImageName = imageName;
        menu.colorScheme = color;
    }
    
    return menu;
}

@end
