//
//  HHBaseViewController.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHBaseViewController.h"
#import "HHNavigationController.h"
#import "HHMenuItem.h"
#import "UIColor+FlatColors.h"

@interface HHBaseViewController ()

@end

@implementation HHBaseViewController

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    /**< 在初始化方法中创建 菜单按钮的原因：
        
        菜单按钮的状态在初始化时，默认为 LBHamburgerButtonStateHamburger
        问题：当使用菜单，在不同的视图控制器之间跳转时，发现bug（跳转到的控制器的菜单按钮没有动画）
        原因：跳转到的控制器的菜单按钮的 state 起始为 LBHamburgerButtonStateHamburger
        无法完成状态的转换，也就没有动画的产生。
        解决： 
            1.在视图控制器初始化的时候，就创建菜单按钮，以便在后续的方法中修改 state 的起始值为 LBHamburgerButtonStateNotHamburger，该修改位于 HHNavigationController类->initAllViewControllers方法中。
     */
    _buttonHamburger = [[LBHamburgerButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)
                                              withHamburgerType:LBHamburgerButtonTypeCloseButton
                                                      lineWidth:26
                                                     lineHeight:18/6.0
                                                    lineSpacing:4
                                                     lineCenter:CGPointMake(20, 20)
                                                          color:[UIColor whiteColor]];
    
    [_buttonHamburger setHamburgerAnimationDuration:0.4f];
    [_buttonHamburger setCenter:CGPointMake(20+20, SCREEN_HEIGHT-20-20)];
    [_buttonHamburger setBackgroundColor:[UIColor clearColor]];
    [_buttonHamburger addTarget:self.navigationController action:@selector(showHHMenu) forControlEvents:UIControlEventTouchUpInside];

    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *iconImage = [UIImage imageNamed:@"burgerButton"];
//    UIBarButtonItem *icon = [[UIBarButtonItem alloc] initWithImage:iconImage
//                                                             style:UIBarButtonItemStylePlain
//                                                            target:self.navigationController
//                                                            action:@selector(showMenu)];
    
    
    
//    icon.tintColor = [UIColor whiteColor];
//    
//    self.navigationItem.rightBarButtonItem = icon;
    
    
    self.navigationItem.titleView = [UIView new];
    
    NSLog(@"self's class name: %@", NSStringFromClass([self class]));
    
    self.view.backgroundColor = self.menuItem.colorScheme;
    
    // 把汉堡菜单按钮添加到子视图上
    [self.view addSubview:_buttonHamburger];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
