//
//  Constants.h
//  Umbrella
//
//  Created by Chen Shi on 11/11/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTabbarHeight self.tabBarController == nil ? 0 : self.tabBarController.tabBar.frame.size.height

#define kStatusBarSize [[UIApplication sharedApplication] statusBarFrame].size
#define kStatusBarHeight MIN(kStatusBarSize.width, kStatusBarSize.height)

#endif /* Constants_h */
