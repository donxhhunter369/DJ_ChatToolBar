//
//  OtherSelectionsBaseView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/16.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "OtherSelectionsBaseView.h"

@interface OtherSelectionsBaseView()
@property (nonatomic,strong) DJ_BadgeAlertView * badgeView;
@end

@implementation OtherSelectionsBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.selectionButton];
        [self addSubview:self.badgeView];
    }
    return self;
}
-(DJ_BadgeAlertView *)badgeView{
    if (!_badgeView) {
        _badgeView = [[DJ_BadgeAlertView alloc] init];
    }
    return _badgeView;
}
-(chatButton *)selectionButton{
    if (!_selectionButton) {
        _selectionButton = [chatButton buttonWithType:UIButtonTypeCustom];
        [_selectionButton setUserInteractionEnabled:NO];
    }
    return _selectionButton;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.selectionButton setFrame:CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20)];
    [self.badgeView setFrame:CGRectMake(DistanceFromLeftGuiden(self.selectionButton)-10, 0, 15, 15)];
}

@end
