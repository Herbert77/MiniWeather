//
//  HHHomeItem.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHHomeItem : NSObject

@property (copy, nonatomic) NSString *cellBackgroundImageName;    /**< 用来配置cell 背景的图片名称 */
@property (copy, nonatomic) NSString *cityName; /**< 城市名 */
@property (copy, nonatomic) NSString *weatherImageName; /**< 用来配置cell 天气图标的图片名称 */
@property (copy, nonatomic) NSString *temperature;  /**< 气温 */

+ (instancetype)initWithCellBackgroundImageName:(NSString *)cellBackgroundImageName cityName:(NSString *)cityName weatherImageName:(NSString *)weatherImageName temperature:(NSString *)temperature;

@end
