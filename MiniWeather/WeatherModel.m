//
//  WeatherModel.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "WeatherModel.h"
#import "TWeatherModel.h"
#import "FWeatherModel.h"

@interface WeatherModel ()

@property (copy, nonatomic) NSString *cityName;

@end

@implementation WeatherModel

+ (instancetype)weatherModelWithDictionary:(NSDictionary *)resultDic {
    
    if (!resultDic) {
        
        NSLog(@"ERROR: Parameter resultDic is nil.");
        return nil;
    }
    
    WeatherModel *weatherModel = [WeatherModel new];
    
    if (weatherModel) {
        
        // tWeatherModel
        NSError *error = nil;
        weatherModel.tWeatherModel = [MTLJSONAdapter modelOfClass:TWeatherModel.class fromJSONDictionary:resultDic error:&error];
        
//        NSArray *testArray = [resultDic objectForKey:@"future"];
//        NSLog(@"%@", testArray);
        
        // fWeatherModel
        weatherModel.fWeatherModel = [FWeatherModel fWeatherModelWithDictionary:[resultDic objectForKey:@"future"]];
        
        // cityName
        if (weatherModel.tWeatherModel) {
            
            weatherModel.cityName = weatherModel.tWeatherModel.city;
        } else {
            
            NSLog(@"ERROR: weatherModel.tWeatherModel is nil");
        }
    }
    
    return weatherModel;
}

@end
