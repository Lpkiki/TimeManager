//
//  ViewController.m
//  TimeManager
//
//  Created by Lpkiki on 2018/1/24.
//  Copyright © 2018年 kiki. All rights reserved.
//

#import "ViewController.h"
#import "TimeManager.h"

@interface ViewController ()<TimeManagerDelegate>
/** 计时器 */
@property (nonatomic,strong) TimeManager *timeMagager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 开启计时器
    [self.timeMagager setOpenTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - TimeManagerDelegate
- (void)getTimeStr:(NSString *)timeStr  secondStr:(NSString *)secondStr{
    
    //code
    NSLog(@"----%@",timeStr);

}

-(TimeManager *)timeMagager{
    if (!_timeMagager) {
        _timeMagager = [[TimeManager alloc]init];
        _timeMagager.delegate = self;
    }
    return _timeMagager;
}
@end
