//
//  RequestAreaAlnit.m
//  YongBar
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 grx. All rights reserved.
//

#import "RequestAreaAlnit.h"

@implementation RequestAreaAlnit{
    
}

static RequestAreaAlnit* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

#pragma mark -获取所在地
-(void)getAreaAlnit
{

    _allMegelArray=[[NSMutableArray alloc]initWithCapacity:0];
    _allMegelIdArray=[[NSMutableArray alloc]initWithCapacity:0];
//    _alldistrictIdArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *listArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *ProvinceArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *ProvinceIdArray=[[NSMutableArray alloc]initWithCapacity:0];
//    NSMutableArray *cityTypeArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *allCityArray=[[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *allCityIdArray=[[NSMutableArray alloc]initWithCapacity:0];
    /*! 获取路径对象 */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    /*! 获取完整路径 */
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"citys.plist"];
    DDLog(@"=========plistPath is have %@",plistPath);
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"user/RegionInfo" WithParameter:nil WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        if (responseDict == nil || [responseDict isKindOfClass:[NSNull class]])
        {
            return ;
        }
        
        
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"])
        {

            /*! 所有省 */
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                /*! 省名称 */
                NSString *provinceName = [NSString stringWithFormat:@"%@",[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"region_name"]];
                [ProvinceArray addObject:provinceName];
                /*! 省Id */
                NSString *provinceId = [NSString stringWithFormat:@"%@",[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"region_id"]];
                [ProvinceIdArray addObject:provinceId];

                //                [cityTypeArray addObject:[[responseDict[@"districtList"] objectAtIndex:i] objectForKey:@"areaType"]];
            }
            /*! 所有市 */
            for (int i=0; i<[responseDict[@"data"] count]; i++) {
                /*! 市级下区数量 */
                areaCount = [[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"city"] count];
                /*! 所有市 */
                NSMutableArray *cityArray=[[NSMutableArray alloc]initWithCapacity:0];
                /*! 所有市Id */
                NSMutableArray *cityIdArray=[[NSMutableArray alloc]initWithCapacity:0];
                /*! 所有区 */
                NSMutableArray *megelArray=[[NSMutableArray alloc]initWithCapacity:0];
                /*! 所有区Id */
                NSMutableArray *megelIdArray=[[NSMutableArray alloc]initWithCapacity:0];
                /*! 所有districtId */
                NSMutableArray *megeldistrictIdArray=[[NSMutableArray alloc]initWithCapacity:0];
                for (int j=0; j<areaCount; j++) {
                    /*! 各级省下市名称 */
                    NSString *cityStr =[[[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"city"] objectAtIndex:j] objectForKey:@"region_name"];
                    [cityArray addObject:cityStr];
                    /*! 各级省下市ID */
                    NSString *cityIdStr =[[[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"city"] objectAtIndex:j] objectForKey:@"region_id"];
                    [cityIdArray addObject:cityIdStr];
                    
                    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
                    NSMutableArray *Idarray=[[NSMutableArray alloc]initWithCapacity:0];
                    NSMutableArray *districtIdArray=[[NSMutableArray alloc]initWithCapacity:0];
                    
                    /*! 区 */
                    NSInteger megalCount = [[[[[responseDict[@"data"] objectAtIndex:i] objectForKey:@"city"] objectAtIndex:j] objectForKey:@"county"] count];
                    for (int k=0; k<megalCount; k++) {
                        /*! 区名称 */
                        NSString *area=[[[[[responseDict[@"data"] objectAtIndex:i][@"city"] objectAtIndex:j] objectForKey:@"county"] objectAtIndex:k] objectForKey:@"region_name"];
                        /*! 区Id */
                        NSString *areaId=[[[[[responseDict[@"data"] objectAtIndex:i][@"city"] objectAtIndex:j] objectForKey:@"county"] objectAtIndex:k] objectForKey:@"region_id"];
                        [array addObject:area];
                        [Idarray addObject:areaId];
                        /*! districtId */
//                        NSString *districtId=[[[[[responseDict[@"districtList"] objectAtIndex:i][@"childDistricts"] objectAtIndex:j] objectForKey:@"childDistricts"] objectAtIndex:k] objectForKey:@"districtId"];
//                        [districtIdArray addObject:districtId];
                        
                    }
                    [megelArray addObject:array];
                    [megelIdArray addObject:Idarray];
                    [megeldistrictIdArray addObject:districtIdArray];
                }
                [_allMegelArray addObject:megelArray];
                [_allMegelIdArray addObject:megelIdArray];
//                [_alldistrictIdArray addObject:megeldistrictIdArray];
                [allCityIdArray addObject:cityIdArray];
                [allCityArray addObject:cityArray];
            }
            //            [StandardUserDefaults setObject:cityTypeArray forKey:@"ProvinceId"];
            //            NSLog(@"cityTypeArray=======%@",cityTypeArray);
            /*! 写入Plist文件 */
            for (int i=0; i<ProvinceArray.count; i++) {
                NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
                NSMutableArray *citys=[[NSMutableArray alloc]init];
                /*! 省 */
                NSString *cityStr=ProvinceArray[i];
                NSString *parentId=ProvinceIdArray[i];
                [dictplist setObject:citys forKey:@"citys"];
                [dictplist setObject:cityStr forKey:@"province"];
                [dictplist setObject:parentId forKey:@"provinceId"];
                [listArray addObject:dictplist];
                /*! 市 */
                NSInteger cityCount=[[allCityArray objectAtIndex:i] count];
                for (int j=0; j<cityCount; j++) {
                    NSMutableDictionary *arealist = [[NSMutableDictionary alloc ] init];
                    NSMutableArray *areas=[[NSMutableArray alloc]init];
                    NSMutableArray *areasId=[[NSMutableArray alloc]init];
//                    NSMutableArray *districtId=[[NSMutableArray alloc]init];
                    
                    NSString *areaStr=allCityArray[i][j];
                    NSString *cityId=allCityIdArray[i][j];
                    [arealist setObject:areas forKey:@"county"];
                    [arealist setObject:areasId forKey:@"countyId"];
//                    [arealist setObject:districtId forKey:@"districtId"];
                    
                    [arealist setObject:areaStr forKey:@"city"];
                    [arealist setObject:cityId forKey:@"cityId"];
                    [citys addObject:arealist];
                    /*! 区 */
                    [areas addObjectsFromArray:_allMegelArray[i][j]];
                    [areasId addObjectsFromArray:_allMegelIdArray[i][j]];
//                    [districtId addObjectsFromArray:_alldistrictIdArray[i][j]];
                    
                }
            }
            /*! 写入文件 */
            [listArray writeToFile:plistPath atomically:YES];
        }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        
    } WithFailureBlock:^{
        
    }];
}

@end
