//
//  DJ_VoiceRecordHelper.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/29.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^DJVoicePrepareRecorderCompletion)();
typedef void(^DJVoiceStartRecorderCompletion)();
typedef void(^DJVoiceStopRecorderCompletion)();
typedef void(^DJVoicePauseRecorderCompletion)();
typedef void(^DJVoiceResumeRecorderCompletion)();
typedef void(^DJVoiceCancellRecorderDeleteFileCompletion)();
typedef void(^DJVoiceRecordProgress)(float progress);
typedef void(^DJVoicePeakPowerForChannel)(float peakPowerForChannel);

@interface DJ_VoiceRecordHelper : NSObject

@property (nonatomic, copy) DJVoiceStopRecorderCompletion maxTimeStopRecorderCompletion;
@property (nonatomic, copy) DJVoiceRecordProgress recordProgress;
@property (nonatomic, copy) DJVoicePeakPowerForChannel peakPowerForChannel;
@property (nonatomic, copy, readonly) NSString *recordPath;
@property (nonatomic, copy) NSString *recordDuration;
@property (nonatomic) float maxRecordTime; // 默认 60秒为最大
@property (nonatomic, readonly) NSTimeInterval currentTimeInterval;

- (void)prepareRecordingWithPath:(NSString *)path prepareRecorderCompletion:(DJVoicePrepareRecorderCompletion)prepareRecorderCompletion;
- (void)startRecordingWithStartRecorderCompletion:(DJVoiceStartRecorderCompletion)startRecorderCompletion;
- (void)pauseRecordingWithPauseRecorderCompletion:(DJVoicePauseRecorderCompletion)pauseRecorderCompletion;
- (void)resumeRecordingWithResumeRecorderCompletion:(DJVoiceResumeRecorderCompletion)resumeRecorderCompletion;
- (void)stopRecordingWithStopRecorderCompletion:(DJVoiceStopRecorderCompletion)stopRecorderCompletion;
- (void)cancelledDeleteWithCompletion:(DJVoiceCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion;

@end
