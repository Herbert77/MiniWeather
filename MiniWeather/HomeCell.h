//
//  HomeCell.h
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHHomeItem;

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellBackgroundImageView; /**< cell 背景图片 */
@property (weak, nonatomic) IBOutlet UILabel     *cityNameLabel;/**< 城市名label */
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;/**< 天气状况图标 */
@property (weak, nonatomic) IBOutlet UILabel     *tempLabel;/**< 气温label */

/**
 *  HomeCell 数据装配方法
 *
 *  @param homeItem 数据模型
 */
- (void)configureCellWithHomeItem:(HHHomeItem *)homeItem;

@end
