//
//  MyLibs.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/14.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLibs : NSObject


//图片缩放到指定大小尺寸
+(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize) size;
@end
