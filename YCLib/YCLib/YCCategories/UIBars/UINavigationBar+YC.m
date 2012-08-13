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

@end
