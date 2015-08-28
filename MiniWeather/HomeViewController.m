//
//  HomeViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"

#define HomeCellIdentifier @"HomeCell"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *homeTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initHomeTableView];
    
//    UIView 
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = (HomeCell*)[tableView dequeueReusableCellWithIdentifier:HomeCellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeCellIdentifier];
    }
    
    //TODO: Config the cell's content
    cell.cellBackgroundImageView.image = [UIImage imageNamed:@"sunnyBackgroundImage"];
    cell.weatherImageView.image = [UIImage imageNamed:@"sunnyIcon"];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
