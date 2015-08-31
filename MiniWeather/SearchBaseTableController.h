//
//  SearchBaseTableController.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/31.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBaseTableController : UITableViewController

@property (copy, nonatomic) NSString *filterString;
@property (copy, readonly, nonatomic) NSArray *visibleResults;

@end
