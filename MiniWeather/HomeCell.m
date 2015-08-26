//
//  HomeCell.m
//  MiniWeather
//
//  Created by 胡传业 on 15/8/26.
//  Copyright (c) 2015年 Herbert Hu. All rights reserved.
//

#import "HomeCell.h"
#import "HHHomeItem.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Override the layoutSubviews

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
}


- (void)configureCellWithHomeItem:(HHHomeItem *)homeItem {
    
    if (!homeItem) {
        
        NSLog(@"ERROR: Parameter(homeItem) is nil");
        return;
    }
    
    _cellBackgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", homeItem.cellBackgroundImageName]];
    _cityNameLabel.text            = homeItem.cityName;
    _weatherImageView.image        = [UIImage imageNamed:[NSString stringWithFormat:@"%@", homeItem.weatherImageName]];
    _tempLabel.text                = homeItem.temperature;
}

@end
