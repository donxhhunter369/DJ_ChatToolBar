//
//  ViewController.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/9.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "ViewController.h"
#import "bottomTabToolView.h"
#import "OtherItemsView.h"//上传图片视图
#import "OtherSelectionsView.h"//选项视图


#define NavigationBarHeight 64
#define MyFaceImageOrDocumentViewHeight 160


@interface ViewController ()<bottomTabToolViewDelegate,OtherSelectionsViewDelegate>
@property (nonatomic,strong) bottomTabToolView * tabToolView;
@property (nonatomic,strong) UIView * backGroundView;//底部背景视图
@property (nonatomic,strong) OtherItemsView * otherItemsView;
@property (nonatomic,strong) OtherSelectionsView * otherSelectionsView;//选项视图
@property (nonatomic,assign) OtherSelectionsViewItemType otherItemType;//这个决定选择了那个详细Item
@end

@implementation ViewController{
    CGSize keyboardSize;
}

#pragma mark - OtherSelectionsViewDelegate
-(void)OtherSelectionsViewSelectImageItemWithType:(OtherSelectionsViewItemType)type{
    self.otherItemType = type;
    [self showOtherItemsView:ChatButtonOpenTypeShowSelectionDetailView andISResetKeyboard:NO];
}
#pragma mark - bottomTabToolViewDelegate
-(void)showOtherItemsView:(ChatButtonOpenType)openType andISResetKeyboard:(BOOL)isResetKeyboard{
    if (isResetKeyboard == YES) {
        [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
        [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
    }else if(isResetKeyboard == NO){
        if (keyboardSize.height > 0) {
            if ([self.tabToolView.inputTextView isFirstResponder]) {
                [self.tabToolView.inputTextView resignFirstResponder];
            }
        }
        for (id view in self.backGroundView.subviews) {
            [view setFrame:CGRectMake(0, MyFaceImageOrDocumentViewHeight, ScreenSize.width, MyFaceImageOrDocumentViewHeight)];
        }
        if (openType == ChatButtonOpenTypeHideSelectionView) {
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
        }else if (openType == ChatButtonOpenTypeShowSelectionView){
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
            
            [self.otherSelectionsView setFrame:CGRectMake(0, 0, ScreenSize.width, MyFaceImageOrDocumentViewHeight)];
            
        }else if (openType == ChatButtonOpenTypeShowSelectionDetailView){//这里根据选项卡里面的内容展示不同的内容
#warning --- 这里根据选项卡里面的内容展示不同的内容
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
#warning --- 通过self.otherItemType来确定显示哪个详细选项
            if (self.otherItemType == OtherSelectionsViewItemTypeImage) {//显示选择的图片
                [self.otherItemsView setFrame:CGRectMake(0, 0, ScreenSize.width, MyFaceImageOrDocumentViewHeight)];
            }
        }
    }
}
-(void)sendMessageButton:(UIButton *)sendMessageBtn{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setUserInteractionEnabled:YES];
    [self.view addSubview:self.tabToolView];
    [self.view addSubview:self.backGroundView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-self.topLayoutGuide.length-self.bottomLayoutGuide.length-self.tabToolView.bottomTabToolViewHeight, ScreenSize.width, self.tabToolView.bottomTabToolViewHeight)];
    [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height, ScreenSize.width, MyFaceImageOrDocumentViewHeight)];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewControllerTap:)]];
    //这里添加要显示的视图
    [self.backGroundView addSubview:self.otherSelectionsView];
    [self.backGroundView addSubview:self.otherItemsView];
}
-(void)viewControllerTap:(UITapGestureRecognizer *)tap{
    [self showOtherItemsView:ChatButtonOpenTypeHideSelectionView andISResetKeyboard:NO];
}
//键盘出现
- (void)keyboardWillShow:(NSNotification*)notification{
    //键盘size
    keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.25 animations:^{
        [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height - self.topLayoutGuide.length-self.bottomLayoutGuide.length - keyboardSize.height-self.tabToolView.bottomTabToolViewHeight+NavigationBarHeight, ScreenSize.width, self.tabToolView.bottomTabToolViewHeight)];
    } completion:^(BOOL finished) {

    }];
}
//键盘消失
- (void)keyboardWillHide:(NSNotification*)notification{
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    keyboardSize = CGSizeZero;
    [UIView animateWithDuration:duration animations:^{
        [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height - self.topLayoutGuide.length-self.bottomLayoutGuide.length - keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, ScreenSize.width, self.tabToolView.bottomTabToolViewHeight)];
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}
-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] init];
        [_backGroundView setBackgroundColor:[UIColor clearColor]];
        [_backGroundView setUserInteractionEnabled:YES];
    }
    return _backGroundView;
}
-(OtherSelectionsView *)otherSelectionsView{
    if (!_otherSelectionsView) {
        _otherSelectionsView = [[OtherSelectionsView alloc] init];
        [_otherSelectionsView setDelegate:self];
    }
    return _otherSelectionsView;
}
-(OtherItemsView *)otherItemsView{
    if (!_otherItemsView) {
        _otherItemsView = [[OtherItemsView alloc] init];
    }
    return _otherItemsView;
}
-(bottomTabToolView *)tabToolView{
    if (!_tabToolView) {
        _tabToolView = [[bottomTabToolView alloc] init];
        [_tabToolView setDelegate:self];
    }
    return _tabToolView;
}
@end
