//
//  OtherSelectionsView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/14.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "OtherSelectionsView.h"

#define SelectionWidth 60

@interface OtherSelectionsView()
@property (nonatomic,strong) NSMutableArray * selectionsArray;
@property (nonatomic,strong) OtherSelectionsBaseView * selectionImageView;//选择图片
@end

@implementation OtherSelectionsView

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
-(void)setUpUI{
    for (int i = 0; i < self.selectionsArray.count; i++) {
        [((OtherSelectionsBaseView *)self.selectionsArray[i]) setTag:i];
        [((OtherSelectionsBaseView *)self.selectionsArray[i]) setUserInteractionEnabled:YES];
        [((OtherSelectionsBaseView *)self.selectionsArray[i]) setFrame:CGRectMake(10*(i%4)+SelectionWidth*(i%4), 10*(i/4)+SelectionWidth*(i/4), SelectionWidth, SelectionWidth)];
        [self addSubview:((OtherSelectionsBaseView *)self.selectionsArray[i])];
    }
}
-(OtherSelectionsBaseView *)selectionImageView{
    if (!_selectionImageView) {
        _selectionImageView = [[OtherSelectionsBaseView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [_selectionImageView.selectionButton setImage:[UIImage imageNamed:@"选择照片按钮.png"] forState:UIControlStateNormal];
        [_selectionImageView.selectionButton setTag:10000];
        [_selectionImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectionImageViewTap:)]];
    }
    return _selectionImageView;
}

-(NSMutableArray *)selectionsArray{
    if (!_selectionsArray) {
        _selectionsArray = @[self.selectionImageView].mutableCopy;
    }
    return _selectionsArray;
}
@end
