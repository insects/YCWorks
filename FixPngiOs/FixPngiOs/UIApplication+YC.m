//
//  UIApplication-YC.m
//  iAlarm
//
//  Created by li shiyong on 11-3-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIApplication+YC.h"

@implementation UIApplication (YC)


- (NSString *)documentsDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}



- (NSString *)libraryDirectory {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}



@end
