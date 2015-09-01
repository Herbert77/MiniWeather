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

NSString *const CityListPath = @"http://v.juhe.cn/weather/citys";

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
    
    _addedCities = [NSMutableArray new];
    _weatherModelsDic = [NSMutableDictionary new];
    
    return self;
}

// No permission to use this method
- (instancetype) init {
    
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +(instance) sharedDtaManager " userInfo:nil];
    
    return nil;
}

#pragma mark - Add New Model

- (BOOL)addWeatherModelForCity:(NSString *)cityName withCompletionHandler:(RequestCompletion)requestCompletion {
    
    if (!cityName) {
        
        NSLog(@"ERROR: Parameter cityName is nil.");
        return NO;
    }
    
    // 检测天气数据字典中是否已经有该城市的天气 Model
    if([_weatherModelsDic objectForKey:cityName]) {
       
        NSLog(@"PROMPT: 天气数据字典中已经存在该城市天气的 Model.");
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
                            
//                            NSLog(@"responseObject: %@", responseObject);
                            
                            // 由获取的数据，装配一个天气数据 Model
                            WeatherModel *weatherModel = [WeatherModel weatherModelWithDictionary:[responseObject objectForKey:@"result"]];
                            // 添加到数据字典
                            [_addedCities addObject:weatherModel.cityName];
                            [_weatherModelsDic setObject:weatherModel forKey:weatherModel.cityName];
                            
                            requestCompletion();
                            
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
    
    //FIXME: removeObject: 可能无效
    [_addedCities removeObject:cityName];
    [_weatherModelsDic delete:object];
    
    return YES;
}

- (void)printDic {
    
    NSLog(@"addedCities: %@", _addedCities);
    NSLog(@"Dic: %@", _weatherModelsDic);
}

#pragma mark - Request cityList

- (void)requestCityListWithCompletionHandler:(RequestCityListCompletion)requestCityListCompletion {
    
    // 1. 请求到 Json 数据
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:CityListPath APIID:@"39" Parameters:nil Method:@"GET" Success:^(id responseObject) {
        
        NSArray *citysArray = [responseObject objectForKey:@"result"];
        
        NSLog(@"citysArray: %@", citysArray);
        
        // 对请求到的字典数据进行分层剥离
        NSDictionary *tempDic = [[NSDictionary alloc] init];
        
        NSMutableArray *mutableArray = [NSMutableArray new];
        [mutableArray addObject:@"北京"];
        
        NSLog(@"lastObject: %@", [mutableArray lastObject]);
        
        for (int i = 0; i < 2574 ; i++) {
            
            tempDic = [citysArray objectAtIndex:i];
            
            NSString *cityName = [tempDic objectForKey:@"city"];
            
            // 如果在数组中，该元素和上一个元素的值不相等，则把该元素添加到可变数组中
            if ([[mutableArray lastObject] isEqualToString:cityName]) {
                
            }
            else {
                
                [mutableArray addObject:cityName];
                //                NSLog(@"City_%i: %@", i,cityName);
                
            }
            
        }
        
        
        NSLog(@"readArray :\n %@", mutableArray);
        
        self.cityList = mutableArray;
        
        requestCityListCompletion(mutableArray);
        
        // 写入文件
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [path objectAtIndex:0];
        
        NSLog(@"filePath: %@", filePath);
        
        NSString *plistPath = [filePath stringByAppendingPathComponent:@"cityList.plist"];
        
        [fm createFileAtPath:plistPath contents:nil attributes:nil];
        
        [mutableArray writeToFile:plistPath atomically:YES];
        
        
    } Failure:^(NSError *error) {
        NSLog(@"error : %@", error.description);
    }];
    
}

- (NSString *)p_filePathWithFileName:(NSString *)fileName {
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *DocPath = [path objectAtIndex:0];
    NSString *filePath = [DocPath stringByAppendingPathComponent:fileName];
    
    NSLog(@"filePath %@", filePath);
    
    return filePath;
}

#pragma mark - Load cityList Plist File

- (void)loadCityListPlistWithCompletionHandler:(RequestCityListCompletion)requestCityListCompletion {
    
    NSString *fileName = [self p_filePathWithFileName:@"cityList.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        
        self.cityList = [[NSArray alloc] initWithContentsOfFile:fileName];
        
//        NSLog(@"self.cityList: %@", self.cityList);
    }
    else {
        
        [self requestCityListWithCompletionHandler:requestCityListCompletion];
    }
}

- (void)loadCityListPlist {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.cityList = tempArray;
}

@end
