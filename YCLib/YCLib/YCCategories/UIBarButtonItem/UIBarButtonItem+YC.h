//
//  UIBarButtonItem+YC.h
//  iAlarm
//
//  Created by li shiyong on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    YCBarButtonItemStyleDefault   = 0,
    YCBarButtonItemStyleBlack ,
    YCBarButtonItemStyleSilver
} YCBarButtonItemStyle;

@interface UIBarButtonItem (YC)

/*
 * 更换BarButtonItem的背景、tintColor
 * 5.0版本以上有效
 */
- (void)setYCStyle:(YCBarButtonItemStyle)barButtonItemStyle;


/*
 * “返回”按钮，如果title 为 nil，那么使用默认“Back”
 * 4.0版本以上有效
 */
- (id)initWithTitle:(NSString *)title style:(YCBarButtonItemStyle)barButtonItemStyle;

- (id)initBackWithTitle:(NSString *)title style:(YCBarButtonItemStyle)barButtonItemStyle;


////////////////////////////////////////////////////////////////////////////////////

/*
 * “转换”按钮，带黑色背景。
 * 内部使用 initWithCustomView:。customView第一个子view是黑色背景，第二个是UIButton
 * 4.0版本以上有效
 */
- (id)initWithSize:(CGSize)size title:(NSString *)title image:(UIImage*)image backgroundImage:(UIImage*)backgroundImage highLightBackgroundImage:(UIImage*)highLightBackgroundImage target:(id)target action:(SEL)action;

/*
 * “转换”按钮，带黑色背景。
 * 是简化 initWithTitle:image:backgroundImage:anotherBackgroundImage:的版本
 * 4.0版本以上有效
 */
- (id)initWithSize:(CGSize)size title:(NSString *)title image:(UIImage*)image style:(YCBarButtonItemStyle)barButtonItemStyle target:(id)target action:(SEL)action;

/*
 * 重要，仅仅对“转换”按钮有效。
 */
- (void)setSwitchButtonYCStyle:(YCBarButtonItemStyle)barButtonItemStyle;

/*
 * 重要，仅仅对“转换”按钮有效。
 */
- (void)setHidesSwitchBackground:(BOOL)hidesSwitchBackground;

/*
 * 重要，仅仅对“转换”按钮有效。
 */
- (void)setSwitchTitle:(NSString *)title switchImage:(UIImage*)image;

////////////////////////////////////////////////////////////////////////////////////

/*
 * “上下”按钮
 * 5.0版本以上有效
 */
- (id)initUpDownWithYCStyle:(YCBarButtonItemStyle)style target:(id)target action:(SEL)action;

/*
 * 重要，仅仅对“上下”按钮有效。
 */
- (void)setUpDownYCStyle:(YCBarButtonItemStyle)style;

@end
