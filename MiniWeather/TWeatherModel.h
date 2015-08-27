//
//  TWeatherModel.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "MTLModel.h"

/**
 *  今日 天气数据 Model
 */
@interface TWeatherModel : MTLModel <MTLJSONSerializing>

/**
 *  @property sk.*
 */
@property (copy, readonly, nonatomic) NSString *currentTemp;  /**< 当前温度 */
@property (copy, readonly, nonatomic) NSString *windDirection; /**< 当前风向 */
@property (copy, readonly, nonatomic) NSString *windStrength;  /**< 当前风力 */
@property (copy, readonly, nonatomic) NSString *humidity;     /**< 当前湿度 */
@property (copy, readonly, nonatomic) NSString *currentTime;   /**< 当前时间 */

/**
 *  @property today.*
 */
@property (copy, readonly, nonatomic) NSString *city;   /**< 城市名 */
@property (copy, readonly, nonatomic) NSString *date;   /**< 年月日 */
@property (copy, readonly, nonatomic) NSString *week;   /**< 星期 */
@property (copy, readonly, nonatomic) NSString *temp;   /**< 今日温度变化范围 */
@property (copy, readonly, nonatomic) NSString *weather;/**< 今日天气状况 */

/**
 *  @property None
 */
@property (copy, readonly, nonatomic) NSString *wind;   /**< 风向 */
@property (copy, readonly, nonatomic) NSString *dressingIndex; /**< 穿衣指数（较冷） */
@property (copy, readonly, nonatomic) NSString *dressingAdvice;/**< 穿衣建议 */
@property (copy, readonly, nonatomic) NSString *uvIndex;    /**< 紫外线强度 */
@property (copy, readonly, nonatomic) NSString *washIndex;  /**< 洗车指数 */
@property (copy, readonly, nonatomic) NSString *travelIndex;/**< 旅游指数 */
@property (copy, readonly, nonatomic) NSString *exerciseIndex;/**< 晨练指数 */

@end
