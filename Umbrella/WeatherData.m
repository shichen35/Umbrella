//
//  WeatherData.m
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "WeatherData.h"
#import "ForecastData.h"

@implementation WeatherData

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        NSDictionary *currentDict = dict[@"current_observation"];
        self.location = currentDict[@"display_location"][@"full"];
        
        float fahrenheit = [currentDict[@"temp_f"] floatValue];
        float celsius = [currentDict[@"temp_c"] floatValue];
        self.currentTemperature = UTemperatureMake(fahrenheit, celsius);
        
        self.conditionDescription = currentDict[@"weather"];
        
        NSArray *hourlyForecast = dict[@"hourly_forecast"];
        
        NSMutableArray *result;
        NSString *currentDate;
        for (NSDictionary *hourItem in hourlyForecast) {
            if(![hourItem[@"FCTTIME"][@"mday"] isEqualToString:currentDate]) {
                currentDate = [NSString stringWithString:hourItem[@"FCTTIME"][@"mday"]];
                [result addObject:@[]];
            }
            ForecastData *data = [[ForecastData alloc] initWithDictionary:hourItem];
            [[result lastObject] addObject:data];
        }
    }
    return self;
}

@end
