//
//  DJ_OtherSelectionsView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_OtherSelectionsView.h"

#define SelectionWidth 60

@interface DJ_OtherSelectionsView()
@property (nonatomic,strong) NSMutableArray * selectionsArray;
@property (nonatomic,strong) DJ_OtherSelectionsBaseView * selectionImageView;//选择图片
@property (nonatomic,strong) DJ_OtherSelectionsBaseView * voiceView;//语音
@property (nonatomic,strong) DJ_OtherSelectionsBaseView * friendView;//好友
@property (nonatomic,strong) DJ_OtherSelectionsBaseView * locationView;//定位
@property (nonatomic,strong) DJ_OtherSelectionsBaseView * bubbleVuew;//气泡
@end

@implementation DJ_OtherSelectionsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1.0f];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.85 alpha:1.0].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUpUI];
    }
    return self;
}
#pragma mark - selectionImageView 图片
-(void)selectionImageViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"图片");
    self.selectionImageView.selectionButton.openType = ChatButtonOpenTypeShowSelectionDetailView;
    self.type = OtherSelectionsViewItemTypeImage;
    if ([self.delegate respondsToSelector:@selector(OtherSelectionsViewSelectImageItemWithType:)]) {
        [self.delegate OtherSelectionsViewSelectImageItemWithType:OtherSelectionsViewItemTypeImage];
    }
}
#pragma mark - voiceView 语音
-(void)voiceViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"语音");
    self.voiceView.selectionButton.openType = ChatButtonOpenTypeShowSelectionDetailView;
    self.type = OtherSelectionsViewItemTypeVoice;
    if ([self.delegate respondsToSelector:@selector(OtherSelectionsViewSelectImageItemWithType:)]) {
        [self.delegate OtherSelectionsViewSelectImageItemWithType:OtherSelectionsViewItemTypeVoice];
    }
}
#pragma mark - friendView 好友
-(void)friendViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"好友");
}
#pragma mark - locationView 定位
-(void)locationViewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"定位");
}
#pragma mark - bubbleVuew 气泡
-(void)bubbleVuewTap:(UITapGestureRecognizer *)tap{
    NSLog(@"气泡");
}
-(void)setUpUI{
    for (int i = 0; i < self.selectionsArray.count; i++) {
        [((DJ_OtherSelectionsBaseView *)self.selectionsArray[i]) setTag:i];
        [((DJ_OtherSelectionsBaseView *)self.selectionsArray[i]) setUserInteractionEnabled:YES];
        [((DJ_OtherSelectionsBaseView *)self.selectionsArray[i]) setFrame:CGRectMake(10*(i%4)+SelectionWidth*(i%4), 10*(i/4)+SelectionWidth*(i/4), SelectionWidth, SelectionWidth)];
        [self addSubview:((DJ_OtherSelectionsBaseView *)self.selectionsArray[i])];
    }
}
-(DJ_OtherSelectionsBaseView *)selectionImageView{
    if (!_selectionImageView) {
        _selectionImageView = [[DJ_OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_selectionImageView.selectionButton setImage:[UIImage imageNamed:@"选择照片按钮.png"] forState:UIControlStateNormal];
        [_selectionImageView.selectionButton setTag:10000];
        [_selectionImageView setItemType:OtherSelectionsViewItemTypeImage];
        [_selectionImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectionImageViewTap:)]];
    }
    return _selectionImageView;
}
-(DJ_OtherSelectionsBaseView *)voiceView{
    if (!_voiceView) {
        _voiceView = [[DJ_OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_voiceView.selectionButton setImage:[UIImage imageNamed:@"语音.jpg"] forState:UIControlStateNormal];
        [_voiceView.selectionButton setTag:10001];
        [_voiceView setItemType:OtherSelectionsViewItemTypeVoice];
        [_voiceView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voiceViewTap:)]];
    }
    return _voiceView;
}
-(DJ_OtherSelectionsBaseView *)friendView{
    if (!_friendView) {
        _friendView = [[DJ_OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_friendView.selectionButton setImage:[UIImage imageNamed:@"好友.jpg"] forState:UIControlStateNormal];
        [_friendView.selectionButton setTag:10002];
        [_friendView setItemType:OtherSelectionsViewItemTypeFriend];
        [_friendView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(friendViewTap:)]];
    }
    return _friendView;
}
-(DJ_OtherSelectionsBaseView *)locationView{
    if (!_locationView) {
        _locationView = [[DJ_OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_locationView.selectionButton setImage:[UIImage imageNamed:@"定位.jpg"] forState:UIControlStateNormal];
        [_locationView.selectionButton setTag:10003];
        [_locationView setItemType:OtherSelectionsViewItemTypeLocation];
        [_locationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationViewTap:)]];
    }
    return _locationView;
}
-(DJ_OtherSelectionsBaseView *)bubbleVuew{
    if (!_bubbleVuew) {
        _bubbleVuew = [[DJ_OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_bubbleVuew.selectionButton setImage:[UIImage imageNamed:@"气泡.jpg"] forState:UIControlStateNormal];
        [_bubbleVuew.selectionButton setTag:10004];
        [_bubbleVuew setItemType:OtherSelectionsViewItemTypeBubble];
        [_bubbleVuew addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleVuewTap:)]];
    }
    return _bubbleVuew;
}
-(NSMutableArray *)selectionsArray{
    if (!_selectionsArray) {
        _selectionsArray = @[self.selectionImageView,self.voiceView,self.friendView,self.locationView,self.bubbleVuew].mutableCopy;
    }
    return _selectionsArray;
}


@end
