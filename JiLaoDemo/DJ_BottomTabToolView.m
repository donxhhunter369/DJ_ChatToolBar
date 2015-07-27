//
//  DJ_BottomTabToolView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_BottomTabToolView.h"

@interface DJ_BottomTabToolView()<UITextViewDelegate>

@property (nonatomic,strong) UIButton * sendButton;//发送按钮
@property (nonatomic,strong) UILabel * placeholderLabel;//占位label
@property (nonatomic,strong) DJ_BadgeAlertView * badgeView;
@end

@implementation DJ_BottomTabToolView{
    CGFloat BottomTabToolViewHeight;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        BottomTabToolViewHeight = 30;
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1.0f];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.85 alpha:1.0].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.moreItemsButton];
        [self addSubview:self.sendButton];
        [self addSubview:self.inputTextView];
        [self addSubview:self.badgeView];
        [self.inputTextView addSubview:self.placeholderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
#pragma mark - textViewEditChanged
-(void)textViewEditChanged:(NSNotification *)obj{
    DJ_ChatInputTextView *textView = (DJ_ChatInputTextView *)obj.object;
    if (textView.text.length > 0) {
        [self.sendButton setBackgroundColor:[UIColor redColor]];
        [self.sendButton setEnabled:YES];
        [self.placeholderLabel setHidden:YES];
        [self.placeholderLabel removeFromSuperview];
    }else{
        [self.sendButton setBackgroundColor:[UIColor grayColor]];
        [self.sendButton setEnabled:NO];
        [self.inputTextView addSubview:self.placeholderLabel];
        [self.placeholderLabel setHidden:NO];
    }
    
    CGSize textViewSize = [textView.text boundingRectWithSize:CGSizeMake(ScreenSize.width-100, BottomTabToolViewHeight*5) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size;
    if (textViewSize.height < 30) {
        BottomTabToolViewHeight = 30;
    }else if(textViewSize.height > 120){
        BottomTabToolViewHeight = 120;
    }else{
        BottomTabToolViewHeight = textViewSize.height;
    }
    [self.inputTextView setFrame:CGRectMake(35, 5, ScreenSize.width-100, BottomTabToolViewHeight)];
    
    if (self.moreItemsButton.openType == ChatButtonOpenTypeHideSelectionView) {//隐藏
        [self.delegate showOtherItemsView:ChatButtonOpenTypeHideSelectionView andISResetKeyboard:YES];
    }else if(self.moreItemsButton.openType == ChatButtonOpenTypeShowSelectionView){//显示
        [self.delegate showOtherItemsView:ChatButtonOpenTypeShowSelectionView andISResetKeyboard:YES];
    }else if(self.moreItemsButton.openType == ChatButtonOpenTypeShowSelectionDetailView){//显示详细
        [self.delegate showOtherItemsView:ChatButtonOpenTypeShowSelectionDetailView andISResetKeyboard:YES];
    }
}
#pragma mark - moreItemsButtonClick 更多选项按钮
-(void)moreItemsButtonClick:(DJ_ChatButton *)btn{
    if (btn.openType == ChatButtonOpenTypeHideSelectionView) {//隐藏
        [self.delegate showOtherItemsView:ChatButtonOpenTypeShowSelectionView andISResetKeyboard:NO];
    }else if(btn.openType == ChatButtonOpenTypeShowSelectionView){//显示
        [self.delegate showOtherItemsView:ChatButtonOpenTypeShowSelectionView andISResetKeyboard:NO];
    }else if(btn.openType == ChatButtonOpenTypeShowSelectionDetailView){//显示详细
        [self.delegate showOtherItemsView:ChatButtonOpenTypeShowSelectionView andISResetKeyboard:NO];
    }
}
#pragma mark - sendButtonClick 发送按钮
-(void)sendButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(sendMessageButton:)]) {
        [self.delegate sendMessageButton:btn];
    }
}
-(CGFloat)bottomTabToolViewHeight{
    return BottomTabToolViewHeight + 10;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.moreItemsButton setFrame:CGRectMake(5, 7, 25, 25)];
    [self.inputTextView setFrame:CGRectMake(35, 5, ScreenSize.width-100, BottomTabToolViewHeight)];
    [self.placeholderLabel setFrame:CGRectMake(5, 0, 120, 30)];
    [self.sendButton setFrame:CGRectMake(DistanceFromLeftGuiden(self.inputTextView) + 5, 5,ScreenSize.width - DistanceFromLeftGuiden(self.inputTextView) -  10, 30)];
    [self.badgeView setFrame:CGRectMake(DistanceFromLeftGuiden(self.moreItemsButton)-10, 0, 15, 15)];
}

-(DJ_ChatButton *)moreItemsButton{
    if (!_moreItemsButton) {
        _moreItemsButton = [DJ_ChatButton buttonWithType:UIButtonTypeCustom];
        [_moreItemsButton setImage:[UIImage imageNamed:@"chatAddDocButton.png"] forState:UIControlStateNormal];
        [_moreItemsButton setImageEdgeInsets:UIEdgeInsetsZero];
        [_moreItemsButton addTarget:self action:@selector(moreItemsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_moreItemsButton setOpenType:ChatButtonOpenTypeHideSelectionView];
    }
    return _moreItemsButton;
}
-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton.layer setMasksToBounds:YES];
        [_sendButton.layer setCornerRadius:5.0];
        [_sendButton setBackgroundColor:[UIColor grayColor]];
        [_sendButton setEnabled:NO];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(DJ_ChatInputTextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[DJ_ChatInputTextView alloc] init];
        [_inputTextView.layer setBorderWidth:1];
        [_inputTextView.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1].CGColor];
        [_inputTextView setDelegate:self];
    }
    return _inputTextView;
}
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        [_placeholderLabel setText:@"我也说一句..."];
        [_placeholderLabel setTextAlignment:NSTextAlignmentLeft];
        [_placeholderLabel setTextColor:[UIColor colorWithWhite:0.75 alpha:1]];
        [_placeholderLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _placeholderLabel;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}
-(DJ_BadgeAlertView *)badgeView{
    if (!_badgeView) {
        _badgeView = [[DJ_BadgeAlertView alloc] init];
    }
    return _badgeView;
}


@end
