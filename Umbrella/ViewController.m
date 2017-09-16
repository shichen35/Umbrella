//
//  ViewController.m
//  Umbrella
//
//  Created by Chen Shi on 9/12/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ViewController.h"
#import "ForecastTableViewCell.h"
#import "DataManager.h"
#import "WeatherData.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *navbarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) WeatherData *weatherData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWeather) name:UIApplicationWillEnterForegroundNotification object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    [self.view bringSubviewToFront:self.navbarView];
    [self.navbarView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.navbarView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.navbarView.layer setShadowRadius:5];
    [self.navbarView.layer setShadowOpacity:0.5];
    
    UIRefreshControl *refreshControl =[UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(updateWeather) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
}

- (void)updateWeather {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[DataManager sharedInstance] getCurrentWeatherForLocation:[DataManager sharedInstance].zipCode completionHandler:^(NSDictionary *json, NSError *error) {
        [self.tableView.refreshControl endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(error) {
            NSLog(@"%@", error.localizedDescription);
        }else{
            if(json[@"response"][@"error"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"response"][@"error"][@"type"] message:json[@"response"][@"error"][@"description"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok= [UIAlertAction
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
                    if(self.weatherData.currentTemperature.fahrenheit > 60) {
                        [self.navbarView setBackgroundColor:[UIColor colorWithRed:1.00 green:0.60 blue:0.00 alpha:1.0]];
                    }else{
                        [self.navbarView setBackgroundColor:[UIColor colorWithRed:0.01 green:0.66 blue:0.96 alpha:1.0]];
                    }
                });
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForecastCell"];
    return cell;
}

@end
