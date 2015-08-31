//
//  HHNavigationController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHNavigationController.h"
#import "HHMenu.h"
#import "HHMenuItem.h"
#import "UIColor+FlatColors.h"
#import "PoliticsViewController.h"
#import "NatureViewController.h"
#import "TravelViewController.h"
#import "CultureViewController.h"
#import "HHBaseViewController.h"

#import "HomeViewController.h"
#import "ProfileViewController.h"

@interface HHNavigationController ()

@property (strong, nonatomic) HHMenu *menu;

@property (strong, nonatomic) NSMutableArray *controllerArray;

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) ProfileViewController *profileViewController;
@property (strong, nonatomic) CultureViewController *cultureController;
@property (strong, nonatomic) NatureViewController *natureController;

@end

@implementation HHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[WeatherModelManager sharedInstance] addWeatherModelForCity:@"密云"];
//    [[WeatherModelManager sharedInstance] printDic];
    
//    [[WeatherModelManager sharedInstance] requestCityList];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    HHMenuItem *home    = [HHMenuItem initWithIconImageName:@"weather" withColorScheme:[UIColor flatWisteriaColor]];
    HHMenuItem *culture = [HHMenuItem initWithIconImageName:@"location" withColorScheme:[UIColor flatSunFlowerColor]];
    HHMenuItem *profile = [HHMenuItem initWithIconImageName:@"introduction" withColorScheme:[UIColor flatPumpkinColor]];
    HHMenuItem *nature  = [HHMenuItem initWithIconImageName:@"settings" withColorScheme:[UIColor flatSilverColor]];
    
    [self initAllViewControllers];
    
    
    _homeViewController.menuItem = home;
    self.viewControllers = @[_homeViewController];

    home.completionBlock = ^{
        
        self.viewControllers = @[_homeViewController];
    };
    
    
    __weak typeof(HHMenuItem) *weakCulture = culture;
    culture.completionBlock = ^{
        
        _cultureController.menuItem = weakCulture;
        self.viewControllers = @[_cultureController];
    };
    
    __weak typeof(HHMenuItem) *weakProfile = profile;
    profile.completionBlock = ^{
        
        _profileViewController.menuItem = weakProfile;
        self.viewControllers = @[_profileViewController];
    };
    
    
    __weak typeof(HHMenuItem) *weakNature = nature;
    nature.completionBlock = ^{
        
        _natureController.menuItem = weakNature;
        self.viewControllers = @[_natureController];
    };
    
    
    NSArray *menuItems = @[home, culture, profile, nature];
    self.menu = [[HHMenu alloc] initWithMenuItems:menuItems forViewController:self];
    
}

#pragma mark -  初始化所有被跳转的视图控制器

- (void)initAllViewControllers {
    
    _homeViewController    = [[HomeViewController alloc] init];
    _cultureController     = [[CultureViewController alloc] init];
    _profileViewController = [[ProfileViewController alloc] init];
    _natureController      = [[NatureViewController alloc] init];
    
    
    [[(HHBaseViewController *)_homeViewController buttonHamburger] designateState:LBHamburgerButtonStateHamburger]; /**< 第一个控制器的其实状态值为 LBHamburgerButtonStateHamburger */
    
    [[(HHBaseViewController *)_cultureController buttonHamburger] designateState:LBHamburgerButtonStateNotHamburger]; /**< 第二个控制器的其实状态值为 LBHamburgerButtonStateNotHamburger */
    
    [[(HHBaseViewController *)_profileViewController buttonHamburger] designateState:LBHamburgerButtonStateNotHamburger]; /**< 第三个控制器的其实状态值为 LBHamburgerButtonStateNotHamburger */
    
    [[(HHBaseViewController *)_natureController buttonHamburger] designateState:LBHamburgerButtonStateNotHamburger]; /**< 第三个控制器的其实状态值为 LBHamburgerButtonStateNotHamburger */
    
}


- (void)showHHMenu {
    
    /**< 该导航控制器 HHNaivgationController 和 HHMenu 相互引用
        导航控制器对菜单为强引用
        菜单对用来获取导航控制器中强属性（controllerArray）的属性（controllerArray）为弱引用
        */
    _controllerArray = [NSMutableArray arrayWithArray:@[_homeViewController, _cultureController,_profileViewController, _natureController]];
    self.menu.controllerArray = _controllerArray;
    
    /**< 显示菜单 */
    [self.menu showMenu];
    
    
}


@end
