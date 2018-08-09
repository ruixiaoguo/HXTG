//
//  HZLocation.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZLocation : NSObject

@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *cityId;
@property (copy, nonatomic) NSString *megelId;
@property (copy, nonatomic) NSString *provinceId;
@property (copy, nonatomic) NSString *districtId;

@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
