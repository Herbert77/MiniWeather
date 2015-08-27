//
//  TWeatherModel.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "TWeatherModel.h"

@implementation TWeatherModel

#pragma mark - MTLJSONSerializing Delegate

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"currentTemp" : @"sk.temp",
             @"windDirection" : @"sk.wind_direction",
             @"windStrength" : @"sk.wind_strength",
             @"humidity" : @"sk.humidity",
             @"currentTime" : @"sk.time",
             
             @"city" : @"today.city",
             @"date" : @"today.date_y",
             @"week" : @"today.week",
             @"temp" : @"today.temperature",
             @"weather" : @"today.weather",
             
             @"wind" : @"wind",
             @"dressingIndex" : @"dressing_index",
             @"dressingAdvice" : @"dressing_advice",
             @"uvIndex" : @"uv_index",
             @"washIndex" : @"wash_index",
             @"travelIndex" : @"travel_index",
             @"exerciseIndex" : @"exercise_index"
             
             };
}

@end
