//
//  YCViewController.m
//  FixPngiOs
//
//  Created by li shiyong on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YCViewController.h"
#import "UIApplication+YC.h"

BOOL normalizePngFile(NSString *dst, NSString *src)
{
    NSString *dir = dst.stringByDeletingLastPathComponent;
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir] == NO)
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:src];
    if (image == nil) return NO;
    
    NSData *data = UIImagePNGRepresentation(image);
    if (data == nil) return NO;
    
    return [data writeToFile:dst atomically:NO];
}

//
void normalizePngFolder(NSString *dst, NSString *src)
{
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:src];
    for (NSString *file in files)
    {
        if ([file.lowercaseString hasSuffix:@".png"])
        {
            normalizePngFile([dst stringByAppendingPathComponent:file], [src stringByAppendingPathComponent:file]);
        }
    }
}

@interface YCViewController ()

@end

@implementation YCViewController

@synthesize label, textFieldSrc, textFieldDst;




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)aa{
    
    NSString *src = self.textFieldSrc.text;
    src = (src != nil) ? src : @"png";
    
    NSString *dst = self.textFieldDst.text;
    dst = (dst != nil) ? dst : @"fixed";
    
    NSString *dstFolder = [[UIApplication sharedApplication].documentsDirectory stringByAppendingPathComponent:dst];
    NSString *srcFolder = [[UIApplication sharedApplication].documentsDirectory stringByAppendingPathComponent:src];
    
    
    normalizePngFolder(dstFolder,srcFolder);
}

- (IBAction)bPressed:(id)sender{
    
    self.label.text = @"....";
    

    [self performSelector:@selector(aa) withObject:nil afterDelay:0.1];
    
    
    self.label.text = @"OK";
    
    
}

@end
