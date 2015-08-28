//
//  FWeatherModel.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  未来 某一天的天气数据 Model
 */
@interface FOneDayModel : NSObject <NSCoding>

@property (strong, nonatomic) NSString *fOneDay_temp; /**< 气温区间 */
@property (strong, nonatomic) NSString *fOneDay_weather; /**< 天气状况 */
@property (strong, nonatomic) NSString *fOneDay_week; /**< 星期 */
@property (strong, nonatomic) NSString *fOneDay_date; /**< 日期 （20140804） */

- (instancetype)initWithTemp:(NSString *)temp weather:(NSString *)weather week:(NSString *)week date:(NSString *)date;

- (void)print;

@end

/**
 *  未来 6天的天气数据 Model
 */
@interface FWeatherModel : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *fOneDayModelsArray; /**< 未来 6天的天气数据数组 */

/**
 *  初始化方法
 *
 *  @param futureArray 从 Json 数据中，由键 @“future” 获取到的数组值
 *
 *  @return 返回该对象实例
 */
+ (instancetype)fWeatherModelWithDictionary:(NSDictionary *)futureDic;



@end
