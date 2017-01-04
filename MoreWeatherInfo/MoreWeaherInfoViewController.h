//
//  MoreWeaherInfoViewController.h
//  XKWeather
//
//  Created by xukun on 2017/1/4.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentConditions.h"

@interface MoreWeaherInfoViewController : UIViewController
/**
 *  天气预报
 */
@property (nonatomic, strong) CurrentConditions *weatherCondition;
@end
