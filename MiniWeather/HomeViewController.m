//
//  HomeViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "SearchBarEmbeddedInNavigationBarViewController.h"

#define HomeCellIdentifier @"HomeCell"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *homeTableView;
@property (strong, nonatomic) UIButton *addButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomeTableView];
    
    [self initAddButton];
    
    // Callback
    [[WeatherModelManager sharedInstance] setRequestCompletionBlock: ^{
        
        [_homeTableView reloadData];
        
    }];
}

#pragma mark - Initilization

- (void)initHomeTableView {
    

    _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, self.view.frame.size.width, self.view.frame.size.height-80) style:UITableViewStylePlain];
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homeTableView.backgroundColor = [UIColor flatWisteriaColor];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    
//    [_homeTableView registerClass:[HomeCell class] forCellReuseIdentifier:HomeCellIdentifier];
    [_homeTableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:HomeCellIdentifier];
    
    [self.view addSubview:_homeTableView];
}

- (void)initAddButton {
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0, 0, 28, 28);
    [_addButton setCenter:CGPointMake(SCREEN_WIDTH-40, SCREEN_HEIGHT-40)];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"addButton"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_addButton];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [[[WeatherModelManager sharedInstance] addedCities] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeCellIdentifier];
    }

    
    //TODO: Config the cell's content
    cell.cityNameLabel.text = [[[WeatherModelManager sharedInstance] addedCities] objectAtIndex:indexPath.row];
    cell.cellBackgroundImageView.image = [UIImage imageNamed:@"sunnyBackgroundImage"];
    cell.weatherImageView.image = [UIImage imageNamed:@"sunnyIcon"];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

#pragma mark - Action

// 搜索
- (void)addButtonPressed:(id)sender {
    
    SearchBarEmbeddedInNavigationBarViewController *searchBarEmbeddedInNavigationViewController = [[SearchBarEmbeddedInNavigationBarViewController alloc] init];
    
    [self.navigationController pushViewController:searchBarEmbeddedInNavigationViewController animated:YES];
}


@end
