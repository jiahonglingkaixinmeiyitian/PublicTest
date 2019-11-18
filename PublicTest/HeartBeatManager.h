//
//  HeartBeatManager.h
//
//  Created by 焦梓杰 on 2019/4/17.
//  Copyright © 2019 焦梓杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CURRENT_STATE) {
    STATE_PAUSED,
    STATE_TESTING
};

@protocol HeartBeatManagerDelegate<NSObject>

/**
 代理方法 - 返回瞬时心率
 */
- (void)startHeartDelegateHeartRate:(NSInteger)value;

@optional
/**
 代理方法 - 返回手指信号强弱
 
 @param value 0 - 100 表示信号强度
 */
- (void)startHeartDelegateFingerSigal:(NSInteger)value;

/**
 代理方法 - 错误信息
 */
- (void)startHeartDelegateRateFromError:(NSError *)error;

@end

@interface HeartBeatManager : NSObject

@property (nonatomic, copy) void ((^heartRate)(NSInteger));
@property (nonatomic, copy) void ((^fingerSigal)(NSInteger));
@property (nonatomic, copy) void ((^Error)(NSError *));
@property (nonatomic, weak) id<HeartBeatManagerDelegate> delegate;
@property (nonatomic, assign) CURRENT_STATE currentState;

/**
 *  单例
 */
+ (instancetype)shareManager;


/**
 *  开始检测
 */
- (void)start;


- (void)resume;

@end

NS_ASSUME_NONNULL_END
