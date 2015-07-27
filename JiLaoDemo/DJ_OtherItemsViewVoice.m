//
//  DJ_OtherItemsViewVoice.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_OtherItemsViewVoice.h"

@interface DJ_OtherItemsViewVoice()
@property (nonatomic,strong) UILabel * voiceTipsLabel;
@property (nonatomic,strong) UIImageView * voiceImageView;
@property (nonatomic,strong) UILabel * voiceBottomLabel;
@end

@implementation DJ_OtherItemsViewVoice

-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1.0f];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.85 alpha:1.0].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self resetUI];
    }
    return self;
}
-(void)resetUI{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}
-(UILabel *)voiceTipsLabel{
    if (!_voiceTipsLabel) {
        _voiceTipsLabel = [[UILabel alloc] init];
    }
    return _voiceTipsLabel;
}
-(UIImageView *)voiceImageView{
    if (!_voiceImageView) {
        _voiceImageView = [[UIImageView alloc] init];
    }
    return _voiceImageView;
}
-(UILabel *)voiceBottomLabel{
    if (!_voiceBottomLabel) {
        _voiceBottomLabel = [[UILabel alloc] init];
    }
    return _voiceBottomLabel;
}
@end
