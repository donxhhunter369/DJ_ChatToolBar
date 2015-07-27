//
//  DJ_ChatButton.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatButtonOpenType) {
    ChatButtonOpenTypeShowSelectionView = 1001,//显示selection选择视图
    ChatButtonOpenTypeShowSelectionDetailView,//显示selection详细选项
    ChatButtonOpenTypeHideSelectionView//隐藏selection视图
};


@interface DJ_ChatButton : UIButton
@property (nonatomic,assign) ChatButtonOpenType openType;
@end
