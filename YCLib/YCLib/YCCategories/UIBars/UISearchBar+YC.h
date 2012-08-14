//
//  UISearchBar+YC.h
//  testNavC
//
//  Created by li shiyong on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBar.h"

@interface UISearchBar (YC)

- (UITextField*)textField;

/*
 * 搜索等待圈
 * 4.0版本以上有效
 */
- (void)setShowsSearchingView:(BOOL)showsSearchingView;
- (BOOL)showsSearchingView;

/*
 * 更换bar的背景
 * 5.0版本以上有效
 */
- (void)setYCBarStyle:(YCBarStyle)barStyle;

@end
