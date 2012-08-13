//
//  YCMapsUtility.h
//  iAlarm
//
//  Created by li shiyong on 11-2-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YCLib.h"
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


BOOL YCMKCoordinateRegionIsValid(MKCoordinateRegion region);

//比较数据类型；
BOOL YCMKCoordinateSpanEqualToSpan(MKCoordinateSpan src1,MKCoordinateSpan src2);
BOOL YCMKCoordinateRegionEqualToRegion(MKCoordinateRegion src1,MKCoordinateRegion src2);


//数据类型转换
MKMapRect YCMapRectForRegion(CLRegion *region);
CLRegion* YCRegionForMapRect(MKMapRect mapRect);
CLRegion* YCRegionForCoordinateRegion(MKCoordinateRegion coordinateRegion);

//对MKCoordinateForMapPoint经度超过＋180和－180的情况进行修正
CLLocationCoordinate2D YCCoordinateForMapPoint(MKMapPoint mapPoint);

//MKMapRect的中心点
MKMapPoint YCMapRectCenter(MKMapRect mapRect);

NSString* YCGetAddressString(MKPlacemark* placemark);
NSString* YCGetAddressShortString(MKPlacemark* placemark);
NSString* YCGetAddressTitleString(MKPlacemark* placemark);
 






