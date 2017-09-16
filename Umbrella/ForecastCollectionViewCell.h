//
//  ForecastCollectionViewCell.h
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end
