//
//  MainWeatherView.m
//  XKWeather
//
//  Created by xukun on 2017/1/3.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import "MainWeatherView.h"
#import "POP.h"
#import "UIView+SetRect.h"
#import "LeftToRightView.h"
#import "GCD.h"
#import "UpToDownView.h"
#import "ShapeWordView.h"
#import "AddedFont.h"
#import "ShowDownView.h"
#import "CityTitleView.h"
#import <POP.h>


@interface MainWeatherView()<UITableViewDelegate>
@property (nonatomic, strong) UITableView       *tableView;

@property (nonatomic, strong) UIView  *changeColorLabel;
@property (nonatomic ,strong) UIView      *humidityView;
@property (nonatomic, strong) UIView     *windSpeedView;
@property (nonatomic, strong) UIView       *maxTempView;
@property (nonatomic, strong) UIView       *sunInfoView;
@property (nonatomic, strong) UIView   *temperatureView;
@property (nonatomic, strong) UIView   *weatherIconView;
@property (nonatomic, strong) CityTitleView     *cityTitleView;
@property (nonatomic, strong) ShowDownView    *showDownView;
@property (nonatomic, strong) LeftToRightView   *grayLine1;
@property (nonatomic, strong) LeftToRightView   *grayLine2;
@property (nonatomic, strong) LeftToRightView   *grayLine3;
@property (nonatomic, strong) LeftToRightView   *grayLine4;
@property (nonatomic, strong) UpToDownView      *vLine;
@property (nonatomic, strong) ShapeWordView    *shapeWordView;
@property (nonatomic ,strong) UILabel *numberLabel;


@end

@implementation MainWeatherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self builderView];
    }
    return self;
    

}

-(void)builderView{
    // 加载用tableView
    self.tableView                 = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate        = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
   
    
    // 显示控件
    self.humidityView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width, Width / 2.f, Width / 2.f)];
//    [self.humidityView buildView];
    [self.humidityView setBackgroundColor:[UIColor clearColor]];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.humidityView.frame.size.width, self.humidityView.frame.size.height)];

    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.duration = 2.0;
    POPAnimatableProperty *pop = [POPAnimatableProperty propertyWithName:@"count++" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.readBlock = ^(id obj, CGFloat values[]){
            values[0] = [[obj description] floatValue];
        };
        prop.writeBlock = ^(id obj, const CGFloat values[])
        {
            [obj setText:[NSString stringWithFormat:@"%.0f",values[0]]];
        };
        prop.threshold = 1;
    }];
    anim.property = pop;
    anim.fromValue = @(0);
    anim.toValue = @(18);
    [_numberLabel pop_addAnimation:anim forKey:@"counting"];
    [_numberLabel setTextColor:[UIColor purpleColor]];
    [_numberLabel setFont:[UIFont systemFontOfSize:30.0]];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.humidityView addSubview:_numberLabel];
    [self.tableView addSubview:self.humidityView];
    
    self.windSpeedView = [[UIView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
//    [self.windSpeedView buildView];
    self.windSpeedView.backgroundColor = [UIColor redColor];
    [self.tableView addSubview:self.windSpeedView];
    
    self.maxTempView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width / 2.f, Width / 2.f)];
//    [self.maxTempView buildView];
    self.maxTempView.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:self.maxTempView];
    
    self.sunInfoView = [[UIView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width, Width / 2.f, Width / 2.f)];
//    [self.sunInfoView buildView];
    self.sunInfoView.backgroundColor = [UIColor grayColor];
    [self.tableView addSubview:self.sunInfoView];
    
    self.temperatureView = [[UIView alloc] initWithFrame:CGRectMake(Width / 2.f, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
//    [self.temperatureView buildView];
    self.temperatureView.backgroundColor = [UIColor purpleColor];
    [self.tableView addSubview:self.temperatureView];
    
    self.weatherIconView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width / 2.f, Width / 2.f)];
//    [self.weatherIconView buildView];
    self.weatherIconView.backgroundColor = [UIColor brownColor];
    [self.tableView addSubview:self.weatherIconView];
    
    
    // 创建出线条
    {
        self.grayLine1                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width / 2.f, Width, 0.5)];
        self.grayLine1.backgroundColor = [UIColor blackColor];
        self.grayLine1.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine1];
        
        self.grayLine2                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - 1, Width, 0.5)];
        self.grayLine2.backgroundColor = [UIColor blackColor];
        self.grayLine2.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine2];
        
        self.grayLine3                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width, Width, 0.5)];
        self.grayLine3.backgroundColor = [UIColor blackColor];
        self.grayLine3.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine3];
        
        self.grayLine4                 = [[LeftToRightView alloc] initWithFrame:CGRectMake(0, Height - Width - Width / 2.f, Width, 0.5)];
        self.grayLine4.backgroundColor = [UIColor blackColor];
        self.grayLine4.alpha           = 0.1;
        [self.tableView addSubview:self.grayLine4];
        
        self.vLine                     = [[UpToDownView alloc] initWithFrame:CGRectMake(Width / 2.f - 1, Height - Width - Width / 2.f, 0.5, Width + Width / 2.f)];
        self.vLine.backgroundColor     = [UIColor blackColor];
        self.vLine.alpha               = 0.1;
        [self.tableView addSubview:self.vLine];
    }
    
    // 标题
    self.cityTitleView = [[CityTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, Height - Width - Width / 2.f)];
//    [self.cityTitleView buildView];
    [self.tableView addSubview:self.cityTitleView];
    
    // 显示进入更多天气的view的提示信息
    self.showDownView = [[ShowDownView alloc] initWithFrame:CGRectMake(0, 0, 30.f, 30.f / 3.f)];
    self.showDownView.center = self.middlePoint;
    self.showDownView.y = Height + 20.f;
    [self.tableView addSubview:self.showDownView];
    self.showDownView.layer.transform = CATransform3DConcat(self.showDownView.layer.transform, CATransform3DMakeRotation(M_PI,1.0, 0.0, 0.0));
    
    // tableView上面加载的view
    self.shapeWordView           = [[ShapeWordView alloc] initWithFrame:CGRectMake(0, -60, Width, 60)];
    self.shapeWordView.text      = @"Refresh";
    self.shapeWordView.font      = [UIFont fontWithName:LATO_THIN size:25.f];
    self.shapeWordView.lineWidth = 0.5f;
    self.shapeWordView.lineColor = [UIColor redColor];
    [self.shapeWordView buildView];
    [self.tableView addSubview:self.shapeWordView];
    

    

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat percent = (scrollView.contentOffset.y) / 60.f;
    [self.showDownView showPercent:percent];
    
    CGFloat offsetY = -scrollView.contentOffset.y;
    
    if (offsetY >= 0.f) {
        
        percent = offsetY / 60.f;
        [self.shapeWordView percent:percent animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 位移超过60后执行动画效果
    if (scrollView.contentOffset.y >= 60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullUpEventWithData:)] && self.weatherConditions) {
            
            [_delegate pullUpEventWithData:self.weatherConditions];
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
            [GCDQueue executeInMainQueue:^{
                
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                
            } afterDelaySecs:1.1];
        }
    }
    
    if (scrollView.contentOffset.y <= -60.f) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(pullDownToRefreshData)]) {
            
            [_delegate pullDownToRefreshData];
        }
    }
}

- (void)show{
    
    // 开始标题动画
    self.cityTitleView.cityName           = self.weahterData.name; // 城市名字
    Weather *weather                      = self.weahterData.weather[0];
    self.cityTitleView.weatherDescription = weather.descriptionInfo; // 天气描述信息
    self.cityTitleView.baseStation        = self.weahterData.base; // 基站信息
    self.cityTitleView.utcSec             = self.weahterData.dt.integerValue; // 更新时间
    self.cityTitleView.weatherNumber      = weather.weatherId;

    [self.cityTitleView show];
    
    
    
    
}
- (void)hide{
    
    [self.cityTitleView hide];
//    [UIView animateWithDuration:1.5f animations:^{
//        self.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        self.alpha = 0.0;
//    }];
}

@end
