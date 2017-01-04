//
//  CityTitleView.h
//  XKWeather
//
//  Created by xukun on 2017/1/4.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTitleView : UIView

@property (nonatomic, strong) NSString       *cityName;
@property (nonatomic, strong) NSString       *cityCode;
@property (nonatomic, strong) NSString       *weatherDescription;
@property (nonatomic, strong) NSString       *baseStation;
@property (nonatomic, strong) NSString       *updateYear;
@property (nonatomic, strong) NSString       *updateHour;
@property (nonatomic)         NSTimeInterval  utcSec;
@property (nonatomic, strong) NSNumber       *weatherNumber;

// 创建view
- (void)buildView;
-(void)hide;
-(void)show;
@end
