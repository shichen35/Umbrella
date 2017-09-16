//
//  DataManager.m
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

static NSString *baseURL =  @"https://api.wunderground.com/api/";
static NSString *API_KEY = @"3143ee175e1a5d21";
static NSString *featureAPI = @"/conditions/hourly10day/";

+(id)sharedInstance {
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)getCurrentWeatherForLocation:(NSString *)zipCode completionHandler:(void (^)(NSDictionary *, NSError *))completion {
    NSString *location = [NSString stringWithFormat:@"q/%@.json", zipCode];
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@", baseURL, API_KEY, featureAPI, location];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            completion(nil, error);
        }else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            completion(json, nil);
        }
    }] resume];
}

@end