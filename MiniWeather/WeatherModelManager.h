//
//  WeatherModelManager.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherModel;

typedef void(^RequestCompletion)();

/**
 *  天气数据管理类
 */
@interface WeatherModelManager : NSObject

@property (strong, nonatomic) NSMutableArray *addedCities;  /**< 需要显示天气信息的城市列表 */
@property (strong, nonatomic) NSMutableDictionary *weatherModelsDic; /**< @key 城市名 @value Model */
@property (copy, nonatomic) NSArray *cityList; /**< 城市列表 */

@property (weak, nonatomic) RequestCompletion RequestCompletionBlock;

@property (weak, nonatomic) UITableView *tableView;

/**
 *  指定初始化
 *
 *  @return 该类唯一实例
 */
+ (WeatherModelManager *)sharedInstance;

/**
 *  增加一项天气数据模型到天气数据字典
 *
 *  @param cityName 城市名 
 *
 *  @return YES/NO
 */
- (BOOL)addWeatherModelForCity:(NSString *)cityName;

/**
 *  增加多项天气数据模型到天气数据字典
 *
 *  @param cityNameArray 城市名数组
 *
 *  @return YES/NO
 */
//- (BOOL)addWeatherModelsForCitys:(NSArray *)cityNameArray;

/**
 *  从挺起数据字典删去一项天气数据模型
 *
 *  @param cityName 城市名
 *
 *  @return YES/NO
 */
- (BOOL)deleteWeatherModelForCity:(NSString *)cityName;

/**
 *  @test 打印数据字典
 */
- (void)printDic;

/**
 *  请求到提供天气信息的城市列表
 *  写入 AvailableCities.plist 文件中
 */
- (void)requestCityList;

/**
 *  加载 cityList.plist 文件
 *  获取 城市列表
 */
- (void)loadCityListPlist;

@end
