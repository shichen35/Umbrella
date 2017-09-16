//
//  ForecastTableViewCell.m
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cardView.layer setCornerRadius:5];
    [self.cardView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.cardView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.cardView.layer setShadowRadius:1];
    [self.cardView.layer setShadowOpacity:0.7];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
