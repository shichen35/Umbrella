//
//  WeatherData.m
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        dict = dict[@"current_observation"];
        self.location = dict[@"display_location"][@"full"];
        
        float fahrenheit = [dict[@"temp_f"] floatValue];
        float celsius = [dict[@"temp_c"] floatValue];
        self.currentTemperature = UTemperatureMake(fahrenheit, celsius);
        
        self.conditionDescription = dict[@"weather"];
    }
    return self;
}

@end
