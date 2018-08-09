//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>
#define ToolViewW [UIScreen mainScreen].bounds.size.width
#define kDuration 0.3

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *county, *countyId, *districtId;
//    NSArray *cityType;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;
@synthesize locatePicker = _locatePicker;

- (void)dealloc
{
    [super dealloc];
    [_locate release];
    [_locatePicker release];
    [provinces release];
}

-(HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle delegate:(id<HZAreaPickerDelegate>)delegate
{
    
    self = [[[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] objectAtIndex:0] retain];
    if (self) {
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        //加载数据
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            //获取路径对象
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            //获取完整路径
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"citys.plist"];
            
//            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
            provinces  =[[NSArray alloc]initWithContentsOfFile:plistPath];
            
            cities = [[provinces objectAtIndex:0] objectForKey:@"citys"];
            self.locate.province = [[provinces objectAtIndex:0] objectForKey:@"province"];
            self.locate.provinceId = [[provinces objectAtIndex:0] objectForKey:@"provinceId"];

            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            self.locate.cityId = [[cities objectAtIndex:0] objectForKey:@"cityId"];

            
            county = [[cities objectAtIndex:0] objectForKey:@"county"];
            countyId =[[cities objectAtIndex:0] objectForKey:@"countyId"];
//            districtId=[[cities objectAtIndex:0] objectForKey:@"districtId"];
            if (county.count > 0) {
                self.locate.district = [county objectAtIndex:0];
                self.locate.megelId = [countyId objectAtIndex:0];
//                self.locate.districtId=[districtId objectAtIndex:0];

            } else{
                self.locate.district = @"";
                self.locate.megelId = @"";
//                self.locate.districtId =@"";

            }
            
        } else{
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citys.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"citys"];
            self.locate.province = [[provinces objectAtIndex:0] objectForKey:@"province"];
            self.locate.provinceId = [[provinces objectAtIndex:0] objectForKey:@"provinceId"];

            self.locate.city = [cities objectAtIndex:0];
            self.locate.cityId = [cities objectAtIndex:0];

        }
    }
        
    return self;
    
}



#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                return [county count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"province"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                return [county objectAtIndex:row];
                    break;
            default:
                return  @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"province"];
                break;
            case 1:
                return [cities objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"citys"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];

                if (cities.count>0) {
                    
                    county = [[cities objectAtIndex:0] objectForKey:@"county"];
                    countyId = [[cities objectAtIndex:0] objectForKey:@"countyId"];
                    districtId = [[cities objectAtIndex:0] objectForKey:@"districtId"];
                    
                    [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                    [self.locatePicker reloadComponent:2];
                    
                    self.locate.province = [[provinces objectAtIndex:row] objectForKey:@"province"];
                    self.locate.provinceId = [[provinces objectAtIndex:row] objectForKey:@"provinceId"];
                    
                    self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                    self.locate.cityId = [[cities objectAtIndex:0] objectForKey:@"cityId"];
                    
                    if ([county count] > 0) {
                        self.locate.district = [county objectAtIndex:0];
                        self.locate.megelId = [countyId objectAtIndex:0];
                        self.locate.districtId = [districtId objectAtIndex:0];

                        
                    } else{
                        self.locate.district = @"";
                        self.locate.megelId = @"";
                        self.locate.districtId = @"";
                    }
                }
                break;
            case 1:
                county = [[cities objectAtIndex:row] objectForKey:@"county"];
                countyId = [[cities objectAtIndex:row] objectForKey:@"countyId"];
//                districtId = [[cities objectAtIndex:row] objectForKey:@"districtId"];

                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                self.locate.cityId = [[cities objectAtIndex:row] objectForKey:@"cityId"];

                if ([county count] > 0) {
                    self.locate.district = [county objectAtIndex:0];
                    self.locate.megelId  = [countyId objectAtIndex:0];
                    self.locate.districtId  = [districtId objectAtIndex:0];


                } else{
                    self.locate.district = @"";
                    self.locate.megelId = @"";
                    self.locate.districtId =@"";

                }
                break;
            case 2:
                if ([county count] > 0) {
                    self.locate.district = [county objectAtIndex:row];
                    self.locate.megelId = [countyId objectAtIndex:row];
                    self.locate.districtId  = [districtId objectAtIndex:0];

                } else{
                    self.locate.district = @"";
                    self.locate.megelId  = @"";
                    self.locate.districtId =@"";


                }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"citys"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.province = [[provinces objectAtIndex:row] objectForKey:@"province"];
                self.locate.provinceId = [[provinces objectAtIndex:0] objectForKey:@"provinceId"];

                self.locate.city = [cities objectAtIndex:0];
                self.locate.cityId = [cities objectAtIndex:0];

                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                self.locate.cityId = [cities objectAtIndex:row];

                break;
            default:
                break;
        }
    }
    
//    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
//        [self.delegate pickerDidChaneStatus:self];
//    }

}


#pragma mark - animation

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, ToolViewW, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, ToolViewW, self.frame.size.height);
    }];
    [self setUpToolBar];
    
}

- (void)cancelPicker
{

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, ToolViewW, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];
    
}
-(void)setUpToolBar{
    _toolbar=[self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:_toolbar];
}
-(UIToolbar *)setToolbarStyle{
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    toolbar.items=@[centerSpace,lefttem,centerSpace,centerSpace,centerSpace,right,centerSpace,];
    return toolbar;
}
-(void)setToolbarWithPickViewFrame{
    _toolbar.frame=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 40);
}

-(void)remove
{

    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, ToolViewW, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];

}
-(void)doneClick
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, ToolViewW, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         
                     }];

    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }
}
@end
