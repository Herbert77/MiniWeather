//
//  HHMenuItem.h
//  HHDropMenu
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(void);

@interface HHMenuItem : NSObject

@property (copy, nonatomic) NSString *iconImageName;    /**< 菜单子项的图标名称 */
@property (strong, nonatomic) UIColor *colorScheme; /**< 菜单子项的背景颜色主题 */
@property (copy, nonatomic) CompletionBlock completionBlock;    /**< 以懒加载的方式加载各个菜单子项对应的视图控制器 */

+ (instancetype)initWithIconImageName:(NSString *)imageName withColorScheme:(UIColor *)color;   /**< 指定初始化 */

@end
