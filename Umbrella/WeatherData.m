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
        
        NSMutableArray *result = [NSMutableArray new];
        NSString *currentDate;
        for (id hourItem in hourlyForecast) {
            if(![hourItem[@"FCTTIME"][@"mday"] isEqualToString:currentDate]) {
                currentDate = [NSString stringWithString:hourItem[@"FCTTIME"][@"mday"]];
                [result addObject:[NSMutableArray new]];
            }
            ForecastData *data = [[ForecastData alloc] initWithDictionary:hourItem];
            [[result lastObject] addObject:data];
        }
        
        // find the highest and lowest
        for (id dayItem in result) {
            ForecastData *highest = dayItem[0], *lowest = dayItem[0];
            for (ForecastData *hourItem in dayItem) {
                if (hourItem.temperature.fahrenheit < lowest.temperature.fahrenheit) {
                    lowest = hourItem;
                }
                if (hourItem.temperature.fahrenheit > highest.temperature.fahrenheit) {
                    highest = hourItem;
                }
            }
            if(highest != lowest) {
                highest.highest = YES;
                lowest.lowest = YES;
            }
        }
        
        self.forecast10Days = result;
    }
    return self;
}

@end
