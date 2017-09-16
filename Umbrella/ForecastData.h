//
//  ForecastData.h
//  Umbrella
//
//  Created by Chen Shi on 9/16/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherData.h"

@interface ForecastData : NSObject

//  section header title
@property (copy, nonatomic) NSString *weekday;

//  hour text
@property (copy, nonatomic) NSString *hour;

//  Description of the hour's conditions
@property (copy, nonatomic) NSString *conditionDescription;

//  Hour's temperature
@property (assign, nonatomic) UTemperature temperature;

@property (assign, nonatomic) BOOL highest;
@property (assign, nonatomic) BOOL lowest;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
