//
//  DataManager.h
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (assign, nonatomic) BOOL fahrenheit;
@property (copy, nonatomic) NSString *zipCode;

- (void)getCurrentWeatherForLocation:(NSString *)zipCode completionHandler:(void(^)(NSDictionary *response, NSError *error))completion;

+ (DataManager *)sharedInstance;

@end
