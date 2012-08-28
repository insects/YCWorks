//
//  Database.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

#import "DB.h"

#define DB_NAME @"sample.db"


@implementation DB


- (BOOL)initDatabase
{
    
	BOOL success;
	NSFileManager *fm = [NSFileManager defaultManager];
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"offset.db"];
	success = [fm fileExistsAtPath:defaultDBPath];
	
	if(success){
		db = [[FMDatabase databaseWithPath:defaultDBPath] retain];
		if ([db open]) {
			[db setShouldCacheStatements:YES];
		}else{
			//NSLog(@"Failed to open database.");
			success = NO;
		}
	}
	
	return success;
     
}


- (void)closeDatabase
{
	[db close];
}


- (FMDatabase *)database
{
	if ([self initDatabase]){
		return db;
	}
	
	return NULL;
}


- (void)dealloc
{
	[self closeDatabase];
	
	[db release];
	[super dealloc];
}

@end
