//
//  DJBaseViewController.m
//  DJ_Framework
//
//  Created by okwei on 15/7/2.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJBaseViewController.h"

@interface DJBaseViewController ()

@end

@implementation DJBaseViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGDefaultColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.navigationController.navigationBar.translucent = NO;
}
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    if (title.length > 3) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]init];
        [self.navigationItem.backBarButtonItem setTitle:@"返回"];
        
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

@end
