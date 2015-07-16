//
//  chatButton.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/9.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ChatButtonOpenType) {
    ChatButtonOpenTypeShowSelectionView = 1001,//显示selection选择视图
    ChatButtonOpenTypeShowSelectionDetailView,//显示selection详细选项
    ChatButtonOpenTypeHideSelectionView//隐藏selection视图
};

@interface chatButton : UIButton
@property (nonatomic,assign) ChatButtonOpenType openType;
@end
