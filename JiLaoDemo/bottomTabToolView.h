//
//  bottomTabToolView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/9.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol bottomTabToolViewDelegate <NSObject>
-(void)sendMessageButton:(UIButton *)sendMessageBtn;
-(void)showOtherItemsView:(ChatButtonOpenType)openType andISResetKeyboard:(BOOL)isResetKeyboard;
@end

@interface bottomTabToolView : UIView

@property (nonatomic,strong) chatButton * moreItemsButton;//更多选项按钮
@property (nonatomic,strong) ChatInputTextView * inputTextView;
@property (nonatomic,weak) id <bottomTabToolViewDelegate> delegate;
-(CGFloat)bottomTabToolViewHeight;

@end
