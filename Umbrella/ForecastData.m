//
//  ForecastData.m
//  Umbrella
//
//  Created by Chen Shi on 9/16/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "ForecastData.h"
#import "NSString+Substring.h"

@implementation ForecastData


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        float fahrenheit = [dict[@"temp"][@"english"] floatValue];
        float celsius = [dict[@"temp"][@"metric"] floatValue];
        self.temperature = UTemperatureMake(fahrenheit, celsius);
        self.conditionDescription = [self iconForCondition:dict[@"condition"]];
        self.weekday = dict[@"FCTTIME"][@"weekday_name"];
        self.hour = dict[@"FCTTIME"][@"civil"];
    }
    return self;
}


- (NSString *)iconForCondition:(NSString *)condition
{
    NSString *iconName = [NSString stringWithFormat:@"%c", ClimaconSun];
    NSString *lowercaseCondition = [condition lowercaseString];
    
    if([lowercaseCondition contains:@"clear"]) {
        iconName = [NSString stringWithFormat:@"%c", ClimaconSun];
    } else if([lowercaseCondition contains:@"cloud"]) {
        iconName = [NSString stringWithFormat:@"%c", ClimaconCloud];
    } else if([lowercaseCondition contains:@"drizzle"]  ||
              [lowercaseCondition contains:@"rain"]     ||
              [lowercaseCondition contains:@"thunderstorm"]) {
        iconName = [NSString stringWithFormat:@"%c", ClimaconRain];
    } else if([lowercaseCondition contains:@"snow"]     ||
              [lowercaseCondition contains:@"hail"]     ||
              [lowercaseCondition contains:@"ice"]) {
        iconName = [NSString stringWithFormat:@"%c", ClimaconSnow];
    } else if([lowercaseCondition contains:@"fog"]      ||
              [lowercaseCondition contains:@"overcast"] ||
              [lowercaseCondition contains:@"smoke"]    ||
              [lowercaseCondition contains:@"dust"]     ||
              [lowercaseCondition contains:@"ash"]      ||
              [lowercaseCondition contains:@"mist"]     ||
              [lowercaseCondition contains:@"haze"]     ||
              [lowercaseCondition contains:@"spray"]    ||
              [lowercaseCondition contains:@"squall"]) {
        iconName = [NSString stringWithFormat:@"%c", ClimaconHaze];
    }
    return iconName;
}


@end
