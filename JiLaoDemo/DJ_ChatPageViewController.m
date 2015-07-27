//
//  DJ_ChatPageViewController.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_ChatPageViewController.h"
#import "DJ_BottomTabToolView.h"

#import "DJ_OtherSelectionsView.h"//选项视图
#import "DJ_OtherItemsView.h"//上传图片视图
#import "DJ_OtherItemsViewVoice.h"//输入语音


#define NavigationBarHeight 64
#define MyFaceImageOrDocumentViewHeight 160

@interface DJ_ChatPageViewController ()<bottomTabToolViewDelegate,OtherSelectionsViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) DJ_BottomTabToolView * tabToolView;
@property (nonatomic,strong) UIView * backGroundView;//底部背景视图
@property (nonatomic,strong) DJ_OtherSelectionsView * otherSelectionsView;//选项视图
@property (nonatomic,assign) OtherSelectionsViewItemType otherItemType;//这个决定选择了那个详细Item
@property (nonatomic,strong) UITableView * myTableView;//主视图

@property (nonatomic,strong) DJ_OtherItemsView * otherItemsView;//图片
@property (nonatomic,strong) DJ_OtherItemsViewVoice * otherItemsViewVoice;//语音
@end

@implementation DJ_ChatPageViewController{
    CGSize keyboardSize;//键盘size
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
            [view setFrame:CGRectMake(0, MyFaceImageOrDocumentViewHeight, SCREEN_WIDTH, MyFaceImageOrDocumentViewHeight)];
        }
        if (openType == ChatButtonOpenTypeHideSelectionView) {
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
        }else if (openType == ChatButtonOpenTypeShowSelectionView){
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
            
            [self.otherSelectionsView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MyFaceImageOrDocumentViewHeight)];
            
        }else if (openType == ChatButtonOpenTypeShowSelectionDetailView){//这里根据选项卡里面的内容展示不同的内容
#warning --- 这里根据选项卡里面的内容展示不同的内容
            [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, self.tabToolView.bottomTabToolViewHeight)];
            [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height-MyFaceImageOrDocumentViewHeight, self.view.bounds.size.width, MyFaceImageOrDocumentViewHeight)];
#warning --- 通过self.otherItemType来确定显示哪个详细选项
            if (self.otherItemType == OtherSelectionsViewItemTypeImage) {//显示选择的图片
                [self.otherItemsView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MyFaceImageOrDocumentViewHeight)];
            }else if (self.otherItemType == OtherSelectionsViewItemTypeVoice){//语音输入
                [self.otherItemsViewVoice setFrame:CGRectMake(0, 0, SCREEN_WIDTH, MyFaceImageOrDocumentViewHeight)];
            }
        }
    }
    [self.myTableView setFrame:CGRectMake(0, self.topLayoutGuide.length, SCREEN_WIDTH, self.tabToolView.frame.origin.y)];
//    [self.myTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(void)sendMessageButton:(UIButton *)sendMessageBtn{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tabToolView];
    [self.view addSubview:self.backGroundView];
    [self.view addSubview:self.myTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //给TableView添加手势
    UIGestureRecognizer * gesture = [[UIGestureRecognizer alloc] init];
    [gesture setDelegate:self];
    [self.myTableView addGestureRecognizer:gesture];
    //这里添加要显示的视图
    [self.backGroundView addSubview:self.otherSelectionsView];
    [self.backGroundView addSubview:self.otherItemsView];
    [self.backGroundView addSubview:self.otherItemsViewVoice];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height-self.topLayoutGuide.length-self.bottomLayoutGuide.length-keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, SCREEN_WIDTH, self.tabToolView.bottomTabToolViewHeight)];
    [self.backGroundView setFrame:CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, MyFaceImageOrDocumentViewHeight)];
    [self.myTableView setFrame:CGRectMake(0, self.topLayoutGuide.length, SCREEN_WIDTH, self.tabToolView.frame.origin.y)];
}
#pragma mark UIGestureRecognizerDelegate methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.myTableView]) {
        // gesture recognizer
        if ((touch.phase == UITouchPhaseBegan || touch.phase == UITouchPhaseMoved)) {
            [self.tabToolView.inputTextView resignFirstResponder];
            [UIView animateWithDuration:0.25 animations:^{
                [self showOtherItemsView:ChatButtonOpenTypeHideSelectionView andISResetKeyboard:NO];
            }];
        }
        return NO;
    }
    return YES;
}
//键盘出现
- (void)keyboardWillShow:(NSNotification*)notification{
    //键盘size
    keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.25 animations:^{
        [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height - self.topLayoutGuide.length-self.bottomLayoutGuide.length - keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, SCREEN_WIDTH, self.tabToolView.bottomTabToolViewHeight)];
        [self.myTableView setFrame:CGRectMake(0, self.topLayoutGuide.length, SCREEN_WIDTH, self.tabToolView.frame.origin.y)];
//        [self.myTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
}
//键盘消失
- (void)keyboardWillHide:(NSNotification*)notification{
    CGFloat duration = [notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    keyboardSize = CGSizeZero;
    [UIView animateWithDuration:duration animations:^{
        [self.tabToolView setFrame:CGRectMake(0, self.view.bounds.size.height - self.topLayoutGuide.length-self.bottomLayoutGuide.length - keyboardSize.height-self.tabToolView.bottomTabToolViewHeight, SCREEN_WIDTH, self.tabToolView.bottomTabToolViewHeight)];
        [self.myTableView setFrame:CGRectMake(0, self.topLayoutGuide.length, SCREEN_WIDTH, self.tabToolView.frame.origin.y)];
//        [self.myTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DJChatMainCell" forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    return cell;
}
#pragma UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] init];
        [_backGroundView setBackgroundColor:[UIColor clearColor]];
        [_backGroundView setUserInteractionEnabled:YES];
    }
    return _backGroundView;
}
-(DJ_OtherSelectionsView *)otherSelectionsView{
    if (!_otherSelectionsView) {
        _otherSelectionsView = [[DJ_OtherSelectionsView alloc] init];
        [_otherSelectionsView setDelegate:self];
    }
    return _otherSelectionsView;
}
-(DJ_OtherItemsView *)otherItemsView{
    if (!_otherItemsView) {
        _otherItemsView = [[DJ_OtherItemsView alloc] init];
    }
    return _otherItemsView;
}
-(DJ_OtherItemsViewVoice *)otherItemsViewVoice{
    if (!_otherItemsViewVoice) {
        _otherItemsViewVoice = [[DJ_OtherItemsViewVoice alloc] init];
    }
    return _otherItemsViewVoice;
}
-(DJ_BottomTabToolView *)tabToolView{
    if (!_tabToolView) {
        _tabToolView = [[DJ_BottomTabToolView alloc] init];
        [_tabToolView setDelegate:self];
    }
    return _tabToolView;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] init];
        [_myTableView setShowsVerticalScrollIndicator:NO];
        [_myTableView setSeparatorColor:[UIColor colorWithWhite:.95 alpha:1.0]];
        [_myTableView setBackgroundColor:[UIColor clearColor]];
        [_myTableView setTableFooterView:[[UIView alloc] init]];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DJChatMainCell"];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}

@end
