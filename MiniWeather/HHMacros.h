//
//  HHMacros.h
//  Block
//
//  Created by 胡传业 on 15/8/20.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#ifndef Block_HHMacros_h
#define Block_HHMacros_h

/*------------------- 设备大小 -------------------*/

// 导航栏高度
#define NavigationBar_HEIGHT 44

// 屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/*------------------- 日志打印 -------------------*/

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

/*------------------- 系统 -------------------*/

// 系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

// 当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// Retina屏幕 ？
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone 5 ?
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// iPad ?
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/*------------------- 图片 -------------------*/

// 读取本地图片
#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

/*------------------- 颜色 -------------------*/

// RGB 颜色转换 （16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  

// Red Green Blue Alpha 颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A] 

// 系统控件默认高度
#define kStatusBarHeight        (20.f)
#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)
#define kCellDefaultHeight      (44.f)
#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

//** 获得当前的 年 月 日 时 分 秒 *****************************************************************************
#define  CurrentSec [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:[NSDate date]]
#define  CurrentMin [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:[NSDate date]]
#define  CurrentHour [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]]
#define  CurrentDay  [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]
#define  CurrentMonth [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]]
#define  CurrentYear [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]]

//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif
