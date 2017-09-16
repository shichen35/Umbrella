//
//  WeatherData.h
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float fahrenheit;
    float celsius;
} UTemperature;

static inline UTemperature UTemperatureMake(float fahrenheit, float celsius) {
    return (UTemperature){fahrenheit, celsius};
}

@interface WeatherData : NSObject

//  Display location
@property (copy, nonatomic) NSString *location;

//  Description of the day's conditions
@property (copy, nonatomic) NSString *conditionDescription;

//  Day's current temperature
@property (assign, nonatomic) UTemperature currentTemperature;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
