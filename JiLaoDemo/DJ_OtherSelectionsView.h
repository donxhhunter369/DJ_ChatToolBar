//
//  DJ_OtherSelectionsView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_BaseView.h"

@protocol OtherSelectionsViewDelegate <NSObject>
@optional
-(void)OtherSelectionsViewSelectImageItemWithType:(OtherSelectionsViewItemType)type;
@end

@interface DJ_OtherSelectionsView : DJ_BaseView

@property (nonatomic,weak) id <OtherSelectionsViewDelegate> delegate;
@property (nonatomic,assign) OtherSelectionsViewItemType type;

@end
