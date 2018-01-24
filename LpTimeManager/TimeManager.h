//
//  TimeManager.h
//  CHISLIM
//
//  Created by Lpkiki on 2017/8/31.
//  Copyright © 2017年 XIU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeManagerDelegate <NSObject>

- (void)getTimeStr:(NSString *)timeStr  secondStr:(NSString *)secondStr;

@end

@interface TimeManager : NSObject

/// 开始定时方法
- (void)setOpenTime;
/// 暂停定时方法
- (void)setOverTime;
/// 停止定时器方法
- (void)setCloseTime;

@property (nonatomic,weak) id <TimeManagerDelegate > delegate;

@end
