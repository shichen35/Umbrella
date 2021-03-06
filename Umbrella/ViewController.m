//
//  ViewController.m
//  Umbrella
//
//  Created by Chen Shi on 9/12/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ViewController.h"
#import "ForecastTableViewCell.h"
#import "ForecastCollectionViewCell.h"
#import "DataManager.h"
#import "WeatherData.h"
#import "ForecastData.h"
#import "UIColor+Customs.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *navbarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) WeatherData *weatherData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *temperatureLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutGuideConstraint;

@end

@implementation ViewController

#define topLayoutGuideHeight kStatusBarHeight + 20
#define headerViewHeight kStatusBarHeight + 210

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeather) name:UIApplicationWillEnterForegroundNotification object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:@{@"fahrenheit":@YES, @"zip":@"94137"}];
    [DataManager sharedInstance].zipCode = [defaults stringForKey:@"zip"];
    [DataManager sharedInstance].fahrenheit = [defaults boolForKey:@"fahrenheit"];
    [self updateWeather];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureView {
    self.temperatureLabel.adjustsFontSizeToFitWidth = YES;
    self.tableView.estimatedRowHeight = 350;
    
    [self.tableView setContentInset: UIEdgeInsetsMake(self.navbarView.frame.size.height, 0, kTabbarHeight, 0)];
    [self.tableView setScrollIndicatorInsets: UIEdgeInsetsMake(self.navbarView.frame.size.height, 0, kTabbarHeight, 0)];
    [self.view bringSubviewToFront:self.navbarView];
    
    self.topLayoutGuideConstraint.constant = topLayoutGuideHeight;
    self.headerViewHeightConstraint.constant = headerViewHeight;
    [self.navbarView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.navbarView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.navbarView.layer setShadowRadius:5];
    [self.navbarView.layer setShadowOpacity:0.5];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)updateWeather {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[DataManager sharedInstance] getCurrentWeatherForLocation:[DataManager sharedInstance].zipCode completionHandler:^(NSDictionary *json, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if(error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@", error.localizedDescription);
        }else{
            if(json[@"response"][@"error"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"response"][@"error"][@"type"] message:json[@"response"][@"error"][@"description"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                self.weatherData = [[WeatherData alloc] initWithDictionary:json];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.locationLabel.text = self.weatherData.location;
                    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f°", [DataManager sharedInstance].fahrenheit ? self.weatherData.currentTemperature.fahrenheit : self.weatherData.currentTemperature.celsius];
                    self.weatherLabel.text = self.weatherData.conditionDescription;
                    [UIView animateWithDuration:0.5 animations:^{
                        if(self.weatherData.currentTemperature.fahrenheit > 60) {
                            [self.navbarView setBackgroundColor:[UIColor warmColor]];
                        }else{
                            [self.navbarView setBackgroundColor:[UIColor coolColor]];
                        }
                    }];
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weatherData.forecast10Days.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *hoursInADay = self.weatherData.forecast10Days[indexPath.row];
    CGFloat height = [hoursInADay count] / 4 * 100 + 16 + 68;
    if ([hoursInADay count] % 4 != 0) height += 100;
    return height;
//    return 184;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell"];
    [cell setCollectionViewDataSourceDelegate:self forRow:indexPath.row];
    ForecastData *data = self.weatherData.forecast10Days[indexPath.row][0];
    switch (indexPath.row) {
        case 0:
            cell.sectionHeaderLabel.text = @"Today";
            break;
        case 1:
            cell.sectionHeaderLabel.text = @"Tomorrow";
            break;
        default:
            cell.sectionHeaderLabel.text = data.weekday;
            break;
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", scrollView.contentOffset.y);
    CGFloat scrollViewOffset = scrollView.contentInset.top + scrollView.contentOffset.y;
    CGFloat scrollViewSlowerOffset = scrollViewOffset * 0.5;
    self.headerViewHeightConstraint.constant = headerViewHeight - scrollViewOffset >= 130 + kStatusBarHeight ? headerViewHeight - scrollViewOffset : 130 + kStatusBarHeight;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.headerViewHeightConstraint.constant, 0, kTabbarHeight, 0);
    self.temperatureLabelTopConstraint.constant = 55 - scrollViewSlowerOffset >= 20 ? 55 - scrollViewSlowerOffset > 55 ? 55 : 55 - scrollViewSlowerOffset : 20;
}


#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.weatherData.forecast10Days[collectionView.tag] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ForecastCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForecastDayCell" forIndexPath:indexPath];
    ForecastData *data = self.weatherData.forecast10Days[collectionView.tag][indexPath.row];
    // color
    if (data.highest) {
        cell.hourLabel.textColor = [UIColor warmColor];
        cell.temperatureLabel.textColor = [UIColor warmColor];
        cell.conditionLabel.textColor = [UIColor warmColor];
    }else if (data.lowest) {
        cell.hourLabel.textColor = [UIColor coolColor];
        cell.temperatureLabel.textColor = [UIColor coolColor];
        cell.conditionLabel.textColor = [UIColor coolColor];
    }else{
        cell.hourLabel.textColor = [UIColor blackColor];
        cell.temperatureLabel.textColor = [UIColor blackColor];
        cell.conditionLabel.textColor = [UIColor blackColor];
    }
    // display
    cell.hourLabel.text = data.hour;
    cell.temperatureLabel.text = [NSString stringWithFormat:@"%.0f°",[DataManager sharedInstance].fahrenheit ? data.temperature.fahrenheit : data.temperature.celsius];
    cell.conditionLabel.text = data.conditionDescription;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = collectionView.frame.size.width / 4 - 10;
    CGFloat cellHeight = 90;
    CGSize cellSize = CGSizeMake(cellWidth, cellHeight);
    return cellSize;
}

@end
