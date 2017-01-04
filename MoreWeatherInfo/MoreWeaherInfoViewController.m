//
//  MoreWeaherInfoViewController.m
//  XKWeather
//
//  Created by xukun on 2017/1/4.
//  Copyright © 2017年 xukun. All rights reserved.
//

#import "MoreWeaherInfoViewController.h"
#import "ShowDownView.h"
#import "GCDQueue.h"

@interface MoreWeaherInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic)         CGFloat              cellHeight;
@property (nonatomic, strong) NSMutableArray      *weatherDataArray;
@property (nonatomic, strong) ShowDownView        *showDownView;

@end

@implementation MoreWeaherInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self initTableView];
    
    // 显示进入更多天气的view的提示信息
    self.showDownView        = [[ShowDownView alloc] initWithFrame:CGRectMake(0, 0, 30.f, 30.f / 3.f)];
    self.showDownView.center = self.view.center;
    self.showDownView.y      = -30.f;
    [self.tableView addSubview:self.showDownView];
}


- (void)initTableView {
    
    // cell高度
    self.cellHeight           = Width / 4.f;
    self.tableView            = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    //self.tableView.dataSource = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    //[self.tableView registerClass:[ForecastCell class] forCellReuseIdentifier:@"ForecastCell"];
    
    [self.view addSubview:self.tableView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView.contentOffset.y <= -60) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }];
        //__block MoreWeaherInfoViewController *weakSelf = self;
        //dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_MSEC));
        //dispatch_after(delayTime, dispatch_get_main_queue(), ^{
         //   [weakSelf dismissViewControllerAnimated:YES completion:nil];
       // });
        
        [GCDQueue executeInMainQueue:^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } afterDelaySecs:0.05f];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat percent = (-scrollView.contentOffset.y) / 60.f;
    [self.showDownView showPercent:percent];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
