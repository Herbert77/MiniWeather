//
//  HHMenu.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHMenu.h"
#import "AppDelegate.h"
#import "HHMenuItem.h"
#import "HHMenuCollectionViewCell.h"

#define MenuBackroundColor [UIColor colorWithRed:0.41 green:0.42 blue:0.45 alpha:1.0]
#define MenuCellSelectedColor [UIColor colorWithRed:0.54 green:0.55 blue:0.57 alpha:1.0]

static const CGFloat kMaxBlackMaskAlpha = 0.8f;
static const CGFloat menuItemHeight = 75.0f;
static const CGFloat menuHeight = 79.0f;
static const NSTimeInterval menuOpenAnimationDuration = 0.4f;
static const NSTimeInterval menuCloseAnimationDuration = 0.3f;
static  NSString *const menuItemCellReusableID = @"menuItemCellReusableID";
static  NSString *const menuCollectionViewHeader = @"menuCollectionViewHeader";

typedef NS_OPTIONS(NSInteger, MenuState) {
    Closed,
    Open,
    Showing
};

@interface HHMenu () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UICollectionView *menuCollectionView;
@property (nonatomic) UIViewController *contentViewController;
@property (nonatomic) UIView *animationMask;
@property (nonatomic) NSArray *menuItems;
@property (nonatomic) MenuState state;
@property (nonatomic) CGFloat menuDefaultHeight;

@end

@implementation HHMenu

- (instancetype)initWithMenuItems:(NSArray *)menuItems forViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
    
        
        self.menuItems = menuItems;
        self.backgroundColor = MenuBackroundColor;
        self.contentViewController = viewController;
        [self addSubview:self.menuCollectionView];
        [self insertSubview:self.animationMask atIndex:0];
        
    }
    return self;
}
#pragma mark - Properties

- (CGFloat)menuDefaultHeight {
    
    if (!_menuCollectionView) {
        return menuHeight;
    }
    
    return self.menuCollectionView.contentSize.height;
}

- (UICollectionView *)menuCollectionView {
    
    if (!_menuCollectionView) {
        
        
        CGFloat screenWidth = CGRectGetWidth(self.frame);
        CGFloat screenHeight = CGRectGetHeight(self.frame);
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(screenWidth/4 - 0.5, menuItemHeight);
        //		layout.headerReferenceSize = CGSizeMake(screenWidth, headerHeight);
        layout.minimumInteritemSpacing = 0.25;
        layout.minimumLineSpacing = 0.5;
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
        
        _menuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, screenHeight-self.menuDefaultHeight, screenWidth, self.menuDefaultHeight) collectionViewLayout:layout];
        _menuCollectionView.delegate = self;
        _menuCollectionView.dataSource = self;
//        _menuCollectionView.backgroundColor = [UIColor colorWithWhite:0.3f alpha:0.5f];
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        
        [_menuCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HHMenuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:menuItemCellReusableID];
//        [_menuCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EBHeaderCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:menuCollectionViewHeader];
//        
        /*Politics is selected by default, make sure it is reflected*/
        [_menuCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionTop];
        
    }
    
    return _menuCollectionView;
}

- (UIView *)animationMask {
    
    if (!_animationMask) {
        
        _animationMask = [[UIView alloc] initWithFrame:self.bounds];
        _animationMask.backgroundColor = [UIColor lightGrayColor];
        _animationMask.alpha = 0.0;
        _animationMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return _animationMask;
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    
    if (contentViewController == _contentViewController) {
        return;
    }
    
    _contentViewController = contentViewController;
    _contentViewController.view.backgroundColor = [UIColor clearColor];
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
//    [_contentViewController.view addGestureRecognizer:pan];
    
    UIViewController *menuView = [UIViewController new];
    menuView.view = self;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = menuView;
    [appDelegate.window addSubview:_contentViewController.view];
}

//#pragma mark - Pan
//
//- (void)didPan:(UIPanGestureRecognizer *)gesture {
//    
//    CGPoint viewCenter = gesture.view.center;
//    
//    CGPoint translation = [gesture translationInView:gesture.view.superview];
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    
//    //    NSLog(@"translation (%f,%f)", translation.x, translation.y);
//    //    NSLog(@"gesture.view.superview %@", gesture.view.superview);
//    //    NSLog(@"gesture.view.center (%f,%f)", viewCenter.x, viewCenter.y);
//    
//    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
//        
//        if (viewCenter.y >= screenSize.height/2 && viewCenter.y <= screenSize.height/2 + self.menuDefaultHeight) {
//            
//            //TODO:unapprehended
//            viewCenter.y = fabs(viewCenter.y + translation.y);
//            
//            if (viewCenter.y >= screenSize.height/2 && viewCenter.y <= screenSize.height/2 + self.menuDefaultHeight) {
//                //                NSLog(@"viewCenter.y %f %f", viewCenter.x, viewCenter.y);
//                self.contentViewController.view.center = viewCenter;
//                
//                CGFloat transformPercentage = 1- fabs((CGRectGetMinY(self.contentViewController.view.frame) / self.menuDefaultHeight));
//                [self transformAtPercentage:transformPercentage];
//                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//                [self bringSubviewToFront:self.animationMask];
//                
//            }
//        }
//        [gesture setTranslation:CGPointZero inView:self.contentViewController.view];
//        
//    }else if (gesture.state == UIGestureRecognizerStateEnded){
//        
//        CGPoint velocity = [gesture velocityInView:gesture.view.superview];
//        
//        NSLog(@"velocity (%f,%f)", velocity.x, velocity.y);
//        
//        if (velocity.y > menuThresholdVelocity) {
//            
//            CGFloat menuOpenOffset = screenSize.height/2 + self.menuDefaultHeight;
//            NSTimeInterval duration = (menuOpenOffset - self.contentViewController.view.center.y) / velocity.y;
//            [self openMenuWithDuration:duration];
//            return;
//            
//        }else if (velocity.y < -menuCloseVelocity){
//            
//            CGFloat menuOpenOffset = screenSize.height/2 + self.menuDefaultHeight;
//            NSTimeInterval duration = (menuOpenOffset - self.contentViewController.view.center.y) / fabs(velocity.y);
//            
//            [self closeMenuWithDuration:duration];
//            return;
//        }
//        
//        if (viewCenter.y < self.contentViewController.view.frame.size.height) {
//            
//            [self closeMenu];
//        }else {
//            [self openMenu];
//        }
//    }
//}

- (void)showMenu {

    if (self.state == Closed) {
        [self openMenu];
    }else {
        [self closeMenu];
    }
}

- (void)openMenu {
    
    /**< 汉堡菜单按钮 状态转换
        在打开菜单时，汉堡菜单按钮状态转变为 非汉堡状*/
    for (HHBaseViewController* vc in self.controllerArray) {
        
        [vc.buttonHamburger setState:LBHamburgerButtonStateNotHamburger];
        NSLog(@"%u", vc.buttonHamburger.hamburgerState);
    }
    
    [self openMenuWithDuration:menuOpenAnimationDuration];
}

- (void)openMenuWithDuration:(NSTimeInterval)duration {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [UIView animateWithDuration:duration
                          delay:0.0f
         usingSpringWithDamping:0.56
          initialSpringVelocity:20
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         //TODO: 在动画期间，collectionView 不能再被点击
                         self.menuCollectionView.userInteractionEnabled = NO;
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x,  screenSize.height/2 - self.menuDefaultHeight);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         self.menuCollectionView.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
                         
                         self.animationMask.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         self.menuCollectionView.userInteractionEnabled = YES;
                         
                         self.state = Open;
                         [self sendSubviewToBack:self.animationMask];
                     }];
}

- (void)closeMenu {
    
    /**< 汉堡菜单按钮 状态转换
     在关闭菜单时，汉堡菜单按钮状态转变为 汉堡状*/
    for (HHBaseViewController* vc in self.controllerArray) {
        NSLog(@"self.controllerArray count : %lu", (unsigned long)[self.controllerArray count]);
        [vc.buttonHamburger setState:LBHamburgerButtonStateHamburger];
    }

    [self closeMenuWithDuration:menuCloseAnimationDuration];
}

- (void)closeMenuWithDuration:(NSTimeInterval)duration {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [UIView animateWithDuration:duration
                     animations:^{

                         //TODO: 在动画期间，collectionView 不能再被点击
                         self.menuCollectionView.userInteractionEnabled = NO;
                         
                         [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                         self.contentViewController.view.center = CGPointMake(self.contentViewController.view.center.x, screenSize.height/2);
                         
                         CGAffineTransform transf = CGAffineTransformIdentity;
                         self.menuCollectionView.transform = CGAffineTransformScale(transf, 1.0f, 1.0f);
                         
//                         self.animationMask.alpha = kMaxBlackMaskAlpha;
                     } completion:^(BOOL finished) {
                         self.menuCollectionView.userInteractionEnabled = YES;
                         self.state = Closed;
                         [self bringSubviewToFront:self.animationMask];
                     }];
}

#pragma mark - Set the required transformation based on percentage
- (void) transformAtPercentage:(CGFloat)percentage {
    
    CGAffineTransform transf = CGAffineTransformIdentity;
    CGFloat newTransformValue =  fabs((percentage)/10 - 1);
    CGFloat newAlphaValue = percentage* kMaxBlackMaskAlpha;
    self.menuCollectionView.transform = CGAffineTransformScale(transf,newTransformValue,newTransformValue);
    self.animationMask.alpha = newAlphaValue;
}

#pragma mark - Menu Collection View Delegate/Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section {
    
    return self.menuItems.count;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//	if (kind == UICollectionElementKindSectionHeader) {
//
//		EBHeaderCollectionReusableView *header = (EBHeaderCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:menuCollectionViewHeader forIndexPath:indexPath];
//		header.titleText = @"Windmill";
//		header.delegate = self;
//		return header;
//	}
//	return nil;
//}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HHMenuCollectionViewCell *cell = (HHMenuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:menuItemCellReusableID forIndexPath:indexPath];
    HHMenuItem *item = [self.menuItems objectAtIndex:indexPath.row];
    [cell setMenuItem:item];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HHMenuItem *item = [self.menuItems objectAtIndex:indexPath.row];
    item.completionBlock();
    [self performSelector:@selector(showMenu) withObject:nil afterDelay:0.0f];
}

//#pragma mark - Header delegate
//
//- (void)didPressSettings {
//    
//    NSIndexPath *selectedIndex = [[self.menuCollectionView indexPathsForSelectedItems] firstObject];
//    [self.menuCollectionView deselectItemAtIndexPath:selectedIndex animated:YES];
//    [self performSelector:@selector(showMenu) withObject:nil afterDelay:0.2f];
//    
//}


@end
