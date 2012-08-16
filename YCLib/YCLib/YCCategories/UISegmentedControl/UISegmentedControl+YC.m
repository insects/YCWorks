//
//  UISegmentedControl+YC.m
//  iAlarm
//
//  Created by li shiyong on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+YC.h"
#import "UISegmentedControl+YC.h"

@implementation UISegmentedControl (YC)

- (void)setYCStyle:(YCSegmentedControlStyle)style{
    
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    UIImage *dividerBgImage = nil;
    UIImage *dividerHlBgImage = nil;
    
    NSMutableDictionary *titleTextAttributes = nil;
    NSMutableDictionary *hlTitleTextAttributes = nil;
    
    if (YCSegmentedControlStyleSilver == style) {
        bgImage = [UIImage imageNamed:@"YCSegmentOptionsButtonSilver.png"];
        hlBgImage = [UIImage imageNamed:@"YCSegmentOptionsButtonSelectedSilver.png"];
        bgImage = [bgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        dividerBgImage = [UIImage imageNamed:@"YCSegmentOptionsDividerSilver.png"];
        dividerHlBgImage = [UIImage imageNamed:@"YCSegmentOptionsDividerSelectedSilver.png"];
        
        titleTextAttributes = [NSMutableDictionary dictionaryWithCapacity:3];
        UIColor *titleColor = [UIColor navigationBarSilverTitleColor];
        [titleTextAttributes setObject:titleColor forKey:UITextAttributeTextColor];
        NSValue *value = [NSValue valueWithUIOffset:UIOffsetMake(0, 1.0)];
        [titleTextAttributes setObject:value forKey:UITextAttributeTextShadowOffset];
        UIColor *shadowColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        [titleTextAttributes setObject:shadowColor forKey:UITextAttributeTextShadowColor];
        
        hlTitleTextAttributes = [NSMutableDictionary dictionaryWithCapacity:3];
        UIColor *titleColorHl = [UIColor whiteColor];
        [hlTitleTextAttributes setObject:titleColorHl forKey:UITextAttributeTextColor];
        NSValue *valueHl = [NSValue valueWithUIOffset:UIOffsetMake(0, -1.0)];
        [hlTitleTextAttributes setObject:valueHl forKey:UITextAttributeTextShadowOffset];
        UIColor *shadowColorHl = [UIColor navigationBarSilverTitleColor];
        [hlTitleTextAttributes setObject:shadowColorHl forKey:UITextAttributeTextShadowColor];
         
    }
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forState:barMetrics:)]) {
        //背景
        [self setBackgroundImage:bgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:hlBgImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        //[self setBackgroundImage:hlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:bgImage forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
        //分割线
        [self setDividerImage:dividerBgImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setDividerImage:dividerHlBgImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setDividerImage:dividerHlBgImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        //title
        [self setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        [self setTitleTextAttributes:hlTitleTextAttributes forState:UIControlStateSelected];
    }
    
}

@end
