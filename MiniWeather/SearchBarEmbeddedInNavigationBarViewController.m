//
//  SearchBarEmbeddedInNavigationBarViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/31.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "SearchBarEmbeddedInNavigationBarViewController.h"
#import "SearchResultsViewController.h"

@interface SearchBarEmbeddedInNavigationBarViewController ()

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation SearchBarEmbeddedInNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSearchController];
    
}

#pragma mark - Initilization

- (void) initSearchController {
    
    SearchResultsViewController *searchResultController = [[SearchResultsViewController alloc] init];
    
    // 创建 searchController 并让其执行结果更新
    _searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultController];
    _searchController.searchResultsUpdater = searchResultController;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
    // 配置 searchController 的 searchBar
    _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchController.searchBar.placeholder = NSLocalizedString(@"城市", nil);
    
    // 设置 placeholder 颜色
    for (UIView *subView in [[self.searchController.searchBar.subviews lastObject] subviews]) {
        
        if ([subView isKindOfClass:[UITextField class]]) {
            
            UITextField *textField = (UITextField *)subView;
            [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        else if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            
            [subView removeFromSuperview];
        }
        else if ([subView isKindOfClass:[UIButton class]]) {
            NSLog(@"SUBVIEW");
            UIButton *button = (UIButton *)subView;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button  setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor purpleColor]];
        }
    }
    
    
    
    // searchBar 嵌入 navigationBar
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
}




@end
