//
//  DJ_OtherItemsViewVoice.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_OtherItemsViewVoice.h"
#define kRecordAudioFile @"myRecord.caf"

@interface DJ_OtherItemsViewVoice()<AVAudioRecorderDelegate>
@property (nonatomic,strong) UIImageView * voiceTipsImageView;
@property (nonatomic,strong) UILabel * voiceTipsLabel;//提示录音多久
@property (nonatomic,strong) UIImageView * voiceImageView;
@property (nonatomic,strong) UILabel * voiceBottomLabel;
#pragma mark - 音频属性
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (nonatomic,strong) UIButton *recordButton;//录音按钮
@property (nonatomic,strong) UIButton *playAndPauseButton;//播放和暂停按钮
@property (nonatomic,strong) UIButton *renewButton;//重新录制
@property (nonatomic,strong) UIProgressView *audioPower;//音频波动
@property (nonatomic,assign) NSTimeInterval recordTime;//录制时间

@end

@implementation DJ_OtherItemsViewVoice

-(void)setVoiceType:(DJ_OtherItemsViewVoiceType)voiceType{
    _voiceType = voiceType;
    if (voiceType == DJ_OtherItemsViewVoiceTypeNotVoice) {
        [self.voiceTipsImageView setHidden:YES];
        [self.voiceTipsLabel setHidden:YES];
        [self.voiceBottomLabel setText:@"长按开始录音"];
        [self.voiceImageView setImage:[UIImage imageNamed:@"录制语音.jpg"]];
        [self.recordButton setImage:[UIImage imageNamed:@"未录制.jpg"] forState:UIControlStateNormal];
    }else if (voiceType == DJ_OtherItemsViewVoiceTypeVoiceing){
        [self.voiceTipsImageView setHidden:NO];
        [self.voiceTipsLabel setHidden:NO];
        [self.voiceBottomLabel setText:@"松开停止录音"];
        [self.voiceImageView setImage:[UIImage imageNamed:@"录制语音.jpg"]];
        [self.recordButton setImage:[UIImage imageNamed:@"录制中.jpg"] forState:UIControlStateNormal];
    }else if (voiceType == DJ_OtherItemsViewVoiceTypeVoiceSuccessed){
        [self.voiceTipsImageView setHidden:YES];
        [self.voiceTipsLabel setHidden:YES];
        [self.voiceBottomLabel setText:@"点击播放"];
        [self.voiceImageView setImage:[UIImage imageNamed:@"录制语音.jpg"]];
        [self.recordButton setImage:[UIImage imageNamed:@"播放.jpg"] forState:UIControlStateNormal];
    }else if (voiceType == DJ_OtherItemsViewVoiceTypeVoiceStop){
        [self.voiceTipsImageView setHidden:YES];
        [self.voiceTipsLabel setHidden:YES];
        [self.voiceBottomLabel setText:@"点击停止"];
    }else if (voiceType == DJ_OtherItemsViewVoiceTypeVoiceRecordFailure){
        [self.voiceTipsImageView setHidden:NO];
        [self.voiceTipsLabel setHidden:NO];
        [self.voiceTipsLabel setText:@"语音时间太短"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.voiceTipsImageView setHidden:YES];
            [self.voiceTipsLabel setHidden:YES];
        });
        [self.voiceBottomLabel setText:@"长按开始录音"];
    }
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1.0f];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.85 alpha:1.0].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
//        [self resetUI];
        [self addSubview:self.voiceTipsImageView];
        [self.voiceTipsImageView addSubview:self.voiceTipsLabel];
        [self addSubview:self.voiceImageView];
        [self.voiceImageView addSubview:self.recordButton];
        [self addSubview:self.voiceBottomLabel];
        [self addSubview:self.playAndPauseButton];
#pragma mark - 设置音频会话
        [self setAudioSession];
    }
    return self;
}
#pragma mark - 私有方法 --- 设置音频会话
/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}
#pragma mark - 取得录音文件保存路径
/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString * urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr = [urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path : %@",urlStr);
    NSURL * url = [NSURL fileURLWithPath:urlStr];
    return url;
}
#pragma mark - 取得录音文件设置
/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary * dicM = [NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道，这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数，分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否采用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //...其他设置
    return dicM;
}
#pragma mark - 获得录音机对象
/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL * url = [self getSavePath];
        //创建录音格式设置
        NSDictionary * setting = [self getAudioSetting];
        //创建录音机
        NSError * error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        [_audioRecorder setDelegate:self];
        [_audioRecorder setMeteringEnabled:YES];//如果要监控声波则必须设置为yes
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}
#pragma mark - 创建播放器
/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url = [self getSavePath];
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [_audioPlayer setNumberOfLoops:0];
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}
#pragma mark - 录音声波监控定制器
/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}
#pragma mark - 录音声波状态设置
/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}
-(NSTimeInterval)recordTime{
    if (!_recordTime) {
        _recordTime = self.audioRecorder.currentTime;
    }
    return _recordTime;
}
#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        //播放
        [self.audioPlayer play];
    }
    NSLog(@"录音完成!");
    self.recordTime = recorder.currentTime;
    [self setVoiceType:DJ_OtherItemsViewVoiceTypeVoiceSuccessed];
}
#pragma mark - 重制UI
/**
 * UI
 */
-(void)resetUI{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}
#pragma mark - recordButtonClick 点击录音与否、播放、是否暂停
-(void)recordButtonClickDown:(UIButton *)btn{
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate = [NSDate distantPast];
    }
    [self setVoiceType:DJ_OtherItemsViewVoiceTypeVoiceing];
}
-(void)recordButtonClickUp:(UIButton *)btn{
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
    }
    [self setVoiceType:DJ_OtherItemsViewVoiceTypeVoiceStop];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.voiceTipsImageView setFrame:CGRectMake(self.frame.size.width/2-60, 0, 120, 30)];
    [self.voiceTipsLabel setFrame:CGRectMake(0, 0, self.voiceTipsImageView.frame.size.width, self.voiceTipsImageView.frame.size.height)];
    [self.voiceImageView setFrame:CGRectMake(50, DistanceFromTopGuiden(self.voiceTipsLabel), self.frame.size.width-100, self.frame.size.height-60)];
    [self.recordButton setFrame:CGRectMake(40, 10, self.voiceImageView.frame.size.width-80, self.voiceImageView.frame.size.height-20)];
    [self.voiceBottomLabel setFrame:CGRectMake(0, DistanceFromTopGuiden(self.voiceImageView), self.frame.size.width, 30)];
}
-(UIImageView *)voiceTipsImageView{
    if (!_voiceTipsImageView) {
        _voiceTipsImageView = [[UIImageView alloc] init];
        [_voiceTipsImageView setBackgroundColor:[UIColor orangeColor]];
    }
    return _voiceTipsImageView;
}
-(UILabel *)voiceTipsLabel{
    if (!_voiceTipsLabel) {
        _voiceTipsLabel = [[UILabel alloc] init];
        [_voiceTipsLabel setTextAlignment:NSTextAlignmentCenter];
        [_voiceTipsLabel setTextColor:[UIColor whiteColor]];
        [_voiceTipsLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _voiceTipsLabel;
}
-(UIImageView *)voiceImageView{
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] init];
        [_voiceImageView setUserInteractionEnabled:YES];
    }
    return _voiceImageView;
}
-(UILabel *)voiceBottomLabel{
    if (!_voiceBottomLabel) {
        _voiceBottomLabel = [[UILabel alloc] init];
        [_voiceBottomLabel setTextAlignment:NSTextAlignmentCenter];
        [_voiceBottomLabel setTextColor:[UIColor lightGrayColor]];
        [_voiceBottomLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _voiceBottomLabel;
}
-(UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButton addTarget:self action:@selector(recordButtonClickDown:) forControlEvents:UIControlEventTouchDown];
        [_recordButton addTarget:self action:@selector(recordButtonClickUp:) forControlEvents:UIControlEventTouchCancel];
    }
    return _recordButton;
}
-(UIButton *)renewButton{
    if (!_renewButton) {
        _renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_renewButton setImage:[UIImage imageNamed:@"重录.jpg"] forState:UIControlStateNormal];
    }
    return _renewButton;
}
-(UIButton *)playAndPauseButton{
    if (!_playAndPauseButton) {
        _playAndPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _playAndPauseButton;
}
@end
