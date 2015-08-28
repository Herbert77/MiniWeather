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
//- (id)copyWithZone:(NSZone *)zone {
//    
//    FOneDayModel *fOneDayModel = [[self.class allocWithZone:zone] init];
//    
//    fOneDayModel->_fOneDay_temp    = self.fOneDay_temp;
//    fOneDayModel->_fOneDay_weather = self.fOneDay_weather;
//    fOneDayModel->_fOneDay_week    = self.fOneDay_week;
//    fOneDayModel->_fOneDay_date    = self.fOneDay_date;
//    
//    return fOneDayModel;
//}

- (void)print {
    
    NSLog(@"temp %@ \n weather %@ \n date %@ \n week %@ \n", _fOneDay_temp, _fOneDay_weather, _fOneDay_date, _fOneDay_week);
}

@end

#pragma mark - FWeatherModel Implementation

@implementation FWeatherModel

+ (instancetype)fWeatherModelWithDictionary:(NSDictionary *)futureDic {
    
    if (!futureDic) {
        
        NSLog(@"ERROR: Parameter futureDic is nil");
        return nil;
    }
    
    FWeatherModel *fWeatherModel = [FWeatherModel new];
    
    if (fWeatherModel) {
        
        fWeatherModel.fOneDayModelsArray = [[NSMutableArray alloc] init];
    }
    
    // 未来 6天的天气Model被依次创建，并添加到 array 中
    for (int i=1; i<=6; i++) {
        
        NSString *key = [fWeatherModel p_futureDicKeyForNumberOfDays:i];
        NSDictionary *tempDic = [futureDic objectForKey:key];
        
        // 1. Create
        FOneDayModel *fOneDayModel = [[FOneDayModel alloc] initWithTemp:[tempDic objectForKey:@"temperature"] weather:[tempDic objectForKey:@"weather"] week:[tempDic objectForKey:@"week"] date:[tempDic objectForKey:@"date"]];
        
//        [fOneDayModel print];
        
        // 2. Add to array
        [fWeatherModel.fOneDayModelsArray addObject:fOneDayModel];
    }
    
    return fWeatherModel;
}

/**
 *  返回外来几天的日期字符串（用以拼接出获取未来天气的键值，如：day_20150827）
 *
 *  @param dayNumber 1（代表明天） 2（代表后天） 3（代表大后天）以此类推
 *
 *  @return date
 */
- (NSString *)p_dateForNumberOfDays:(int)numberOfDays {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSTimeInterval secondsPerDay = 24*60*60;

    return [dateFormatter stringFromDate:[today dateByAddingTimeInterval:numberOfDays*secondsPerDay]];
}

/**
 *  拼接出键值 （ 如：day_20150827）
 *
 *  @param numberOfDays 天数
 *
 *  @return 键
 */
- (NSString *)p_futureDicKeyForNumberOfDays:(int)numberOfDays {
    
    NSString *string = [self p_dateForNumberOfDays:numberOfDays];
    return [@"day_" stringByAppendingString:string];
}

#pragma mark - Encode and Decode

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //FIXME: 对 fOneDayModelsArray 进行 decode
#warning FIXME
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    NSInteger count = [self.fOneDayModelsArray count];

    for (int i=0; i<count; i++) {
        
        NSString *key = [NSString stringWithFormat:@"fOneDayModel_%d", i];
        [aCoder encodeObject:[self.fOneDayModelsArray objectAtIndex:i] forKey:key];
    }
}

@end
