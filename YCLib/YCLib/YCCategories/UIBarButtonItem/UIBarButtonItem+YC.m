//
//  UIBarButtonItem+YC.m
//  iAlarm
//
//  Created by li shiyong on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LocalizedStringYCLib.h"
#import "UIColor+YC.h"
#import "UIBarButtonItem+YC.h"

@implementation UIBarButtonItem (YC)

- (void)setYCStyle:(YCBarButtonItemStyle)barButtonItemStyle{
    
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    UIImage *doneBgImage = nil;
    UIImage *doneHlBgImage = nil;
    if (YCBarButtonItemStyleSilver == barButtonItemStyle) {
        bgImage = [UIImage imageNamed:@"YCNavigationBarSilverButton.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarSilverButtonPressed.png"];
        doneBgImage = [UIImage imageNamed:@"YCNavigationBarDoneButtonSilver.png"];
        doneHlBgImage = [UIImage imageNamed:@"YCNavigationBarDoneButtonPressedSilver.png"];
    }
    
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forState:barMetrics:)]) {
        //背景
        if (UIBarButtonItemStyleDone == self.style) {
            
            [self setBackgroundImage:doneBgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [self setBackgroundImage:doneHlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            
        }else if (UIBarButtonItemStyleBordered == self.style) {
                        
            [self setBackgroundImage:bgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [self setBackgroundImage:bgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            
        }else if (UIBarButtonItemStylePlain == self.style) {
            self.tintColor = [UIColor barButtonItemSilverTintColor];
        }
    }

}

- (id)initWithTitle:(NSString *)title style:(YCBarButtonItemStyle)barButtonItemStyle{
    
    title = title ? title : KTitleBack;
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    if (YCBarButtonItemStyleSilver == barButtonItemStyle) {
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarSilverBack.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarSilverBackPressed.png"];
        
    }else if (YCBarButtonItemStyleDefault == barButtonItemStyle){
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarDefaultBack.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarDefaultBackPressed.png"];
        
    }else if (YCBarButtonItemStyleBlack == barButtonItemStyle){
        //
    }
    
    bgImage = [bgImage stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    

    
    if ([self respondsToSelector:@selector(setBackButtonBackgroundImage:forState:barMetrics:)]) {//5.0以上
        self = [self initWithTitle:title style:UIBarButtonItemStyleBordered target:nil action:NULL];
        if (self) {
            [self setBackButtonBackgroundImage:bgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [self setBackButtonBackgroundImage:hlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            [self setBackButtonTitlePositionAdjustment:UIOffsetMake(-1.0, 0.0) forBarMetrics:UIBarMetricsDefault];
        }
    }else 
    {//4.x
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = title;
        [button setBackgroundImage:bgImage forState:UIControlStateNormal];
        [button setBackgroundImage:hlBgImage forState:UIControlStateHighlighted];
        
        self = [self initWithCustomView:button];
    }
 
    return self;
}

@end
