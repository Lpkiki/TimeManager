//
//  TimeManager.m
//  CHISLIM
//
//  Created by Lpkiki on 2017/8/31.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import "TimeManager.h"

@interface TimeManager (){
      BOOL _isGoTime;
}
@property (nonatomic , strong) dispatch_source_t time;

@end

@implementation TimeManager

- (instancetype)init{
   self =  [super init];
    if (self) {
        [self dispatchTime];
    }
    return self;
}

/** 开始定时方法 */
- (void) setOpenTime{
    dispatch_resume(self.time);
    _isGoTime = true;
}

/**  暂停定时方法 */
- (void) setOverTime{
    dispatch_suspend(self.time);
}

/** 停止定时器方法*/
-(void) setCloseTime{
    if (_isGoTime) {
        dispatch_source_cancel(self.time);
    }
}

- (void) dispatchTime{
    //GCD定时器
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    
    dispatch_source_set_timer(self.time, start, interval, 0);
    
    __block NSInteger sec = 0;
    
    __block NSInteger min = 0;
    
    __block NSInteger hour = 0;
    
    __block long int sllSec = 0;
    
    dispatch_source_set_event_handler(self.time, ^{
        //判定GCD定时时间 刷新UI控件
        sec += 1;
        sllSec += 1;
        
        if (sec == 60) {
            min += 1;
            sec = 0;
        }
        
        if (min == 60) {
            hour += 1;
            sec = 0;
            min = 0;
        }
        
        NSString *secStr;
        
        NSString *minStr;
        
        NSString *hourStr;
        
        if (sec < 10) {
            secStr = [NSString stringWithFormat:@"0%ld",(long)sec];
        }else{
            secStr = [NSString stringWithFormat:@"%ld",sec];
        }
        
        if (min < 10) {
            minStr = [NSString stringWithFormat:@"0%ld",(long)min];
        }else{
            minStr = [NSString stringWithFormat:@"%ld",min];
        }
        
        if (hour < 10) {
            hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        
        NSString *secondStr = [NSString stringWithFormat:@"%ld",sllSec];
        typeof(self) __weak weakSelf = self;//弱引用
        
        //主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
    
            NSString *timeStr = [NSString stringWithFormat:@"%@:%@:%@",hourStr,minStr,secStr];
            if ([weakSelf.delegate respondsToSelector:@selector(getTimeStr:secondStr:)]) {
                
                
                
                // 开启后台定位
//                NSString *bgStr =  GET_NSUSERDEFAULT(BG_RUN_STATE);
                NSString *bgStr =    [[NSUserDefaults standardUserDefaults] objectForKey:@"BG_RUN_STATE"];
                
//                if ([bgStr  isEqualToString:CLOSE_BG_RUN_STATE]) {
                if ([bgStr  isEqualToString:@"CLOSE_BG_RUN_STATE"]) {
//                    SET_NSUSERDEFAULT(BG_RUN_STATE, OPEN_BG_RUN_STATE);
                    [[NSUserDefaults standardUserDefaults] setObject:@"OPEN_BG_RUN_STATE" forKey:@"BG_RUN_STATE"];
//                    NSUSERDEFAULT_SYNCHRONIZE;
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
 
                
                [weakSelf.delegate  getTimeStr:timeStr secondStr:secondStr];
            }
        });
    });
}




@end
