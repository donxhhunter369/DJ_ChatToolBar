//
//  DJBaseNavigationController.m
//  DJ_Framework
//
//  Created by okwei on 15/7/2.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import "DJBaseNavigationController.h"

@interface DJBaseNavigationController ()

@end

@implementation DJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:255.0/255.0 green:42.0/255.0 blue:48.0/255.0 alpha:1.0]];
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    NSMutableArray * viewControllers = self.viewControllers.mutableCopy;
//    BOOL isNeedUpdate = NO;
//    for (UIViewController * vc in viewControllers) {
//        if([vc isKindOfClass:NSClassFromString(@"OKWScannerVC")] && vc != self.visibleViewController){
//            [viewControllers removeObject:vc];
//            isNeedUpdate = YES;
//            break;
//        }
//    }
//    if (isNeedUpdate) {
//        self.viewControllers = [NSArray arrayWithArray:viewControllers];
//    }
    
    return [super popViewControllerAnimated:animated];
}

-(void)dealloc{
    //    NSLog(@"Dealloc : <%p> %@ ",self,NSStringFromClass([self class]));
}

@end
