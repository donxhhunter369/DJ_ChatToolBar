//
//  ImageItemView.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/14.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageItemView;
@protocol ImageItemViewDelegate <NSObject>
@optional
-(void)clickDefaultImage:(ImageItemView *)imageItemView;
-(void)clickImage:(ImageItemView *)imageItemView;
-(void)clickDeleteButton:(ImageItemView *)imageItemView;
@end

@interface ImageItemView : UIView

@property (nonatomic,strong) NSString * imageItemUrl;//图片URL
@property (nonatomic,strong) UIImage * image;//图片
@property (nonatomic,assign) BOOL isDefaultImage;//是否是默认图片

@property (nonatomic,weak) id <ImageItemViewDelegate> delegate;

@end
