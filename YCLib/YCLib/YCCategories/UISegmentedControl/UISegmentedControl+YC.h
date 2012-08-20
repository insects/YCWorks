//
//  UISegmentedControl+YC.h
//  iAlarm
//
//  Created by li shiyong on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 未使用

#import <UIKit/UIKit.h>

typedef enum {
    YCSegmentedControlStyleDefault   = 0,
    YCSegmentedControlStyleSilver
} YCSegmentedControlStyle;

@interface UISegmentedControl (YC)

/*
 * 更换背景等
 * 5.0版本以上有效
 */
- (void)setYCStyle:(YCSegmentedControlStyle)style;



@end
