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

typedef NS_ENUM(NSUInteger, DJ_OtherItemsViewVoiceType) {
    DJ_OtherItemsViewVoiceTypeNotVoice = 0,//没有录制
    DJ_OtherItemsViewVoiceTypeVoiceing,//正在录制
    DJ_OtherItemsViewVoiceTypeVoiceSuccessed,//录制成功可播放
    DJ_OtherItemsViewVoiceTypeVoiceStop,//点击停止
    DJ_OtherItemsViewVoiceTypeVoiceRecordFailure,//录制失败
};

@interface DJ_BaseView : UIView

@end
