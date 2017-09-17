//
//  ForecastTableViewCell.m
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ForecastTableViewCell.h"

@interface ForecastTableViewCell()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ForecastTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cardView.layer setCornerRadius:5];
    [self.cardView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.cardView.layer setShadowOffset:CGSizeMake(0, 1)];
    [self.cardView.layer setShadowRadius:1];
    [self.cardView.layer setShadowOpacity:0.7];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSource forRow:(NSInteger)row {
    _collectionView.dataSource = dataSource;
    _collectionView.delegate = dataSource;
    _collectionView.tag = row;
    [_collectionView reloadData];
}


@end
