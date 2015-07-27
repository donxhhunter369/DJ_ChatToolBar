//
//  DJ_BottomTabToolView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol bottomTabToolViewDelegate <NSObject>
-(void)sendMessageButton:(UIButton *)sendMessageBtn;
-(void)showOtherItemsView:(ChatButtonOpenType)openType andISResetKeyboard:(BOOL)isResetKeyboard;
@end

@interface DJ_BottomTabToolView : UIView

@property (nonatomic,strong) DJ_ChatButton * moreItemsButton;//更多选项按钮
@property (nonatomic,strong) DJ_ChatInputTextView * inputTextView;
@property (nonatomic,weak) id <bottomTabToolViewDelegate> delegate;
-(CGFloat)bottomTabToolViewHeight;

@end
