//
//  ViewController.m
//  XKWeather
//
//  Created by xukun on 2017/1/3.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import "ViewController.h"
#import "MainWeatherView.h"
#import "FadeBlackView.h"
#import "UpdatingView.h"
#import "MapManager.h"
#import "GetWeatherData.h"
#import "CurrentConditions.h"
#import "CurrentWeatherData.h"
#import "GCD.h"
#import "MoreWeaherInfoViewController.h"
#import "GCDQueue.h"

@interface ViewController ()<MapManagerLocationDelegate,GetWeatherDataDelegate,WeatherViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) MainWeatherView          *weatherView;
@property (nonatomic, strong) FadeBlackView        *fadeBlackView;
@property (nonatomic, strong) UpdatingView         *upDatingView;
@property (nonatomic, strong) MapManager           *mapLoacation;
@property (nonatomic, strong) GetWeatherData       *getWeatherData;
@property (nonatomic, strong) MoreWeaherInfoViewController       *more;


@end

@implementation ViewController
{
    CLLocation *_loaction;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
    
}


-(void)initView{
    _weatherView = [[MainWeatherView alloc] initWithFrame:self.view.bounds];
    self.weatherView.delegate = self;
    self.weatherView.layer.masksToBounds = YES;
    [self.view addSubview:_weatherView];
    
    self.fadeBlackView = [[FadeBlackView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_fadeBlackView];
  
    // loading
    self.upDatingView        = [[UpdatingView alloc] initWithFrame:CGRectZero];
    self.upDatingView.center = self.view.center;
    [self.view addSubview:self.upDatingView];
    
    // 定位功能
    self.mapLoacation          = [MapManager new];
    self.mapLoacation.delegate = self;
    // 获取网络请求
    self.getWeatherData          = [GetWeatherData new];
    self.getWeatherData.delegate = self;
    
    
    [self getLocationAndFadeShow];
       
    
}

- (void)getLocationAndFadeShow {
    
    // 显示出等待页面
    [self.fadeBlackView show];
    [self.upDatingView show];
    
    // 开始定位
    [self.mapLoacation start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 定位
- (void)mapManager:(MapManager *)manager didUpdateAndGetLastCLLocation:(CLLocation *)location{
    _loaction = location;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(delayRunEvent:) withObject:self afterDelay:0.3f];
}

- (void)mapManager:(MapManager *)manager didFailed:(NSError *)error{
}
- (void)mapManagerServerClosed:(MapManager *)manager{

}


/**
 *  获取到网络数据的结果
 *
 *  @param object 网络数据
 *  @param sucess YES表示成功,NO表示失败
 */
- (void)weatherData:(id)object sucess:(BOOL)sucess {
    
    if (sucess) {
        
        NSLog(@"%@", object);
        
        // 获取数据
        CurrentWeatherData *data       = [object valueForKey:@"WeatherData"];
        CurrentConditions  *conditions = [object valueForKey:@"WeatherConditions"];
        
        // 先获取温度
        self.weatherView.weahterData       = data;
        self.weatherView.weatherConditions = conditions;
        
        // 先隐藏,再显示
        [self.weatherView hide];
        
        [GCDQueue executeInMainQueue:^{
            
            [self.weatherView show];
            [self.fadeBlackView hide];
            [self.upDatingView hide];
//            [self.failedView remove];
            
        } afterDelaySecs:1.f];
        
    } else {
        
        NSLog(@"获取数据失败");
        
        [self.upDatingView showFailed];
        [GCDQueue executeInMainQueue:^{
            
            [self.fadeBlackView hide];
            [self.upDatingView hide];
            [self.weatherView show];
//            [self.failedView show];
            
        } afterDelaySecs:2.51f];
        
//        [self showErrorInfo];
    }
}

/**
 *  延时执行
 *
 *  @param object 过滤掉干扰项目
 */
- (void)delayRunEvent:(id)object {
    NSLog(@"%@",_loaction);
    
    self.getWeatherData.location = _loaction;
    [self.getWeatherData startGetLocationWeatherData];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}



/**
 *  上拉进入新的控制器
 *
 *  @param condition 新控制器需要的数据
 */
- (void)pullUpEventWithData:(CurrentConditions *)condition {
    
    [GCDQueue executeInMainQueue:^{
        
        MoreWeaherInfoViewController *moreInfo    = [MoreWeaherInfoViewController new];
        moreInfo.transitioningDelegate = self;
        //forecastCV.transitioningDelegate  = self;
        moreInfo.modalPresentationStyle = UIModalPresentationCustom;
        moreInfo.weatherCondition       = condition;
        [self presentViewController:moreInfo animated:YES completion:nil];
        
    } afterDelaySecs:0.05f];
}

/**
 *  下拉更新数据
 */
- (void)pullDownToRefreshData {
    
    NSLog(@"下拉获取数据");
    [self getLocationAndFadeShow];
}

@end
