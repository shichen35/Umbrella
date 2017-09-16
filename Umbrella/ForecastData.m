//
//  ForecastData.m
//  Umbrella
//
//  Created by Chen Shi on 9/16/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ForecastData.h"

@implementation ForecastData

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        float fahrenheit = [dict[@"temp"][@"english"] floatValue];
        float celsius = [dict[@"temp"][@"metric"] floatValue];
        self.temperature = UTemperatureMake(fahrenheit, celsius);
        self.conditionDescription = dict[@"condition"];
        self.weekday = dict[@"FCTTIME"][@"weekday_name"];
    }
    return self;
}

@end
