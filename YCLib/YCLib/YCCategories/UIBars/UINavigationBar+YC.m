//
//  UINavigationBar+YC.m
//  YCLib
//
//  Created by li shiyong on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+YC.h"
#import "UINavigationBar+YC.h"

@implementation UINavigationBar (YC)

- (void)setYCBarStyle:(YCBarStyle)barStyle{
    if (barStyle >= YCBarStyleSilver) {
        if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            //bar背景
            UIImage *bgImage = [UIImage imageNamed:@"YCNavigationBarSilverBackground.png"];
            [self setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
            
            //bar title
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
            UIColor *titleColor = [UIColor navigationBarSilverTitleColor];
            [dic setObject:titleColor forKey:UITextAttributeTextColor];
            NSValue *value = [NSValue valueWithUIOffset:UIOffsetMake(0, 1.0)];
            [dic setObject:value forKey:UITextAttributeTextShadowOffset];
            UIColor *shadowColor = [UIColor colorWithWhite:1.0 alpha:0.8];
            [dic setObject:shadowColor forKey:UITextAttributeTextShadowColor];
            self.titleTextAttributes = dic;
            
            //
        }
    }else {
        [self setBarStyle:barStyle];
    }
}

- (void)layoutTitleView{
    /*
    //思路：如果没有BarButtonItem，那么titleView距离边5.0。左右都是这样。
    CGRect titleViewFrame = self.topItem.titleView.frame;
    
    //左
    CGFloat titleViewX = titleViewFrame.origin.x;
    CGFloat titleViewWAddL = 0.0; //因leftBarButtonItem消失，长度的增加
    if (self.topItem.leftBarButtonItem == nil) {
        titleViewX = 5.0;
        titleViewWAddL = titleViewFrame.origin.x - titleViewX;
    }
    
    //右
    CGFloat titleViewWAddR = 0.0;//因RightBarButtonItem消失，长度的增加
    if (self.topItem.rightBarButtonItem == nil) {
        titleViewWAddR = (self.bounds.size.width - 5) - (titleViewFrame.origin.x + titleViewFrame.size.width);
    }
    
    CGRect titleViewFrame1 = titleViewFrame;
    titleViewFrame1.origin.x = titleViewX;
    
    CGRect titleViewFrame2 = titleViewFrame1;
    titleViewFrame2.size.width = titleViewFrame2.size.width + titleViewWAddL + titleViewWAddR;
    */
    
   
    CGRect titleViewFrameNew = CGRectInset(self.bounds, 5, 0);
    [UIView transitionWithView:self duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.topItem.titleView.frame = titleViewFrameNew;
    } completion:NULL];
    
    
}


@end
