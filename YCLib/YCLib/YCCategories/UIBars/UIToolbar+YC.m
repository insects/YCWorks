//
//  UIToolbar+YC.m
//  YCLib
//
//  Created by li shiyong on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIToolbar+YC.h"

@implementation UIToolbar (YC)

- (void)setYCBarStyle:(YCBarStyle)barStyle forToolbarPosition:(UIToolbarPosition)topOrBottom{
    if (barStyle >= YCBarStyleSilver) {
        if ([self respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
            //bar背景
            UIImage *bgImage = [UIImage imageNamed:@"YCToolbarSilverBackground.png"];
            [self setBackgroundImage:bgImage forToolbarPosition:topOrBottom barMetrics:UIBarMetricsDefault];
        }
    }else {
        [self setBarStyle:barStyle];
        if ([self respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
            //bar背景
            [self setBackgroundImage:nil forToolbarPosition:topOrBottom barMetrics:UIBarMetricsDefault];
        }
    }
}

@end
