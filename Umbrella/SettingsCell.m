//
//  SettingsCell.m
//  Umbrella
//
//  Created by Chen Shi on 9/13/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "SettingsCell.h"

@implementation SettingsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
}
@end