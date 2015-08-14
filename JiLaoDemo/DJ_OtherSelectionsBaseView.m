//
//  DJ_OtherSelectionsBaseView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_OtherSelectionsBaseView.h"

@interface DJ_OtherSelectionsBaseView()
@property (nonatomic,strong) DJ_BadgeAlertView * badgeView;
@end

@implementation DJ_OtherSelectionsBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.selectionButton];
        
    }
    return self;
}
-(void)setItemType:(OtherSelectionsViewItemType)itemType{
    _itemType = itemType;
    if (itemType == OtherSelectionsViewItemTypeImage) {
        [self addSubview:self.badgeView];
    }
}
-(DJ_BadgeAlertView *)badgeView{
    if (!_badgeView) {
        _badgeView = [[DJ_BadgeAlertView alloc] init];
    }
    return _badgeView;
}
-(DJ_ChatButton *)selectionButton{
    if (!_selectionButton) {
        _selectionButton = [DJ_ChatButton buttonWithType:UIButtonTypeCustom];
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
