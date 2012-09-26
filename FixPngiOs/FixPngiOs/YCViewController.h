//
//  YCViewController.h
//  FixPngiOs
//
//  Created by li shiyong on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextField *textFieldSrc;
@property (nonatomic, retain) IBOutlet UITextField *textFieldDst;

- (IBAction)bPressed:(id)sender;

@end
