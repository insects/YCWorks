//
//  UITableView+YC.m
//  iAlarm
//
//  Created by li shiyong on 12-7-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIColor+YC.h"
#import "UITableView+YC.h"

@implementation UITableView (YC)

- (void)reloadDataAnimated:(BOOL)animated{
    if (animated) {
        [UIView transitionWithView:self duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve |UIViewAnimationOptionAllowAnimatedContent animations:^{
            [self reloadData];
        } completion:NULL];
    }else {
        [self reloadData];
    }
}

- (void)setYCBackgroundStyle:(YCTableViewBackgroundStyle)BackgroundStyle{
    if (YCTableViewBackgroundStyleSilver == BackgroundStyle) {
        /*
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroundView.image = [UIImage imageNamed:@"YCGroupTableViewSilverBackgroundColor.png"];
        self.backgroundView = backgroundView;
         */
        self.backgroundColor = [UIColor silverTexturedBackgroundColor];
        
    }else  if (YCTableViewBackgroundStyleDefault == BackgroundStyle) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

@end
