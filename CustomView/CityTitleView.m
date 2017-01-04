//
//  CityTitleView.m
//  XKWeather
//
//  Created by xukun on 2017/1/4.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import "CityTitleView.h"
#import "AddedFont.h"
#import "UIView+SetRect.h"
#import "CityAnimalObject.h"

@interface CityTitleView()

@property (nonatomic, strong) UILabel          *baseLabel;       // 基站label
@property (nonatomic, strong) CityAnimalObject *baseLabelStoreValue;

@property (nonatomic, strong) UILabel          *cityNameLabel;   // 城市名字label
@property (nonatomic, strong) CityAnimalObject *cityNameLabelStoreValue;

@property (nonatomic, strong) UILabel          *weatherDesLabel; // 天气描述label
@property (nonatomic, strong) CityAnimalObject *weatherDesLabelStoreValue;

@property (nonatomic, strong) UILabel          *updateYearLabel; // 更新年份label
@property (nonatomic, strong) CityAnimalObject *updateYearLabelStoreValue;

@property (nonatomic, strong) UILabel          *updateHourLabel; // 更新的小时label
@property (nonatomic, strong) CityAnimalObject *updateHourLabelStoreValue;

@property (nonatomic, strong) UIView           *blackView;       // 黑色的view
@property (nonatomic, strong) CityAnimalObject *blackViewStoreValue;

@property (nonatomic, strong) UIView           *redView;         // 红色的view
@property (nonatomic, strong) CityAnimalObject *redViewStoreValue;
@end

@implementation CityTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self buildView];
    }
    return self;
}
-(void)moveToLeft:(CGRect)rect withStep:(CGFloat)step withEndValue:(CityAnimalObject *)value{
    CGRect mid = rect;
    CGRect start = CGRectMake(rect.origin.x + step,
                              rect.origin.y,
                              rect.size.width,
                              rect.size.height);
    CGRect end = CGRectMake(rect.origin.x - step,
                            rect.origin.y,
                            rect.size.width,
                            rect.size.height);
    value.midPos = mid;
    value.startPos = start;
    value.endPos = end;
 
}

-(void)moveToRight:(CGRect)rect withStep:(CGFloat)step withEndValue:(CityAnimalObject *)value{
    CGRect mid = rect;
    CGRect start = CGRectMake(rect.origin.x - step,
                              rect.origin.y,
                              rect.size.width,
                              rect.size.height);
    CGRect end = CGRectMake(rect.origin.x + step,
                            rect.origin.y,
                            rect.size.width,
                            rect.size.height);
    value.midPos = mid;
    value.startPos = start;
    value.endPos = end;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)buildView{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.90f];
    // 基站信息
    self.baseLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Width - 8, 12.f)];
    self.baseLabel.textAlignment = NSTextAlignmentRight;
    self.baseLabel.font          = [UIFont fontWithName:LATO_BOLD size:10.f];
    self.baseLabel.text          = @"cmc station";
    self.baseLabelStoreValue     = [CityAnimalObject new];
    [self moveToLeft:self.baseLabel.frame withStep:6 withEndValue:self.baseLabelStoreValue];
    self.baseLabel.frame = self.baseLabelStoreValue.startPos;
    self.baseLabel.alpha         = 0.f;
    
    [self addSubview:self.baseLabel];
    // 黑色的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 44)];
        
    } else if (iPhone6_6s) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 60)];
        
    } else if (iPhone6_6sPlus) {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 60)];
        
    } else {
        
        self.blackView = [[UIView alloc] initWithFrame:CGRectMake(-30, 22, 5 + 30, 44)];
    }
    
    self.blackView.backgroundColor     = [UIColor blackColor];
    [self addSubview:self.blackView];
    self.blackView.x                  -= 5;
    self.blackView.x                  += 5;
    self.blackView.y                  += 5;
    self.blackView.alpha               = 0.f;
    
    // 红色的view
    CGFloat redViewWidth = 100;
    
    if (iPhone4_4s || iPhone5_5s) {
        
        redViewWidth = 100;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 44)];
        
    } else if (iPhone6_6s) {
        
        redViewWidth = 135;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 60)];
        
    } else if (iPhone6_6sPlus) {
        
        redViewWidth = 135;
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 60)];
        
    } else {
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(Width - redViewWidth, 22, redViewWidth + 100, 44)];
    }
    
    self.redView.backgroundColor = [UIColor redColor];
    
    [self addSubview:self.redView];
    self.redViewStoreValue     = [CityAnimalObject new];
    [self moveToLeft:self.redView.frame withStep:30.0f withEndValue:self.redViewStoreValue];
    self.redView.frame = self.baseLabelStoreValue.startPos;
    self.redView.alpha = 0.f;
    
    // 年份的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 12.f)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:10];
        
    } else if (iPhone6_6s) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 18)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:16];
        
    } else if (iPhone6_6sPlus) {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 18)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:16];
        
    } else {
        
        self.updateYearLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, Width - 40, 12.f)];
        self.updateYearLabel.text = @"2015.03.21";
        self.updateYearLabel.textAlignment = NSTextAlignmentRight;
        self.updateYearLabel.textColor = [UIColor whiteColor];
        self.updateYearLabel.font = [UIFont fontWithName:LATO_LIGHT size:10];
    }
    
    [self addSubview:self.updateYearLabel];
    self.updateYearLabelStoreValue = [CityAnimalObject new];
    [self moveToLeft:self.updateYearLabel.frame withStep:20.0f withEndValue:self.updateYearLabelStoreValue];
    self.updateYearLabel.frame = self.updateYearLabelStoreValue.startPos;
   
    self.updateYearLabel.alpha = 0.f;
    
    // 小时的view
    if (iPhone4_4s || iPhone5_5s) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, Width - 8, 14.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:12];
        
    } else if (iPhone6_6s) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, Width - 8, 20.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:16];
        
    } else if (iPhone6_6sPlus) {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, Width - 8, 20.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:16];
        
    } else {
        
        self.updateHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, Width - 8, 14.f)];
        self.updateHourLabel.textAlignment = NSTextAlignmentRight;
        self.updateHourLabel.text = @"13:20 update";
        self.updateHourLabel.textColor = [UIColor whiteColor];
        self.updateHourLabel.font = [UIFont fontWithName:LATO_REGULAR size:12];
    }
    
    [self addSubview:self.updateHourLabel];
    self.updateHourLabelStoreValue = [CityAnimalObject new];
    [self moveToLeft:self.updateHourLabel.frame withStep:20.0f withEndValue:self.updateHourLabelStoreValue];
    self.updateHourLabel.frame = self.updateHourLabelStoreValue.startPos;
    self.updateHourLabel.alpha = 0.f;
    
    // 城市label
    if (iPhone4_4s || iPhone5_5s) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:26.f];
        
    } else if (iPhone6_6s) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_LIGHT size:30.f];
        
    } else if (iPhone6_6sPlus) {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 17, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_LIGHT size:30.f];
        
    } else {
        
        self.cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 16, Width - 10, 40)];
        self.cityNameLabel.text = @"San Francisco";
        self.cityNameLabel.font = [UIFont fontWithName:LATO_REGULAR size:26.f];
    }
    
    [self addSubview:self.cityNameLabel];
    [self.cityNameLabel sizeToFit];

    self.cityNameLabel.width = Width - 10;
    self.cityNameLabelStoreValue = [CityAnimalObject new];
    [self moveToRight:self.cityNameLabel.frame withStep:30.0f withEndValue:self.cityNameLabelStoreValue];
    self.cityNameLabel.frame = self.cityNameLabelStoreValue.startPos;

    self.cityNameLabel.alpha = 0.f;
    
    // 天气描述用的label
    if (iPhone4_4s || iPhone5_5s) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:14.f];
        
    } else if (iPhone6_6s) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 62, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:16.f];
        
    } else if (iPhone6_6sPlus) {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 62, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:16.f];
        
    } else {
        
        self.weatherDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, Width - 10, 20)];
        self.weatherDesLabel.text = @"broken clouds";
        self.weatherDesLabel.font = [UIFont fontWithName:LATO_THIN size:14.f];
    }
    
    [self addSubview:self.weatherDesLabel];
    [self.weatherDesLabel sizeToFit];
    self.weatherDesLabel.width = Width - 10;
    self.weatherDesLabelStoreValue = [CityAnimalObject new];
    [self moveToRight:self.weatherDesLabel.frame withStep:30.0f withEndValue:self.weatherDesLabelStoreValue];
    self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.startPos;
    self.weatherDesLabel.width = Width - 10;
    self.weatherDesLabel.alpha = 0.f;
}


-(void)show{
    [UIView animateWithDuration:1.0f animations:^{
        
        self.baseLabel.frame = self.baseLabelStoreValue.midPos;
        self.baseLabel.alpha = 1.f;
        
        self.cityNameLabel.frame = self.cityNameLabelStoreValue.midPos;
        self.cityNameLabel.alpha = 1.f;
        
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.midPos;
        self.weatherDesLabel.alpha = 1.f;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.midPos;
        self.updateYearLabel.alpha = 1.f;
        
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.midPos;
        self.updateHourLabel.alpha = 1.f;
        
        self.redView.frame = self.redViewStoreValue.midPos;
        self.redView.alpha = 1.f;
        
//        self.blackView.frame = self.blackViewStoreValue.midPos;
        self.blackView.alpha = 1.f;
    }];
}
- (void)hide {
    
    CGFloat duration = 0.75f;
    [UIView animateWithDuration:duration animations:^{
        
        self.baseLabel.frame = self.baseLabelStoreValue.endPos;
        self.baseLabel.alpha = 0.f;
        
        self.cityNameLabel.frame = self.cityNameLabelStoreValue.endPos;
        self.cityNameLabel.alpha = 0.f;
        
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.endPos;
        self.weatherDesLabel.alpha = 0.f;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.endPos;
        self.updateYearLabel.alpha = 0.f;
        
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.endPos;
        self.updateHourLabel.alpha = 0.f;
        
        self.redView.frame = self.redViewStoreValue.endPos;
        self.redView.alpha = 0.f;
        
//        self.blackView.frame = self.blackViewStoreValue.endRect;
        self.blackView.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.baseLabel.frame       = self.baseLabelStoreValue.startPos;
        
        self.cityNameLabel.frame   = self.cityNameLabelStoreValue.startPos;
//
        self.weatherDesLabel.frame = self.weatherDesLabelStoreValue.startPos;
        
        self.updateYearLabel.frame = self.updateYearLabelStoreValue.startPos;
//
        self.updateHourLabel.frame = self.updateHourLabelStoreValue.startPos;
//
        self.redView.frame = self.redViewStoreValue.startPos;
        
//        self.blackView.frame = self.blackViewStoreValue.startRect;
        self.blackView.alpha = 1.f;
        
        // 移除天气view
//        [self.weatherConditionView removeFromSuperview];
    }];
}

#pragma mark - 重写setter,getter方法

@synthesize cityName = _cityName;

- (void)setCityName:(NSString *)cityName {
    
    _cityName           = cityName;
    _cityNameLabel.text = cityName;
    [_cityNameLabel sizeToFit];
}

- (NSString *)cityName {
    
    return _cityName;
}

@synthesize weatherDescription = _weatherDescription;

- (void)setWeatherDescription:(NSString *)weatherDescription {
    
    _weatherDescription   = weatherDescription;
    _weatherDesLabel.text = weatherDescription;
    [_weatherDesLabel sizeToFit];
}

- (NSString *)weatherDescription {
    
    return _weatherDescription;
}

@synthesize baseStation = _baseStation;

- (void)setBaseStation:(NSString *)baseStation {
    
    _baseStation    = baseStation;
    _baseLabel.text = baseStation;
}

- (NSString *)baseStation {
    
    return _baseStation;
}

@synthesize utcSec = _utcSec;

- (void)setUtcSec:(NSTimeInterval)utcSec {
    
    _utcSec = utcSec;
    
    NSDate *utcDate = [NSDate dateWithTimeIntervalSince1970:utcSec];
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *yearStr = [formatter stringFromDate:utcDate];
    self.updateYearLabel.text = yearStr;
    
    [formatter setDateFormat:@"hh:mm"];
    NSString *hourStr = [NSString stringWithFormat:@"%@ update", [formatter stringFromDate:utcDate]];
    self.updateHourLabel.text = hourStr;
}

- (NSTimeInterval)utcSec {
    
    return _utcSec;
}

@end
