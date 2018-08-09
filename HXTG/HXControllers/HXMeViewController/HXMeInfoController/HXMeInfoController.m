//
//  HXMeInfoController.m
//  HXTG
//
//  Created by grx on 2017/4/5.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXMeInfoController.h"
#import "HXModiBindTelController.h"
#import "HXModifyEmailController.h"
#import "HXModifyQQController.h"
#import "HXModifyAdressController.h"
#import "HXModifyAuthentController.h"
#import "HXSuccesAuthentController.h"
#import "UserInfoModel.h"
#import "HXMeInfoCell.h"

@interface HXMeInfoController ()<UITableViewDelegate,UITableViewDataSource>{
    HXMeInfoCell *meInfoCell;
    UserInfoModel *infoModel;
}

@property(nonatomic,strong) UITableView *meInfoTableView;
@property(nonatomic,strong) NSArray *meInfoArray;

@end

@implementation HXMeInfoController

/*! 懒加载tableview */
-(UITableView *)meInfoTableView
{
    if (!_meInfoTableView) {
        _meInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _meInfoTableView.delegate = self;
        _meInfoTableView.dataSource = self;
        _meInfoTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _meInfoTableView.backgroundColor = ColorWithRGB(237, 237, 237);
        _meInfoTableView.showsVerticalScrollIndicator=NO;
        [_meInfoTableView registerClass:[HXMeInfoCell class] forCellReuseIdentifier:MeInfoCellIdentifier];
    }
    return _meInfoTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*! 更新用户资料 */
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人资料";
    self.backButton.hidden = NO;
    [self.view addSubview:self.meInfoTableView];
}

#pragma mark -tableViewDelegete
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.meInfoArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    meInfoCell = [tableView dequeueReusableCellWithIdentifier:MeInfoCellIdentifier forIndexPath:indexPath];
    meInfoCell.infoDic = self.meInfoArray[indexPath.row];
    meInfoCell.backgroundColor = [UIColor whiteColor];
    return meInfoCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*! 地址管理 */
    if (indexPath.row==3) {
        HXModifyAdressController *adressVC = [[HXModifyAdressController alloc]init];
        adressVC.provenceId = infoModel.provinceId;
        adressVC.cityId = infoModel.cityId;
        adressVC.countyId = infoModel.countyId;
        adressVC.provence = infoModel.province;
        adressVC.city = infoModel.city;
        adressVC.county = infoModel.county;
        adressVC.adressInfo = infoModel.address;
        [self.navigationController pushViewController:adressVC animated:YES];
        return;
    }
    NSString *AuthentVC;
    if ([infoModel.ischeck isEqualToString:@"0"]) {
        /*! 未认证 */
        AuthentVC = @"HXModifyAuthentController";
    }else{
        /*! 已认证 */
        AuthentVC = @"HXSuccesAuthentController";
    }
    
    NSArray *viewControllers = [NSArray arrayWithObjects:@"HXModiBindTelController",@"HXModifyEmailController",@"HXModifyQQController",@"HXModifyAdressController",AuthentVC,nil];
    UIViewController *selectVC = [[NSClassFromString(viewControllers[indexPath.row]) alloc]init];
    [self.navigationController pushViewController:selectVC animated:YES];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 更新用户资料
-(void)updateUserInfo
{
    /*! 获取个人资料 */
    NSString *infoPath = [GlobalFile directoryPathWithFileName:USERINFO_KEY];
    infoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:infoPath];
    
    NSString *telStr= [NSString stringWithFormat:@"%@",USERPHONE];
    NSString *phoneStr;
    if([telStr rangeOfString:@"*"].location ==NSNotFound)//_roaldSearchText
    {
        /*! 不包含 */
        phoneStr = [telStr stringByReplacingOccurrencesOfString:[telStr substringWithRange:NSMakeRange(3,telStr.length-7)]withString:@"****"];
    }else{
        phoneStr = telStr;
    }
    NSString *email;
    if (infoModel.user_email.length==0 || infoModel.user_email==nil || [infoModel.user_email isEqualToString:@"null"]) {
        email = @"未设置";
    }else{
        if([infoModel.user_email rangeOfString:@"*"].location ==NSNotFound)//_roaldSearchText
        {
            /*! 不包含 */
            NSArray *array = [infoModel.user_email componentsSeparatedByString:@"@"];
            NSString *str = array[0];
            /*! 截取 */
            NSString *emailStr = [array[0] stringByReplacingOccurrencesOfString:[array[0] substringWithRange:NSMakeRange(2,str.length-2)]withString:@"*******"];
            
            email = [NSString stringWithFormat:@"%@@%@",emailStr,array[1]];
        }
        else
        {
            /*! 包含 */
            email = infoModel.user_email;
        }
        
        
    }
    NSString *qq;
    if (infoModel.uqq.length==0 || infoModel.uqq==nil || [infoModel.uqq isEqualToString:@"null"])
    {
        qq = @"未设置";
    }else{
        if([infoModel.uqq rangeOfString:@"*"].location ==NSNotFound)//_roaldSearchText
        {
            /*! 不包含 */
        NSString *qqStr = [NSString stringWithFormat:@"%@",infoModel.uqq];
        qq = [qqStr stringByReplacingOccurrencesOfString:[qqStr substringWithRange:NSMakeRange(2,qqStr.length-2)]withString:@"*******"];
        }else{
            qq = infoModel.uqq;
        }
    }
    
    NSString *addressInfo;
    if (infoModel.address.length==0 || infoModel.address==nil || infoModel.province.length==0) {
        addressInfo = @"未设置";
    }else{
        addressInfo = [NSString stringWithFormat:@"%@省%@市%@%@",infoModel.province,infoModel.city,infoModel.county,infoModel.address];
        if ([infoModel.province isEqualToString:infoModel.city]) {
            addressInfo = [NSString stringWithFormat:@"%@%@%@",infoModel.province,infoModel.county,infoModel.address];
        }
        if ([infoModel.county isEqualToString:infoModel.city]) {
            addressInfo = [NSString stringWithFormat:@"%@%@",infoModel.city,infoModel.address];
        }
    }
    NSString *ischeck;
    if ([infoModel.ischeck isEqualToString:@"0"] || infoModel.ischeck==nil||[infoModel.ischeck isEqualToString:@"null"]) {
        ischeck = @"未认证";
    }else{
        ischeck = @"已认证";
    }
    
    self.meInfoArray = [NSArray arrayWithObjects:@{@"title":@"手机号码",@"discrit":phoneStr},@{@"title":@"电子邮箱",@"discrit":email},@{@"title":@"QQ号码",@"discrit":qq},@{@"title":@"地址管理",@"discrit":addressInfo},@{@"title":@"实名认证",@"discrit":ischeck},nil];
    
    [self.meInfoTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
