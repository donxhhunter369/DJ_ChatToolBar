//
//  OtherSelectionsView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/14.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtherSelectionsViewDelegate <NSObject>
@optional
-(void)OtherSelectionsViewSelectImageItemWithType:(OtherSelectionsViewItemType)type;
@end

@interface OtherSelectionsView : DJ_BaseView
@property (nonatomic,weak) id <OtherSelectionsViewDelegate> delegate;
@property (nonatomic,assign) OtherSelectionsViewItemType type;
@end
