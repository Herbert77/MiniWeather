//
//  WeatherModelManager.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "WeatherModelManager.h"
#import "WeatherModel.h"

@implementation WeatherModelManager

#pragma mark - Singleton WeatherModelManager

+ (WeatherModelManager *)sharedInstance {
    
    static dispatch_once_t onceToken;
    static WeatherModelManager *manager;
    
    dispatch_once(&onceToken, ^{
        
        manager = [self new];
    });
    
    return manager;
}

@end
