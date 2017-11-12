//
//  HomeViewController.m
//  Umbrella
//
//  Created by Chen Shi on 11/11/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+Customs.h"
#import "ViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) UICollectionView *pagerView;
@end

@implementation HomeViewController

static NSString *vcCellID = @"ViewControllerCell";
static CGFloat itemSpacing = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    for (int i = 0; i < 10; i++) {
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherScreen"];
        [self addChildViewController:vc];
    }
    CGRect pagerViewFrame = CGRectMake( -itemSpacing, 0, kScreenWidth + itemSpacing * 2, kScreenHeight);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.sectionInset = UIEdgeInsetsMake(0, itemSpacing, 0, itemSpacing);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.pagerView = [[UICollectionView alloc] initWithFrame:pagerViewFrame collectionViewLayout:layout];
    self.pagerView.pagingEnabled = YES;
    self.pagerView.allowsSelection = NO;
    self.pagerView.delegate = self;
    self.pagerView.dataSource = self;
    self.pagerView.bounces = NO;
    self.pagerView.showsHorizontalScrollIndicator = NO;
    [self.pagerView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:vcCellID];
    [self.view addSubview:self.pagerView];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - CollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:vcCellID forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    ViewController *vc = (ViewController *)self.childViewControllers[indexPath.row];
    [vc.view setFrame:CGRectMake(itemSpacing, 0, cell.contentView.frame.size.width - itemSpacing * 2, cell.contentView.frame.size.height)];
    [cell.contentView addSubview:vc.view];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
