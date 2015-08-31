//
//  SearchBaseTableController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/31.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "SearchBaseTableController.h"

NSString *const SearchBaseTableControllerCellIdentifier = @"searchResultsCell";
#define CityCellIdentifier @"CityCell"

@interface SearchBaseTableController ()

@property (copy, nonatomic) NSArray *allResults;
@property (copy, readwrite, nonatomic) NSArray *visibleResults;

@end

@implementation SearchBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载 .plist 文件，获取 城市列表
    [[WeatherModelManager sharedInstance] loadCityListPlist];
    
    self.allResults = [[WeatherModelManager sharedInstance] cityList];
    self.visibleResults = self.allResults;
    
    [self.tableView setFrame:CGRectMake(0, NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationBar_HEIGHT)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CityCellIdentifier];
}

#pragma mark - Override Setter

- (void)setFilterString:(NSString *)filterString {
    
    _filterString = filterString;
    
    if (!filterString || filterString.length <= 0) {
        
        self.visibleResults = self.allResults;
    }
    else {
        
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", filterString];
        self.visibleResults = [self.allResults filteredArrayUsingPredicate:filterPredicate];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.visibleResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CityCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CityCellIdentifier];
    }
    
    cell.textLabel.text = self.visibleResults[indexPath.row];
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //TODO: Handle the selection
    [[WeatherModelManager sharedInstance] addWeatherModelForCity:[self.visibleResults objectAtIndex:indexPath.row]];
    
    // Post a notification for loading animation.
    
}


@end
