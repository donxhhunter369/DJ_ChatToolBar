//
//  DJ_OtherItemsView.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJ_OtherItemsView.h"
#import "DJ_ImageItemView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ELCImagePickerHeader.h"

#define ImageCount 5
#define MySelfHeight 160
#define ItemViewWidth 80
#define ItemViewHeigth 120

@interface DJ_OtherItemsView()<ImageItemViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate, UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * myScrollView;
@property (nonatomic,strong) UILabel * imageCountLabel;//选择了多少张图片，还可以选择多少张
@property (nonatomic,strong) DJ_ImageItemView * defaultImageItemView;
@end

@implementation DJ_OtherItemsView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1.0f];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.85 alpha:1.0].CGColor];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.itemsArray addObject:self.defaultImageItemView];
        [self resetUI];
    }
    return self;
}
-(void)resetUI{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
    
    if (self.itemsArray.count >= ImageCount+1) {
        if ([self.itemsArray containsObject:self.defaultImageItemView]) {
            [self.itemsArray removeObject:self.defaultImageItemView];
            [self.defaultImageItemView removeFromSuperview];
            self.defaultImageItemView = nil;
        }
    }else{
        if (![self.itemsArray containsObject:self.defaultImageItemView])
            [self.itemsArray addObject:self.defaultImageItemView];
    }
    
    [self addSubview:self.imageCountLabel];
    for (int i = 0; i < self.itemsArray.count; i++) {
        [(DJ_ImageItemView *)self.itemsArray[i] setFrame:CGRectMake(15*(i+1) + ItemViewWidth * i, 0, ItemViewWidth, ItemViewHeigth)];
        [self.myScrollView addSubview:(DJ_ImageItemView *)self.itemsArray[i]];
    }
    [self.myScrollView setContentSize:CGSizeMake(ItemViewWidth * self.itemsArray.count + 15*(self.itemsArray.count+1), ItemViewHeigth)];
    [self.myScrollView scrollRectToVisible:CGRectMake(ItemViewWidth * self.itemsArray.count, 0, ItemViewWidth, ItemViewHeigth) animated:YES];
    [self addSubview:self.myScrollView];
    
    self.itemsArray.count > 1 ? ({
        [self.imageCountLabel setText:[NSString stringWithFormat:@"已选%lu张，还可以添加%lu张",self.itemsArray.count-1,ImageCount-(self.itemsArray.count-1)]];
    }) : ({
        [self.imageCountLabel setText:[NSString stringWithFormat:@"共可选择%d张图片",ImageCount]];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:BadgeViewCountChangedNotification object:nil userInfo:@{@"badgeCount":[NSString stringWithFormat:@"%lu",([self.itemsArray containsObject:self.defaultImageItemView] == YES)?self.itemsArray.count - 1:self.itemsArray.count]}];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.myScrollView setFrame:CGRectMake(0, 10, ScreenSize.width, MySelfHeight)];
    [self.imageCountLabel setFrame:CGRectMake(0, self.frame.size.height-20, ScreenSize.width, 20)];
}

#pragma mark - ImageItemViewDelegate
-(void)clickDefaultImage:(DJ_ImageItemView *)imageItemView{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"添加图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册选取", nil];
    [sheet showInView:self.window];
    [self resetUI];
}
-(void)clickImage:(DJ_ImageItemView *)imageItemView{
    NSLog(@"图片处理");
}
-(void)clickDeleteButton:(DJ_ImageItemView *)imageItemView{
    if ([self.itemsArray containsObject:imageItemView]) {
        [self.itemsArray removeObject:imageItemView];
        [imageItemView removeFromSuperview];
        imageItemView = nil;
    }
    [self resetUI];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    UIViewController * currentVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if (0 == buttonIndex) {
        //camera  拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            [imgPicker setDelegate:self];
            [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [currentVC presentViewController:imgPicker animated:YES completion:nil];
        }
    }
    else if(1 == buttonIndex)
    {
        //PhotoLibrary 从相册中选取
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        elcPicker.maximumImagesCount = ImageCount-([self.itemsArray containsObject:self.defaultImageItemView] == YES ? self.itemsArray.count - 1 : self.itemsArray.count); //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
        elcPicker.imagePickerDelegate = self;
        [currentVC presentViewController:elcPicker animated:YES completion:nil];
        
    }else if (2 == buttonIndex)
    {
        //cancel
        //do nothing
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    CGSize size = CGSizeMake(ItemViewWidth-10, ItemViewHeigth-10); //缩放到160x160
    UIImage * reSizeImage = [DJ_MyLibs scaleImage:image ToSize:size];
    DJ_ImageItemView * imageItemView = [[DJ_ImageItemView alloc] init];
    [imageItemView setIsDefaultImage:NO];
    [imageItemView setDelegate:self];
    [imageItemView setImage:reSizeImage];
    [self.itemsArray insertObject:imageItemView atIndex:0];
    [self resetUI];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    UIViewController * currentVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [currentVC dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ELCImagePickerControllerDelegate Methods
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    UIViewController * currentVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [currentVC dismissViewControllerAnimated:YES completion:nil];
    
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                CGSize size = CGSizeMake(ItemViewWidth-10, ItemViewHeigth-10); //缩放到160x160
                UIImage * reSizeImage = [DJ_MyLibs scaleImage:image ToSize:size];
                DJ_ImageItemView * imageItemView = [[DJ_ImageItemView alloc] init];
                [imageItemView setIsDefaultImage:NO];
                [imageItemView setDelegate:self];
                [imageItemView setImage:reSizeImage];
                [self.itemsArray insertObject:imageItemView atIndex:0];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                CGSize size = CGSizeMake(ItemViewWidth-10, ItemViewHeigth-10); //缩放到160x160
                UIImage * reSizeImage = [DJ_MyLibs scaleImage:image ToSize:size];
                DJ_ImageItemView * imageItemView = [[DJ_ImageItemView alloc] init];
                [imageItemView setIsDefaultImage:NO];
                [imageItemView setDelegate:self];
                [imageItemView setImage:reSizeImage];
                [self.itemsArray insertObject:imageItemView atIndex:0];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    [self resetUI];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    UIViewController * currentVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    [currentVC dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *)itemsArray{
    if (!_itemsArray) {
        _itemsArray = @[].mutableCopy;
    }
    return _itemsArray;
}
-(DJ_ImageItemView *)defaultImageItemView{
    if (!_defaultImageItemView) {
        _defaultImageItemView = [[DJ_ImageItemView alloc] init];
        [_defaultImageItemView setIsDefaultImage:YES];
        [_defaultImageItemView setDelegate:self];
    }
    return _defaultImageItemView;
}
-(UILabel *)imageCountLabel{
    if (!_imageCountLabel) {
        _imageCountLabel = [[UILabel alloc] init];
        [_imageCountLabel setTextAlignment:NSTextAlignmentCenter];
        [_imageCountLabel setFont:[UIFont systemFontOfSize:14]];
        [_imageCountLabel setTextColor:[UIColor colorWithWhite:0.6 alpha:1]];
        [_imageCountLabel setText:[NSString stringWithFormat:@"共可选择%d张图片",ImageCount]];
    }
    return _imageCountLabel;
}
-(UIScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] init];
        [_myScrollView setScrollEnabled:YES];
        [_myScrollView setShowsHorizontalScrollIndicator:NO];
        [_myScrollView setShowsVerticalScrollIndicator:NO];
    }
    return _myScrollView;
}


@end
