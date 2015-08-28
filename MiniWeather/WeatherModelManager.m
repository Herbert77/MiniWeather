//
//  WeatherModelManager.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "WeatherModelManager.h"
#import "WeatherModel.h"


NSString *const PMPath = @"http://web.juhe.cn:8080/environment/air/pm";
NSString *const PMApi_Id = @"33";
NSString *const WeatherPath = @"http://v.juhe.cn/weather/index";
NSString *const WeatherAPI_Id = @"39";
NSString *const method = @"GET";

@implementation WeatherModelManager

#pragma mark - Singleton WeatherModelManager

+ (WeatherModelManager *)sharedInstance {
    
    static dispatch_once_t onceToken;
    static WeatherModelManager *manager;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] initWithPrivate];
    });
    
    return manager;
}

- (instancetype)initWithPrivate {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _weatherModelsDic = [NSMutableDictionary new];
    
    return self;
}

// No permission to use this method
- (instancetype) init {
    
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +(instance) sharedDtaManager " userInfo:nil];
    
    return nil;
}

#pragma mark - Add New Model

- (BOOL)addWeatherModelForCity:(NSString *)cityName {
    
    if (!cityName) {
        
        NSLog(@"ERROR: Parameter cityName is nil.");
        return NO;
    }
    
    __block BOOL flag = YES;
    JHAPISDK *juheApi = [JHAPISDK shareJHAPISDK];
    NSDictionary *weather_Parameters = @{@"cityname":cityName, @"dtype":@"json"};
    
    [juheApi executeWorkWithAPI:WeatherPath
                          APIID:WeatherAPI_Id
                     Parameters:weather_Parameters
                         Method:method
                        Success:^(id responseObject) {
                            
                            NSLog(@"responseObject: %@", responseObject);
                            
                            // 由获取的数据，装配一个天气数据 Model
                            WeatherModel *weatherModel = [WeatherModel weatherModelWithDictionary:[responseObject objectForKey:@"result"]];
                            // 添加到数据字典
                            [_weatherModelsDic setObject:weatherModel forKey:weatherModel.cityName];
                            
                        } Failure:^(NSError *error) {
                            
                            flag = NO;
                            NSLog(@"ERROR: %@", error.description);
                        }];
    
    
    return flag;
}

//- (BOOL)addWeatherModelsForCitys:(NSArray *)cityNameArray {
//    
//
//
//}

#pragma mark - Delete Existed Model

- (BOOL)deleteWeatherModelForCity:(NSString *)cityName {
    
    if (!cityName) {
        
        NSLog(@"ERROR: Parameter cityName is nil.");
        return NO;
    }
    
    id object = [_weatherModelsDic objectForKey:cityName];
    
    if (!object) {
        // 字典中没有这个城市的天气
        NSLog(@"There is no responsed object in dic");
        return NO;
    }
    
    [_weatherModelsDic delete:object];
    
    return YES;
}

- (void)printDic {
    
    NSLog(@"Dic: %@", _weatherModelsDic);
}

@end
