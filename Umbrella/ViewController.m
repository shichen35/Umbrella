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
    [self updateWeather];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)configureView {
    [self.view bringSubviewToFront:self.navbarView];
    [self.navbarView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.navbarView.layer setShadowOffset:CGSizeMake(0, 3)];
    [self.navbarView.layer setShadowRadius:5];
    [self.navbarView.layer setShadowOpacity:0.5];
}

- (void)updateWeather {
    [DataManager getCurrentWeatherForLocation:@"30080" completionHandler:^(NSDictionary *json, NSError *error) {
        if(error) {
            NSLog(@"%@", error.localizedDescription);
        }else{
            if(json[@"response"][@"error"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:json[@"response"][@"error"][@"type"] message:json[@"response"][@"error"][@"description"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok= [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        
                                    }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                self.weatherData = [[WeatherData alloc] initWithDictionary:json];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.locationLabel.text = self.weatherData.location;
                    self.temperatureLabel.text = [NSString stringWithFormat:@"%.1f°", self.weatherData.currentTemperature.fahrenheit];
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
