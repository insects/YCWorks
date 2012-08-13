//
//  UISearchBar+YC.h
//  testNavC
//
//  Created by li shiyong on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (YC)

- (UITextField*)textField;

/*
 * 搜索等待圈
 */
- (void)setShowsSearchingView:(BOOL)showsSearchingView;
- (BOOL)showsSearchingView;

@end
