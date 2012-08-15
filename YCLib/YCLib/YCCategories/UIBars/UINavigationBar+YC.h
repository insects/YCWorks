//
//  UINavigationBar+YC.h
//  YCLib
//
//  Created by li shiyong on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBar.h"

@interface UINavigationBar (YC)

/*
 * 更换bar的背景
 * 5.0版本以上有效
 */
- (void)setYCBarStyle:(YCBarStyle)barStyle;

/*
 * 用来因为leftBarButtonItem或rightBarButtonItem 改变，而调整topItem的titleView的位置。
 */
- (void)layoutTitleView;

@end
