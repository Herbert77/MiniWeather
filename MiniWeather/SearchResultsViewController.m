//
//  SearchResultsViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/31.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "SearchResultsViewController.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - SearchResults Updating

/**
 *  Called when the search bar becomes the first responder or when the user makes changes inside the search
 *   bar.
 *
 *  @param searchController UISearchController
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (!searchController.active) {
        
        return;
    }
    
    self.filterString = searchController.searchBar.text;
}


@end
