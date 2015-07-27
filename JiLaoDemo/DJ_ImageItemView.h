//
//  DJ_ImageItemView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DJ_ImageItemView;
@protocol ImageItemViewDelegate <NSObject>
@optional
-(void)clickDefaultImage:(DJ_ImageItemView *)imageItemView;
-(void)clickImage:(DJ_ImageItemView *)imageItemView;
-(void)clickDeleteButton:(DJ_ImageItemView *)imageItemView;
@end

@interface DJ_ImageItemView : UIView

@property (nonatomic,strong) NSString * imageItemUrl;//图片URL
@property (nonatomic,strong) UIImage * image;//图片
@property (nonatomic,assign) BOOL isDefaultImage;//是否是默认图片

@property (nonatomic,weak) id <ImageItemViewDelegate> delegate;

@end
