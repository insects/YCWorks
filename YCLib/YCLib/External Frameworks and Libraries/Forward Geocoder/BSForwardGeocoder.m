//
//  Created by Björn Sållarp on 2010-03-13.
//  NO Copyright 2010 MightyLittle Industries. NO rights reserved.
// 
//  Use this code any way you like. If you do like it, please
//  link to my blog and/or write a friendly comment. Thank you!
//
//  Read my blog @ http://blog.sallarp.com
//

#import "YCUtilities.h"
#import "BSForwardGeocoder.h"

@interface BSForwardGeocoder ()
@property (nonatomic, retain) NSURLConnection *geocodeConnection;
@property (nonatomic, retain) NSMutableData *geocodeConnectionData;
#if NS_BLOCKS_AVAILABLE
@property (nonatomic, copy) BSForwardGeocoderSuccess successBlock;
@property (nonatomic, copy) BSForwardGeocoderFailed failureBlock;
#endif
@end

@implementation BSForwardGeocoder
@synthesize geocodeConnection = _geocodeConnection;
@synthesize geocodeConnectionData = _geocodeConnectionData;
@synthesize delegate = _delegate;
@synthesize useHTTP = _useHTTP;
@synthesize timeoutInterval = _timeoutInterval;

#if NS_BLOCKS_AVAILABLE
@synthesize successBlock = _successBlock;
@synthesize failureBlock = _failureBlock;
@synthesize searchQuery = _searchQuery;
#endif

- (void)dealloc
{    
#if NS_BLOCKS_AVAILABLE    
    [_successBlock release];
    [_failureBlock release];
#endif
    
    [self.geocodeConnection cancel];    
    [_geocodeConnection release];
    [_geocodeConnectionData release];
    
	[super dealloc];
}

- (id)init{
    self = [self initWithDelegate:nil];
	return self;
}

- (id)initWithDelegate:(id<BSForwardGeocoderDelegate>)aDelegate
{
	if ((self = [super init])) {
		_delegate = aDelegate;
        _timeoutInterval = 10.0;
	}
	return self;
}

// Use Core Foundation method to URL-encode strings, since -stringByAddingPercentEscapesUsingEncoding:
// doesn't do a complete job. For details, see:
//   http://simonwoodside.com/weblog/2009/4/22/how_to_really_url_encode/
//   http://stackoverflow.com/questions/730101/how-do-i-encode-in-a-url-in-an-html-attribute-value/730427#730427
- (NSString *)URLEncodedString:(NSString *)string
{
    NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                  (CFStringRef)string,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8);
    return [encodedString autorelease];
}


- (void)parseGeocodeResponseWithData:(NSData *)responseData
{
	NSError *parseError = nil;
	
    // Run the KML parser
    BSGoogleV3KmlParser *parser = [[BSGoogleV3KmlParser alloc] init];
    [parser parseXMLData:responseData parseError:&parseError ignoreAddressComponents:NO];
	
    BOOL handeledByBlocks = NO;
    
#if NS_BLOCKS_AVAILABLE
    if (self.successBlock && parser.statusCode == G_GEO_SUCCESS) {
        self.successBlock(parser.results);
        handeledByBlocks = YES;
    }
    else if (self.failureBlock) {
        self.failureBlock(parser.statusCode, [parseError localizedDescription]);
        handeledByBlocks = YES;
    }
    [_successBlock release];_successBlock = nil; //2012-6-20 添加 李世勇
    [_failureBlock release];_failureBlock = nil; //2012-6-20 添加 李世勇
#endif
	
    if (!handeledByBlocks && self.delegate) {
        if (!parseError && parser.statusCode == G_GEO_SUCCESS) {
            [self.delegate forwardGeocodingDidSucceed:self withResults:parser.results];
        }
        else if ([self.delegate respondsToSelector:@selector(forwardGeocoderDidFail:withErrorMessage:)]) {
            [self.delegate forwardGeocodingDidFail:self withErrorCode:parser.statusCode andErrorMessage:[parseError localizedDescription]];
        }        
    }
    
    [parser release];
}

- (void)geocoderConnectionFailedWithErrorMessage:(NSString *)errorMessage
{
    BOOL handeledByBlocks = NO;
    
#if NS_BLOCKS_AVAILABLE
    if (self.failureBlock) {
        self.failureBlock(G_GEO_NETWORK_ERROR, errorMessage);
        handeledByBlocks = YES;
    }
    else if (self.delegate && [self.delegate respondsToSelector:@selector(forwardGeocoderConnectionDidFail:withErrorMessage:)]) {
        [self.delegate forwardGeocoderConnectionDidFail:self withErrorMessage:errorMessage];
        handeledByBlocks = YES;
    }
    [_successBlock release];_successBlock = nil; //2012-6-20 添加 李世勇
    [_failureBlock release];_failureBlock = nil; //2012-6-20 添加 李世勇
#endif
    
    if (!handeledByBlocks && self.delegate && [self.delegate respondsToSelector:@selector(forwardGeocoderConnectionDidFail:withErrorMessage:)]) {
        [self.delegate forwardGeocoderConnectionDidFail:self withErrorMessage:errorMessage];
    }

    
    self.geocodeConnectionData = nil;
    self.geocodeConnection = nil;
}

#pragma mark - NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    if (response.statusCode != 200) {
        [self.geocodeConnection cancel];
        [self geocoderConnectionFailedWithErrorMessage:@"Google returned an invalid status code"];
    }
    else {
        self.geocodeConnectionData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.geocodeConnectionData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self geocoderConnectionFailedWithErrorMessage:[error localizedDescription]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.geocodeConnection = nil;    
    [self parseGeocodeResponseWithData:self.geocodeConnectionData];
    self.geocodeConnectionData = nil;
}

- (void)forwardGeocodeWithQuery:(NSString *)searchQuery regionBiasing:(NSString *)regionBiasing
{
    /*
    if (self.geocodeConnection) {
        [self.geocodeConnection cancel];
    }
    
    // Create the url object for our request. It's important to escape the 
    // search string to support spaces and international characters
    
    NSString *geocodeUrl = [NSString stringWithFormat:@"%@://maps.google.com/maps/api/geocode/xml?address=%@&sensor=false", self.useHTTP ? @"http" : @"https", [self URLEncodedString:searchQuery]];
    
    if (regionBiasing && ![regionBiasing isEqualToString:@""]) {
        geocodeUrl = [geocodeUrl stringByAppendingFormat:@"&region=%@", regionBiasing];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:geocodeUrl] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10.0];
    self.geocodeConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
     */
    [self forwardGeocodeWithQuery:searchQuery regionBiasing:regionBiasing viewportBiasing:MKMapRectNull];
}

#if NS_BLOCKS_AVAILABLE
- (void)forwardGeocodeWithQuery:(NSString *)location regionBiasing:(NSString *)regionBiasing success:(BSForwardGeocoderSuccess)success failure:(BSForwardGeocoderFailed)failure
{
    /*
    self.successBlock = success;
    self.failureBlock = failure;
    [self forwardGeocodeWithQuery:location regionBiasing:regionBiasing];
     */
    [self forwardGeocodeWithQuery:location regionBiasing:regionBiasing viewportBiasing:MKMapRectNull success:success failure:failure];
}
#endif

///////////////////////////////////////
//2012-04-26 lishiyong 添加
- (void)forwardGeocodeWithQuery:(NSString *)searchQuery regionBiasing:(NSString *)regionBiasing viewportBiasing:(MKMapRect)bounds{ 
    if (self.geocodeConnection) {
        [self.geocodeConnection cancel];
    }
    
    self.searchQuery= searchQuery;
    
    // Create the url object for our request. It's important to escape the 
    // search string to support spaces and international characters
    
    NSString *geocodeUrl = [NSString stringWithFormat:@"%@://maps.google.com/maps/api/geocode/xml?address=%@&sensor=false", self.useHTTP ? @"http" : @"https", [self URLEncodedString:searchQuery]];
    //NSString *geocodeUrl = [NSString stringWithFormat:@"%@://ditu.google.cn/maps/api/geocode/xml?address=%@&sensor=false", self.useHTTP ? @"http" : @"https", [self URLEncodedString:searchQuery]];
    
    if (regionBiasing && ![regionBiasing isEqualToString:@""]) {
        geocodeUrl = [geocodeUrl stringByAppendingFormat:@"&region=%@", regionBiasing];
    }
    
    if (!MKMapRectIsNull(bounds) && !MKMapRectIsEmpty(bounds)) {//2012-04-26 lishiyong 添加
        //换成坐标边距
        MKMapPoint pSouthWest = MKMapPointMake(MKMapRectGetMinX(bounds), MKMapRectGetMaxY(bounds)); //西南
        CLLocationCoordinate2D cSouthWest = YCCoordinateForMapPoint(pSouthWest);
        
        MKMapPoint pNorthEast = MKMapPointMake(MKMapRectGetMaxX(bounds), MKMapRectGetMinY(bounds)); //东北
        CLLocationCoordinate2D cNorthEast = YCCoordinateForMapPoint(pNorthEast);
        
        NSString *boundsString = @"&bounds=";
        NSString *boundsString1 = [NSString stringWithFormat:@"%.6f,%.6f|%.6f,%.6f",cSouthWest.latitude,cSouthWest.longitude,cNorthEast.latitude,cNorthEast.longitude];
        boundsString = [boundsString stringByAppendingFormat:@"%@",[self URLEncodedString:boundsString1]];
    
        geocodeUrl = [geocodeUrl stringByAppendingFormat:@"%@", boundsString];
        
        
        /*
        NSLog(@"西北坐标 = %@",YCStringFromCLLocationCoordinate2D(MKCoordinateForMapPoint(bounds.origin)));
        NSLog(@"西南坐标 = %@",YCStringFromCLLocationCoordinate2D(cSouthWest));
        NSLog(@"东北坐标 = %@",YCStringFromCLLocationCoordinate2D(cNorthEast));
        NSLog(@"===================================");
         */
         
        
    }
    
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:geocodeUrl] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:_timeoutInterval];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:geocodeUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:_timeoutInterval];
    self.geocodeConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    //NSLog(@"%@",geocodeUrl);
}

- (void)forwardGeocodeWithQuery:(NSString *)location regionBiasing:(NSString *)regionBiasing viewportBiasing:(MKMapRect)bounds success:(BSForwardGeocoderSuccess)success failure:(BSForwardGeocoderFailed)failure{
    
    self.successBlock = success;
    self.failureBlock = failure;
    [self forwardGeocodeWithQuery:location regionBiasing:regionBiasing viewportBiasing:bounds];
}

//2012-04-26 lishiyong 添加
///////////////////////////////////////

//2011-01-04 lishiyong 添加
- (void)cancel{  
    if (self.geocodeConnection) {
        [self.geocodeConnection cancel];
    }
}

- (BOOL)isGeocoding{
    return self.geocodeConnection ? YES : NO;
}


@end
