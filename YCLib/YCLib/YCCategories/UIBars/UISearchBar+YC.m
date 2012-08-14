//
//  UISearchBar+YC.m
//  testNavC
//
//  Created by li shiyong on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UISearchBar+YC.h"



@implementation UISearchBar (YC)

//////////////////////////
//

/*
 * searchBar的文本输入框
 */
- (UITextField*)textField{
    UITextField *searchBarTextField = nil;
    NSArray *subViews = [self subviews];
    for (NSInteger i=0; i<subViews.count; i++) {
        UIView *subView = [subViews objectAtIndex:i];
        if ([subView isKindOfClass:[UITextField class]]) {
            searchBarTextField = (UITextField *)subView;
            break;
        }
    }
	return searchBarTextField;
}

/*
 * BookmarkButton, SearchResultsButton, or clearButton
 */
- (UIButton *)textFieldButton{
    UIButton *textFieldButton = nil;
    NSArray *subViews = [self.textField subviews];
    for (NSInteger i=0; i<subViews.count; i++) {
        UIView *subView = [subViews objectAtIndex:i];
        if ([subView isKindOfClass:[UIButton class]]) {
            textFieldButton = (UIButton *)subView;
            break;
        }
    }
	return textFieldButton;
}

//////////////////////////


#define kSearchingViewTag 2012

- (void)setShowsSearchingView:(BOOL)showsSearchingView{
    UITextField *textField = self.textField;
    //UIButton *textFieldButton = self.textFieldButton;
    UIActivityIndicatorView *searchingView = (UIActivityIndicatorView*)[textField viewWithTag:kSearchingViewTag];
    
    if (showsSearchingView) {
        //textFieldButton.alpha = 0.0;
        textField.clearButtonMode = UITextFieldViewModeNever;
        
        if (searchingView == nil) {
            searchingView = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] 
                             autorelease];
            searchingView.tag = kSearchingViewTag;
            //右上固定
            searchingView.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin ;
            
            CGSize textFieldSize = textField.frame.size;
            CGRect searchViewFrame = CGRectMake(textFieldSize.width-19-6,6,19,19);
            searchingView.frame = searchViewFrame; 
            [textField addSubview:searchingView];
            [searchingView startAnimating];
        }

    }else {
        //textFieldButton.alpha = 1.0;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        [searchingView removeFromSuperview];
    }
}

- (BOOL)showsSearchingView{
    UITextField *textField = self.textField;
    UIActivityIndicatorView *searchingView = (UIActivityIndicatorView*)[textField viewWithTag:kSearchingViewTag];
    return searchingView ? YES : NO;
}

- (void)setYCBarStyle:(YCBarStyle)barStyle{
    if (barStyle >= YCBarStyleSilver) {
        if ([self respondsToSelector:@selector(setBackgroundImage:)]) {
            //bar背景
            UIImage *bgImage = [UIImage imageNamed:@"YCSearchBarSilverBackground.png"];
            [self setBackgroundImage:bgImage];
        }
    }else {
        [self setBarStyle:barStyle];
    }
}

@end
