//
//  ImageItemView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/14.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "ImageItemView.h"

#define ImageHeigt 110
#define ImageWidth 70

@interface ImageItemView()
@property (nonatomic,strong) UIImageView * defaultImageView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIButton * deleteButton;
@end

@implementation ImageItemView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}
#warning -- 这里要用SDWebImage
-(void)setImageItemUrl:(NSString *)imageItemUrl{
    _imageItemUrl = imageItemUrl;
    [self.imageView setImage:[UIImage imageNamed:imageItemUrl]];
}
-(void)setImage:(UIImage *)image{
    _image = image;
    [self.imageView setImage:image];
}
-(void)setIsDefaultImage:(BOOL)isDefaultImage{
    _isDefaultImage = isDefaultImage;
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
    _isDefaultImage == YES ? ({
        [self addSubview:self.defaultImageView];
    }) : ({
        [self addSubview:self.imageView];
        [self addSubview:self.deleteButton];
    });
    [self layoutSubviews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _isDefaultImage == YES ? ({
        [self.defaultImageView setFrame:CGRectMake(5, 5, ImageWidth, ImageHeigt)];
    }) : ({
        [self.imageView setFrame:CGRectMake(5, 5, ImageWidth, ImageHeigt)];
        [self.deleteButton setFrame:CGRectMake(DistanceFromLeftGuiden(self.imageView)-10, 0, 20, 20)];
    });
}
#pragma mark - defaultImageViewTap 点击默认图片
-(void)defaultImageViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击默认图片");
    if ([self.delegate respondsToSelector:@selector(clickDefaultImage:)]) {
        [self.delegate clickDefaultImage:self];
    }
}
#pragma mark - imageViewTap 点击图片
-(void)imageViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    if ([self.delegate respondsToSelector:@selector(clickImage:)]) {
        [self.delegate clickImage:self];
    }
}
#pragma mark - deleteButtonClick 删除按钮
-(void)deleteButtonClick:(UIButton *)btn{
    NSLog(@"删除");
    if ([self.delegate respondsToSelector:@selector(clickDeleteButton:)]) {
        [self.delegate clickDeleteButton:self];
    }
}
-(UIImageView *)defaultImageView{
    if (!_defaultImageView) {
        _defaultImageView = [[UIImageView alloc] init];
        [_defaultImageView setUserInteractionEnabled:YES];
        [_defaultImageView setImage:[UIImage imageNamed:@"增加选择图片按钮.png"]];
        [_defaultImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(defaultImageViewTap:)]];
    }
    return _defaultImageView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setUserInteractionEnabled:YES];
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)]];
    }
    return _imageView;
}
-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"图片右上角删除按钮.png"] forState:UIControlStateNormal];
        [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [_deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
@end
