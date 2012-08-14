//
//  UITableView+YC.h
//  iAlarm
//
//  Created by li shiyong on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YCTableViewBackgroundStyleDefault          = 0,
    YCTableViewBackgroundStyleSilver
} YCTableViewBackgroundStyle;

@interface UITableView (YC)

/**
 动画刷新tableView
 **/
//- (void)reloadDataAnimated:(BOOL)animated;

/*
 * 更换tableView的背景
 * 4.0版本以上有效 
 */
- (void)setYCBackgroundStyle:(YCTableViewBackgroundStyle)BackgroundStyle;



@end
