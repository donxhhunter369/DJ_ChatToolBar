//
//  DJ_BadgeAlertView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/16.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_BadgeAlertView.h"

@interface DJ_BadgeAlertView()
@property (nonatomic,strong) UILabel * countLabel;
@end

@implementation DJ_BadgeAlertView

-(instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBadgeAlertViewCount:) name:BadgeViewCountChangedNotification object:nil];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBadgeAlertViewCount:) name:BadgeViewCountChangedNotification object:nil];
    }
    return self;
}
-(void)showBadgeAlertViewCount:(NSNotification *)noti{
    NSLog(@"%@",[noti.userInfo objectForKey:@"badgeCount"]);
    if ([[noti.userInfo objectForKey:@"badgeCount"] integerValue] > 0) {
        [self setBackgroundColor:[UIColor redColor]];
        [self.layer setCornerRadius:self.frame.size.width/2];
        [self.countLabel setFrame:CGRectMake(-3, -3, 20, 20)];
        [self addSubview:self.countLabel];
    }else{
        [self setBackgroundColor:[UIColor clearColor]];
        [self.countLabel removeFromSuperview];
        self.countLabel = nil;
    }
    [self.countLabel setText:[noti.userInfo objectForKey:@"badgeCount"]];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BadgeViewCountChangedNotification object:nil];
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        [_countLabel setTextColor:[UIColor whiteColor]];
        [_countLabel setTextAlignment:NSTextAlignmentCenter];
        [_countLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _countLabel;
}

@end
