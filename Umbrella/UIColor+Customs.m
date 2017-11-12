//
//  UIColor+Customs.m
//  Umbrella
//
//  Created by Chen Shi on 9/16/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import "UIColor+Customs.h"

@implementation UIColor (UIColor_Customs)

+ (UIColor *)coolColor {
    return [UIColor colorWithRed:0.01 green:0.66 blue:0.96 alpha:1.0];
}

+ (UIColor *)warmColor {
    return [UIColor colorWithRed:1.00 green:0.60 blue:0.00 alpha:1.0];
}

+ (UIColor *)randomColor {
    srand48(time(0));
    return [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1.0];
}

@end
