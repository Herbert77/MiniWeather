//
//  HHHomeItem.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHHomeItem.h"

@implementation HHHomeItem


+ (instancetype)initWithCellBackgroundImageName:(NSString *)cellBackgroundImageName cityName:(NSString *)cityName weatherImageName:(NSString *)weatherImageName temperature:(NSString *)temperature {
    
    HHHomeItem *homeItem = [HHHomeItem new];
    
    if (homeItem) {
        
        homeItem.cellBackgroundImageName = cellBackgroundImageName;
        homeItem.cityName = cityName;
        homeItem.weatherImageName = weatherImageName;
        homeItem.temperature = temperature;
    }
    
    return homeItem;
}

@end
