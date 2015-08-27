//
//  WeatherModel.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWeatherModel;
@class FWeatherModel;

/**
 *  某一城市的天气 Model
 */
@interface WeatherModel : NSObject

@property (copy, readonly, nonatomic) NSString *cityName; /**< 城市名 */
@property (strong, nonatomic) TWeatherModel *tWeatherModel; /**< 当日天气 Model */
@property (strong, nonatomic) FWeatherModel *fWeatherModel; /**< 未来天气 Model */

/**
 *  初始化
 *
 *  @param resultDic 由 AFNetworking 回调请求到的结果中 键值为 @“result” 的字典值
 *
 *  @return 该类实例
 */
+ (instancetype)weatherModelWithDictionary:(NSDictionary *)resultDic;

@end
