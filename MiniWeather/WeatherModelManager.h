//
//  WeatherModelManager.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherModel;

/**
 *  天气数据管理类
 */
@interface WeatherModelManager : NSObject

@property (copy, nonatomic) NSMutableArray *weatherModelsArray; /**< 所有天气 Model */

/**
 *  指定初始化
 *
 *  @return 该类唯一实例
 */
+ (WeatherModelManager *)sharedInstance;



@end
