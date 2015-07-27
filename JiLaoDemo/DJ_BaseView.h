//
//  DJ_BaseView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/16.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OtherSelectionsViewItemTypeDefault = 10000,
    OtherSelectionsViewItemTypeImage,//图片
    OtherSelectionsViewItemTypeVoice,//语音
    OtherSelectionsViewItemTypeFriend,//好友
    OtherSelectionsViewItemTypeLocation,//定位
    OtherSelectionsViewItemTypeBubble,//气泡
} OtherSelectionsViewItemType;

@interface DJ_BaseView : UIView

@end
