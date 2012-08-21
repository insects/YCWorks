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
    UIColor *tintColor = nil;
    if (YCBarButtonItemStyleSilver == barButtonItemStyle) {
        bgImage = [UIImage imageNamed:@"YCNavigationBarSilverButton.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarSilverButtonPressed.png"];
        doneBgImage = [UIImage imageNamed:@"YCNavigationBarDoneButtonSilver.png"];
        doneHlBgImage = [UIImage imageNamed:@"YCNavigationBarDoneButtonPressedSilver.png"];
        tintColor = [UIColor barButtonItemSilverTintColor];
    }
    
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forState:barMetrics:)]) {
        //背景
        if (UIBarButtonItemStyleDone == self.style) {
            
            [self setBackgroundImage:doneBgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [self setBackgroundImage:doneHlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            
        }else if (UIBarButtonItemStyleBordered == self.style) {
                        
            [self setBackgroundImage:bgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [self setBackgroundImage:hlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            
        }else if (UIBarButtonItemStylePlain == self.style) {
            self.tintColor = tintColor;
        }
    }

}

- (id)initCustomBackButtonWithTitle:(NSString *)title style:(YCBarButtonItemStyle)barButtonItemStyle  target:(id)target action:(SEL)action{
    
    title = title ? title : KTitleBack;
    UIFont *tileFont = [UIFont boldSystemFontOfSize:12.0];//经探测，title使用加粗12号字体
    CGSize size = [title sizeWithFont:tileFont]; //计算title的宽度
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];    
    button.titleLabel.font = tileFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat buttonW = size.width + 20.0;//经探测，加20
    buttonW = (buttonW < 48.0) ? 48.0 : buttonW;//经探测，最小48
    button.bounds = CGRectMake(0.0, 0.0, buttonW, 30.0);//经探测，高30
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 4.0, 0.0, 0.0);//经探测，右偏移4
    
    self = [self initWithCustomView:button];
    [self setCustomBackButtonYCStyle:barButtonItemStyle];
    return self;
}

- (void)setCustomBackButtonYCStyle:(YCBarButtonItemStyle)barButtonItemStyle{
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    UIColor *titleColor = nil;
    UIColor *titleShadowColor = nil;
    CGSize   titleShadowOffset = CGSizeZero;
    
    if (YCBarButtonItemStyleSilver == barButtonItemStyle) {
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarSilverBack.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarSilverBackPressed.png"];
        titleColor = [UIColor whiteColor];
        titleShadowColor = [UIColor darkGrayColor];
        titleShadowOffset = CGSizeMake(0.0, -1.0);
        
    }else if (YCBarButtonItemStyleDefault == barButtonItemStyle){
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarDefaultBack.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarDefaultBackPressed.png"];
        titleColor = [UIColor whiteColor];
        titleShadowColor = [UIColor colorWithWhite:0.1 alpha:0.65];
        titleShadowOffset = CGSizeMake(0.0, -1.0);
        
    }else if (YCBarButtonItemStyleBlack == barButtonItemStyle){
        //
    }
    
    bgImage = [bgImage stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:14 topCapHeight:0];
    
    UIButton *button = (UIButton*)self.customView;    
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setBackgroundImage:hlBgImage forState:UIControlStateHighlighted];
    [button setTitleShadowColor:titleShadowColor  forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = titleShadowOffset;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
}



- (id)initWithSize:(CGSize)size title:(NSString *)title image:(UIImage*)image backgroundImage:(UIImage*)backgroundImage highLightBackgroundImage:(UIImage*)highLightBackgroundImage target:(id)target action:(SEL)action{
    
    //CGRect customFrame = CGRectMake(0, 0, 38, 30);
    CGRect frame = (CGRect){{0,0},size};
    
    UIView *customView = [[[UIView alloc] initWithFrame:frame] autorelease];
    //动画转换的黑背景
    UIImage *switchBgImage = [UIImage imageNamed:@"YCSwitchButtonItemBackground.png"];
    switchBgImage = [switchBgImage stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    UIImageView *switchBgImageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
    switchBgImageView.image = switchBgImage;
    switchBgImageView.hidden = YES;//转换时候再显示，否则影响按钮的边框
    [customView addSubview:switchBgImageView];
    
    
    //按钮
    UIButton *switchButton =  [[[UIButton alloc] initWithFrame:frame] autorelease];
    [customView addSubview:switchButton];
    [switchButton addTarget:target action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (image) 
        [switchButton setImage:image forState:UIControlStateNormal];
    if (title)
        [switchButton setTitle:title forState:UIControlStateNormal];
    
    //按钮的背景
    [switchButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [switchButton setBackgroundImage:highLightBackgroundImage forState:UIControlStateHighlighted];
    
    return  [self initWithCustomView:customView];
    
}

- (id)initWithSize:(CGSize)size title:(NSString *)title image:(UIImage*)image style:(YCBarButtonItemStyle)barButtonItemStyle target:(id)target action:(SEL)action{
    
    //后设置背景
    self = [self initWithSize:size title:title image:image backgroundImage:nil highLightBackgroundImage:nil target:target action:action];
    [self setSwitchButtonYCStyle:barButtonItemStyle];
    
    return self;
}

- (void)setSwitchButtonYCStyle:(YCBarButtonItemStyle)barButtonItemStyle{
    
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    if (YCBarButtonItemStyleSilver == barButtonItemStyle) {
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarSilverButton.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarSilverButtonPressed.png"];
        
        bgImage = [bgImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
        
    }else if (YCBarButtonItemStyleDefault == barButtonItemStyle){
        
        bgImage = [UIImage imageNamed:@"YCNavigationBarDefaultButton.png"];
        hlBgImage = [UIImage imageNamed:@"YCNavigationBarDefaultButtonPressed.png"];
        
        bgImage = [bgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
    }else if (YCBarButtonItemStyleBlack == barButtonItemStyle){
        //
    }
    
    
    UIButton *button = (UIButton*)[self.customView.subviews objectAtIndex:1];//一共2个，第2个是按钮
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setBackgroundImage:hlBgImage forState:UIControlStateHighlighted];
}

- (void)setHidesSwitchBackground:(BOOL)hidesSwitchBackground{
    //按钮转换
    UIView *switchBgView = [[self.customView subviews] objectAtIndex:0]; //一共2个，第1个是按钮背景
    switchBgView.hidden = hidesSwitchBackground;
     
}

- (void)setSwitchTitle:(NSString *)title switchImage:(UIImage*)image{
    UIButton *button = (UIButton*)[self.customView.subviews objectAtIndex:1];//一共2个，第2个是按钮
    if (image) 
        [button setImage:image forState:UIControlStateNormal];
    if (title)
        [button setTitle:title forState:UIControlStateNormal];
}

- (id)initUpDownWithYCStyle:(YCBarButtonItemStyle)style target:(id)target action:(SEL)action{
    
    UISegmentedControl *sgc = [[[UISegmentedControl alloc] initWithItems:
                                             [NSArray arrayWithObjects:
                                              [UIImage imageNamed:@"UIButtonBarArrowUpSmall.png"],
                                              [UIImage imageNamed:@"UIButtonBarArrowDownSmall.png"],
                                              nil]] autorelease];
    
    [sgc addTarget:target action:action forControlEvents:UIControlEventValueChanged];
    sgc.frame = CGRectMake(0, 0, 90, 30);
    sgc.segmentedControlStyle = UISegmentedControlStyleBar;
    sgc.momentary = YES;
    
    
    self = [self initWithCustomView:sgc];
    if (self) {
        [self setUpDownYCStyle:style];
    }
    return self;
    
}

- (void)setUpDownYCStyle:(YCBarButtonItemStyle)style{
    
    UIImage *bgImage = nil;
    UIImage *hlBgImage = nil;
    UIImage *dividerBgImage = nil;
    UIImage *dividerHlBgImage = nil;
    
    if (YCBarButtonItemStyleSilver == style) {
        bgImage = [UIImage imageNamed:@"YCSegmentBarButtonSilverMail.png"];
        hlBgImage = [UIImage imageNamed:@"YCSegmentBarButtonHighlightedSilverMail.png"];
        bgImage = [bgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        hlBgImage = [hlBgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        
        dividerBgImage = [UIImage imageNamed:@"YCSegmentBarDividerSilverMail.png"];
        dividerHlBgImage = [UIImage imageNamed:@"YCSegmentBarDividerHighlightedSilverMail.png"];
        
    }else if (YCBarButtonItemStyleBlack == style) {
        //TODO
    }else {
        //YCBarButtonItemStyleDefault
    }
    
    UISegmentedControl *sgc = (UISegmentedControl*)self.customView;
    if ([sgc respondsToSelector:@selector(setBackgroundImage:forState:barMetrics:)]) {
        //背景
        [sgc setBackgroundImage:bgImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //[sgc setBackgroundImage:hlBgImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [sgc setBackgroundImage:hlBgImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [sgc setBackgroundImage:bgImage forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
        //分割线
        [sgc setDividerImage:dividerBgImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [sgc setDividerImage:dividerHlBgImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [sgc setDividerImage:dividerHlBgImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [sgc setDividerImage:dividerBgImage forLeftSegmentState:UIControlStateDisabled rightSegmentState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
    }
}

@end
