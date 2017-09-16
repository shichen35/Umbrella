//
//  ForecastTableViewCell.h
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *sectionHeaderLabel;

- (void)setCollectionViewDataSourceDelegate:(id <UICollectionViewDelegate, UICollectionViewDataSource>)dataSource forRow:(NSInteger)row;
@end
