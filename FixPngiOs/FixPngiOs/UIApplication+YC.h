//
//  UIApplication-YC.h
//  iAlarm
//
//  Created by li shiyong on 11-3-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIApplication (YC)


@property (nonatomic,readonly) NSString* documentsDirectory;     // ~ Documents
@property (nonatomic,readonly) NSString* libraryDirectory;       // ~ Library

 
@end
