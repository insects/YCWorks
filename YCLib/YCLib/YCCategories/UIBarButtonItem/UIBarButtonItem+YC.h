//
//  UIBarButtonItem+YC.h
//  iAlarm
//
//  Created by li shiyong on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YCBarButtonItemStyleDefault   = 0,
    YCBarButtonItemStyleBlack ,
    YCBarButtonItemStyleSilver
} YCBarButtonItemStyle;

@interface UIBarButtonItem (YC)

/*
 * 更换BarButtonItem的背景、tintColor
 * 5.0版本以上有效
 */
- (void)setYCStyle:(YCBarButtonItemStyle)barButtonItemStyle;


/*
 * “返回”按钮，如果title 为 nil，那么使用默认“Back”
 * 4.0版本以上有效
 */
- (id)initWithTitle:(NSString *)title style:(YCBarButtonItemStyle)barButtonItemStyle;


@end
