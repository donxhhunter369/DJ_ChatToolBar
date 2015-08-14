//
//  DJ_Common.h
//  JiLaoDemo
//
//  Created by okwei on 15/7/29.
//  Copyright (c) 2015年 Donny.Justin. All rights reserved.
//

#ifndef JiLaoDemo_DJ_Common_h
#define JiLaoDemo_DJ_Common_h

#ifdef DEBUG
#   define DJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DJLog(...)
#endif

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#endif
