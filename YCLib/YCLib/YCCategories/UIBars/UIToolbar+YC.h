//
//  UIToolbar+YC.h
//  YCLib
//
//  Created by li shiyong on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBar.h"

@interface UIToolbar (YC)

/*
 * 更换bar的背景
 * 5.0版本以上有效
 */
- (void)setYCBarStyle:(YCBarStyle)barStyle forToolbarPosition:(UIToolbarPosition)topOrBottom;

@end
