//
//  SettingsViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/9/1.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *settingsTableView;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSettingsTableView];
}

#pragma mark - Initilization

- (void)initSettingsTableView {
    
    _settingsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-80) style:UITableViewStylePlain];
    _settingsTableView.backgroundColor = [UIColor flatPeterRiverColor];
    _settingsTableView.delegate = self;
    _settingsTableView.dataSource = self;
    
    _settingsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingsTableView.scrollEnabled = NO;
    
    [self.view addSubview:_settingsTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingsCell"];

    cell.textLabel.text = @"设置";
    
    return cell;
}

@end
