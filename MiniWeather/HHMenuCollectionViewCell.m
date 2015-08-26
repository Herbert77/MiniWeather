//
//  HHMenuCollectionViewCell.m
//  HHDropMenu
//
//  Created by 胡传业 on 15/8/24.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HHMenuCollectionViewCell.h"
#import "HHMenuItem.h"
#import "UIColor+FlatColors.h"

#define MenuBackroundColor [UIColor colorWithRed:0.41 green:0.42 blue:0.45 alpha:1.0]
#define MenuCellSelectedColor [UIColor colorWithRed:0.54 green:0.55 blue:0.57 alpha:1.0]

@interface HHMenuCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;  /**< 菜单子项的图标 */

@end

@implementation HHMenuCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = MenuBackroundColor;

}

#pragma mark - Override Setter
- (void)setMenuItem:(HHMenuItem *)menuItem {
    
    _menuItem = menuItem;
    NSString *imageName = [NSString stringWithFormat:@"%@", [_menuItem iconImageName]];
    NSLog(@"imageName %@", imageName);
    _iconImageView.image = [UIImage imageNamed:imageName];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    [UIView animateWithDuration:0.3f animations:^{
//        self.backgroundColor = (selected) ? [UIColor colorWithWhite:0.1f alpha:0.2f] : [UIColor lightGrayColor];
        self.backgroundColor = (selected) ? MenuCellSelectedColor : MenuBackroundColor;
    }];
}

@end
