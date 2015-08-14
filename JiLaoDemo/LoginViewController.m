//
//  LoginViewController.m
//  JiLaoDemo
//
//  Created by okwei on 15/7/27.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "LoginViewController.h"
#import "DJ_ChatPageViewController.h"
#import <objc/runtime.h>



@interface LoginViewController ()
@property (nonatomic,strong) UIButton * loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loginButton];
}
-(void)loginButtonClick:(UIButton *)btn{
    DJ_ChatPageViewController * chatPageVC = [[DJ_ChatPageViewController alloc] init];
    [self.navigationController pushViewController:chatPageVC animated:YES];
}
-(UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"进入聊天页面" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.loginButton setFrame:CGRectMake(80, 250, 150, 40)];
}

@end
