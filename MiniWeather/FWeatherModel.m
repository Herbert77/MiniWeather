//
//  FWeatherModel.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/27.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "FWeatherModel.h"

#pragma mark - FOneDayModel Implementation

@implementation FOneDayModel

- (instancetype)initWithTemp:(NSString *)temp weather:(NSString *)weather week:(NSString *)week date:(NSString *)date {
    
    self = [super init];
    
    if (self) {
        
        _fOneDay_temp    = temp;
        _fOneDay_weather = weather;
        _fOneDay_week    = week;
        _fOneDay_date    = date;
    }
    
    return self;
}

#pragma mark - Encode And Decode

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _fOneDay_temp    = [aDecoder decodeObjectForKey:@"_fOneDay_temp"];
    _fOneDay_weather = [aDecoder decodeObjectForKey:@"_fOneDay_weather"];
    _fOneDay_week    = [aDecoder decodeObjectForKey:@"_fOneDay_week"];
    _fOneDay_date    = [aDecoder decodeObjectForKey:@"_fOneDay_date"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    if (_fOneDay_temp != nil) {
        [aCoder encodeObject:_fOneDay_temp forKey:@"_fOneDay_temp"];
    }
    if (_fOneDay_weather != nil) {
        [aCoder encodeObject:_fOneDay_weather forKey:@"_fOneDay_weather"];
    }
    if (_fOneDay_week != nil) {
        [aCoder encodeObject:_fOneDay_week forKey:@"_fOneDay_week"];
    }
    if (_fOneDay_date != nil) {
        [aCoder encodeObject:_fOneDay_date forKey:@"_fOneDay_date"];
    }
}

//???:unapprehended
- (id)copyWithZone:(NSZone *)zone {
    
    FOneDayModel *fOneDayModel = [[self.class allocWithZone:zone] init];
    
    fOneDayModel->_fOneDay_temp    = self.fOneDay_temp;
    fOneDayModel->_fOneDay_weather = self.fOneDay_weather;
    fOneDayModel->_fOneDay_week    = self.fOneDay_week;
    fOneDayModel->_fOneDay_date    = self.fOneDay_date;
    
    return fOneDayModel;
}

@end

#pragma mark - FWeatherModel Implementation

@implementation FWeatherModel

+ (instancetype)fWeatherModelWithArray:(NSArray *)futureArray {
    
    if (!futureArray) {
        
        NSLog(@"ERROR: Parameter futureArray is nil");
        return nil;
    }
    
    FWeatherModel *fWeatherModel = [FWeatherModel new];
    
    if (fWeatherModel) {
        
        fWeatherModel.fOneDayModelsArray = [NSMutableArray new];
    }
    
    // 未来 6天的天气Model被依次创建，并添加到 array 中
    for (int i=1; i<=6; i++) {
        
        // 1. Create
        FOneDayModel *fOneDayModel = [[FOneDayModel alloc] initWithTemp:[futureArray[i] objectForKey:@"temperature"] weather:[futureArray[i] objectForKey:@"weather"] week:[futureArray[i] objectForKey:@"week"] date:[futureArray[i] objectForKey:@"date"]];
        
        // 2. Add to array
        [fWeatherModel.fOneDayModelsArray addObject:fOneDayModel];
    }
    
    
    return nil;
}

@end
