//
//  HXApplyCartController.m
//  HXTG
//
//  Created by grx on 2017/3/31.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXApplyCartController.h"
#import "HXApplayCartCell.h"
#import "HomeRequestModel.h"
#import "HZAreaPickerView.h"
#import "BindCartRequestModel.h"

@interface HXApplyCartController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HZAreaPickerDelegate>{
    NSArray *sectionTitle;          /*! 头标题 */
    NSMutableArray *baseInfoArray;  /*! 基本信息 */
    NSMutableArray *investArray;    /*! 投资调查 */
    NSMutableArray *adressInfoArray;  /*! 地址信息 */
    HXApplayCartCell *cartCell;     /*! 基本信息 */
    HXBuyServerCell *buyServerCell; /*! 已购服务 */
    
    NSIndexPath *selectIndex;
}

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property(nonatomic,strong) UITableView *applyCartTableView;
@property(nonatomic,strong) NSMutableArray *applyCartArray;
@property(nonatomic,strong) NSMutableArray *cartPickerDataArray;

@property(nonatomic,strong) NSMutableArray *allDataArray;

@end

@implementation HXApplyCartController

/*! 懒加载tableview */
-(UITableView *)applyCartTableView
{
    if (!_applyCartTableView) {
        _applyCartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _applyCartTableView.delegate = self;
        _applyCartTableView.dataSource = self;
        _applyCartTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _applyCartTableView.backgroundColor = UIColorBgLightTheme;
        _applyCartTableView.showsVerticalScrollIndicator=NO;
        /*! 基本信息 */
        [_applyCartTableView registerClass:[HXApplayCartCell class] forCellReuseIdentifier:applayCartCellIdentifier];
        /*! 已购服务 */
        [_applyCartTableView registerClass:[HXBuyServerCell class] forCellReuseIdentifier:buyServerCellIdentifier];
    }
    return _applyCartTableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"在线申请";
    self.backButton.hidden = NO;
    self.view.backgroundColor = UIColorBgLightTheme;
   
    sectionTitle = @[@"基本信息(*为必填项)",@"投资调查",@"地址",@"已购服务"];
    self.allDataArray = [NSMutableArray arrayWithCapacity:0];
    self.selectProArray = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.applyCartTableView];
    /*! 显示选择框 */
    [self creatCartPickerView];
    /*! 获取选项信息 */
    [self gaintMemberBindUser];
}

#pragma mark -tableViewDelegete

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitle count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1||section==2) {
        if (self.applyCartArray.count==0) {
            return 0;
        }else{
         return [self.applyCartArray[section] count];
        }
    }else{
        return 1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = UIColorBlackTheme;
    label.font = UIFontSystem14;
    label.frame = CGRectMake(18, 0, 0, 0);
    label.width = 200;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    // 设置文字
    label.text = sectionTitle[section];
    if (section==0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:sectionTitle[section]];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorRedTheme range:NSMakeRange(5,1)];
        label.attributedText = str;
    }
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==3) {
        UIView *header = [[UIView alloc] init];
        header.backgroundColor = UIColorWhite;
        /*! 提交申请 */
        UIButton *submittBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submittBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        submittBtn.titleLabel.font = UIFontSystem16;
        [submittBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
        submittBtn.backgroundColor = UIColorRedTheme;
        submittBtn.layer.cornerRadius = 5;
        [header addSubview:submittBtn];
        [submittBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        submittBtn.sd_layout.leftSpaceToView(header,30).rightSpaceToView(header,30).topSpaceToView(header,20).heightIs(40);
        return header;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1 ||indexPath.section==2) {
        return 44;
    }else{
        return 180;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==3) {
        return 90;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 ||indexPath.section==1 ||indexPath.section==2) {
        cartCell = [tableView dequeueReusableCellWithIdentifier:applayCartCellIdentifier forIndexPath:indexPath];
        cartCell.infoDic = self.applyCartArray[indexPath.section][indexPath.row];;
        cartCell.backgroundColor = [UIColor whiteColor];
        cartCell.tag = indexPath.section*10+indexPath.row+10000;
        cartCell.contentLable.delegate = self;
        return cartCell;
    }else{
        buyServerCell = [tableView dequeueReusableCellWithIdentifier:buyServerCellIdentifier forIndexPath:indexPath];
        if (self.applyCartArray.count!=0) {
            buyServerCell.productArray = productArray;
        }
        WeakSelf(weakSelf);
        buyServerCell.selectProArray = ^(NSMutableArray *selArray){
            weakSelf.selectProArray = selArray;
            DDLog(@"选择产品类型=======%@",weakSelf.selectProArray);
        };
        buyServerCell.backgroundColor = [UIColor whiteColor];
        return buyServerCell;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath;
    /*! 收起键盘 */
    [self stopKeyboard];
    if (indexPath.section==0&&indexPath.row==2) {
        /*! 选择申请类型 */
        DDLog(@"indexPath======选择申请类型");
        [self showPickView:member_LevelArray];
    }else if (indexPath.section==0&&indexPath.row==3){
        /*! 选择职能类别 */
        DDLog(@"indexPath======选择职能类别");
        [self showPickView:jOBArray];
    }else if (indexPath.section==0&&indexPath.row==4){
        /*! 选择年收入 */
        DDLog(@"indexPath======选择年收入");
        [self showPickView:annual_IncomeArray];
    }else if (indexPath.section==1&&indexPath.row==0){
        /*! 选择资金量 */
        DDLog(@"indexPath======选择资金量");
        [self showPickView:capital_AmountArray];
    }else if (indexPath.section==1&&indexPath.row==1){
        /*! 选择投资经验 */
        DDLog(@"indexPath======选择投资经验");
        [self showPickView:investment_ExperienceArray];
    }else if (indexPath.section==1&&indexPath.row==2){
        /*! 选择投资风格 */
        DDLog(@"indexPath======选择投资风格");
        [self showPickView:styleArray];
    }else if (indexPath.section==2&&indexPath.row==0){
        /*! 选择地址 */
        DDLog(@"indexPath======选择地址");
        [self showAdressPickView];
    }
}


#pragma mark - 选择所在地区
-(void)showAdressPickView
{
    if (_cartPickerBackView.frame.origin.y < Main_Screen_Height) {
        [UIView animateWithDuration:0.2 animations:^{
            _cartPickerBackView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 210);
        }];
    }
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    [self.locatePicker showInView:self.view];

}


-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    cartCell = [self.applyCartTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex.row inSection:selectIndex.section]];
    provence = picker.locate.province;
    city = picker.locate.city;
    county = picker.locate.district;
    if ([provence isEqualToString:city]) {
        if ([county isEqualToString:city]) {
            cartCell.contentLable.text = [NSString stringWithFormat:@"%@",provence];
            return;
        }
        cartCell.contentLable.text = [NSString stringWithFormat:@"%@%@",provence,county];
        return;
    }
    cartCell.contentLable.text = [NSString stringWithFormat:@"%@%@%@",provence,city,county];
}


#pragma mark - 创建选择框
-(void)creatCartPickerView
{
    _cartPickerDataArray = [NSMutableArray array];
    _cartPickerBackView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 210)];
    _cartPickerBackView.backgroundColor = ColorWithRGB(246, 246, 246);
    [self.view addSubview:_cartPickerBackView];
    _cartPickerView = [[UIPickerView alloc]init];
    _cartPickerView.dataSource = self;
    _cartPickerView.delegate = self;
    _cartPickerView.backgroundColor = [UIColor whiteColor];
    _cartPickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _cartPickerView.showsSelectionIndicator = NO;
    _cartPickerView.frame = CGRectMake(0, 40, Main_Screen_Width, 170);
    [_cartPickerBackView addSubview:_cartPickerView];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(38, 8, 80, 30);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColorBlueTheme forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_cartPickerBackView addSubview:cancelBtn];
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame = CGRectMake(Main_Screen_Width-122, 8, 80, 30);
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [finishBtn setTitle:@"确定" forState:UIControlStateNormal];
    [finishBtn setTitleColor:UIColorBlueTheme forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [_cartPickerBackView addSubview:finishBtn];
}

#pragma mark - 性别
-(void)showPickView:(NSArray *)selectArray
{
    [self cancelLocatePicker];
    [_cartPickerDataArray removeAllObjects];
    [_cartPickerDataArray addObjectsFromArray:selectArray];
    [_cartPickerView reloadAllComponents];
    [_cartPickerView selectRow:0 inComponent:0 animated:YES];
    if (_cartPickerBackView.frame.origin.y == Main_Screen_Height) {
        [UIView animateWithDuration:0.2 animations:^{
            _cartPickerBackView.frame=CGRectMake(0, Main_Screen_Height-210, Main_Screen_Width, 210);
        }];
    }
}

/*! 取消选择 */
-(void)cancelAction{
    
    if (_cartPickerBackView.frame.origin.y < Main_Screen_Height) {
        [UIView animateWithDuration:0.2 animations:^{
            _cartPickerBackView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 210);
        }];
    }
}

/*! 完成选择 */
-(void)finishAction{
    
    NSInteger selectRow = [self.cartPickerView selectedRowInComponent:0];
    DDLog(@"selectRow=======%@",_cartPickerDataArray[selectRow]);
    cartCell = [self.applyCartTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex.row inSection:selectIndex.section]];
    cartCell.contentLable.text = _cartPickerDataArray[selectRow];
    if (_cartPickerBackView.frame.origin.y < Main_Screen_Height) {
        [UIView animateWithDuration:0.2 animations:^{
            _cartPickerBackView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 210);
        }];
    }
}


#pragma mark Picker Delegate Methods
/*! 返回显示的列数 */
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/*! 返回当前列显示的行数 */
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_cartPickerDataArray count];
}

/*! 返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上 */
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_cartPickerDataArray objectAtIndex:row];
}

#pragma mark - 申请会员卡
-(void)submitBtnClick
{
    [self.allDataArray removeAllObjects];
    for (int i=10000; i<10005; i++) {
        cartCell = (HXApplayCartCell *)[self.applyCartTableView viewWithTag:i];
        NSString *cartCellStr = [NSString stringWithFormat:@"%@",cartCell.contentLable.text];
        [self.allDataArray addObject:cartCellStr];
    }
    
    for (int i=10010; i<10013; i++) {
        cartCell = (HXApplayCartCell *)[self.applyCartTableView viewWithTag:i];
        NSString *cartCellStr = [NSString stringWithFormat:@"%@",cartCell.contentLable.text];
        [self.allDataArray addObject:cartCellStr];
    }
    for (int i=10020; i<10022; i++) {
        cartCell = (HXApplayCartCell *)[self.applyCartTableView viewWithTag:i];
        NSString *cartCellStr = [NSString stringWithFormat:@"%@",cartCell.contentLable.text];
        [self.allDataArray addObject:cartCellStr];
    }
    /*! 验证姓名 */
    NSString *realName = self.allDataArray[0];
    if (realName.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请输入真实姓名" mode:MBProgressHUDModeText];
        return;
    }
    /*! 验证身份证号 */
    NSString *cartNum = self.allDataArray[1];
    if (cartNum.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请输入身份证号码" mode:MBProgressHUDModeText];
        return;
    }
    /*! 验证身份证号是否合法 */
    if ([UtilityFunction verifyIDCardNumber:cartNum]==NO) {
        [HXProgressHUD showMessage:self.view labelText:@"身份证号不合法" mode:MBProgressHUDModeText];
        return;
    }
    /*! 验证申请类型 */
    NSString *style = self.allDataArray[2];
    if (style.length==0) {
        [HXProgressHUD showMessage:self.view labelText:@"请选择申请类型" mode:MBProgressHUDModeText];
        return;
    }
    /*! 申请会员 */
    [self gaintMemberCardApply];
}

-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 会员卡界面选项信息网络请求
-(void)gaintMemberBindUser
{
    annual_IncomeArray = [NSArray array];
    capital_AmountArray = [NSArray array];
    jOBArray = [NSArray array];
    member_LevelArray = [NSArray array];
    investment_ExperienceArray = [NSArray array];
    styleArray = [NSArray array];
    productArray = [NSArray array];
    /*! 年收入 */
    annual_IncomeArray = @[@"10万以下",@"10-20万",@"21-50万",@"51-100万",@"101-500万",@"501-1000万",@"1000万以上"];
    /*! 资金量 */
    capital_AmountArray = @[@"10万以下",@"10-20万",@"21-50万",@"51-100万",@"101-500万",@"501-1000万",@"1000万以上"];
    /*! 投资经验 */
    investment_ExperienceArray = @[@"2年以下",@"2-5年",@"5-10年",@"10-20年",@"20年以上"];
    /*! 职能类别 */
    jOBArray = @[@"公司高管",@"中层管理者",@"一般员工"];
    /*! 会员类型 */
    member_LevelArray = @[@"水晶会员",@"黄金会员",@"黑钻会员"];
    /*! 产品名称 */
    productArray = @[@"专业版",@"VIP版",@"机构版",@"VIP机构版",@"定制版"];
    /*! 投资风格 */
    styleArray = @[@"保守型",@"稳健型",@"激进型",@"积极型",@"平庸型"];
    [self addServerArray];
    [self.applyCartTableView reloadData];
//    [HXLoadingView show];
//    HomeRequestModel *model = [[HomeRequestModel alloc]init];
//    NSDictionary *dict = [model mj_keyValues];
//    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"app/DeskResearch" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
//        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
//        if ([status isEqualToString:@"1"]) {
//            /*! 年收入 */
//            annual_IncomeArray = [responseDict[@"data"][@"Annual_Income"] allValues];
//            DDLog(@"Annual_Income=====%@",responseDict[@"data"][@"Annual_Income"]);
//            annual_IncomeArray = [annual_IncomeArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 资金量 */
//            capital_AmountArray = [responseDict[@"data"][@"Capital_Amount"] allValues];
//            capital_AmountArray = [capital_AmountArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 投资经验 */
//            investment_ExperienceArray = [responseDict[@"data"][@"Investment_Experience"] allValues];
//            investment_ExperienceArray = [investment_ExperienceArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 职能类别 */
//            jOBArray = [responseDict[@"data"][@"JOB"] allValues];
//            jOBArray = [jOBArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 会员类型 */
//            member_LevelArray = [responseDict[@"data"][@"Member_Level"] allValues];
//            member_LevelArray = [member_LevelArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 产品名称 */
//            productArray = [responseDict[@"data"][@"product"] allValues];
//            productArray = [productArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            /*! 投资风格 */
//            styleArray = [responseDict[@"data"][@"style"] allValues];
//            styleArray = [styleArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
//                NSComparisonResult result = [obj1 compare:obj2];
//                return result==NSOrderedDescending;
//            }];
//            [HXLoadingView hide];
//            [self addServerArray];
//            [self.applyCartTableView reloadData];
//        }else{
//            [HXProgressHUD showMessage:self.view labelText:responseDict[@"msg"] mode:MBProgressHUDModeText];
//            [HXLoadingView hide];
//        }
//    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
//        [HXLoadingView hide];
//    } WithFailureBlock:^{
//        [HXLoadingView hide];
//    }];
}

-(void)addServerArray
{
    /*! 基本信息 */
    baseInfoArray = [[NSMutableArray alloc]initWithObjects:@{@"title":@"姓名:",@"isMust":@"yes",@"isSelect":@"no",@"placeholder":@""},@{@"title":@"身份证号码:",@"isMust":@"yes",@"isSelect":@"no",@"placeholder":@""},@{@"title":@"申请类型:",@"isMust":@"yes",@"isSelect":@"yes",@"placeholder":@"请选择申请类型"},@{@"title":@"职能类别:",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择职能类别"},@{@"title":@"年收入:",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择年收入"},nil];
    investArray = [[NSMutableArray alloc]initWithObjects:@{@"title":@"资金量",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择资金量"},@{@"title":@"投资经验",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择投资经验"},@{@"title":@"投资风格",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择投资风格"},nil];
    /*! 地址信息 */
    adressInfoArray = [[NSMutableArray alloc]initWithObjects:@{@"title":@"",@"isMust":@"no",@"isSelect":@"yes",@"placeholder":@"请选择地址"},@{@"title":@"",@"isMust":@"no",@"isSelect":@"no",@"placeholder":@"请输入详细地址"},nil];
    self.applyCartArray = [NSMutableArray arrayWithObjects:baseInfoArray,investArray,adressInfoArray,nil];
}

#pragma mark - 开始申请会员网络请求
-(void)gaintMemberCardApply
{
    [HXLoadingView show];
    BindCartRequestModel *model = [[BindCartRequestModel alloc]init];
    model.user_id = USERID;
    model.realname = self.allDataArray[0];
    model.number = self.allDataArray[1];
    model.vip_id = self.allDataArray[2];
    model.job_id = self.allDataArray[3];
    model.year_id = self.allDataArray[4];
    model.amount_id = self.allDataArray[5];
    model.investment_experience = self.allDataArray[6];
    model.invest_id = self.allDataArray[7];
    model.province = provence;
    model.city = city;
    model.county = county;
    model.address = self.allDataArray[9];
    /*! 所选产品名称 */
    NSString *selectProStr = @"";
    for (NSString *proStr in self.selectProArray) {
        selectProStr = [selectProStr stringByAppendingString:[NSString stringWithFormat:@"%@,",proStr]];
    }
    model.lrving_id = selectProStr;
    model.content = buyServerCell.otherServer.text;
    NSDictionary *dict = [model mj_keyValues];
    [[HXNetClient sharedInstance]NetRequestPOSTWithRequestURL:@"member/MemberCardApply" WithParameter:dict WithReturnValeuBlock:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        NSString *status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
        if ([status isEqualToString:@"1"]) {
        HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:@"提交成功,请等待审核" centerButtonTitle:@"我知道了"];
        alter.centerBlock=^()
        {
            [self.navigationController popViewControllerAnimated:YES];
        };
        [alter show];
        [HXLoadingView hide];
    }else{
        HXAlterview *alter = [[HXAlterview alloc]initWithTitle:@"提示" contentText:responseDict[@"msg"] centerButtonTitle:@"我知道了"];
        alter.centerBlock=^()
        {
        };
        [alter show];
        [HXLoadingView hide];
    }
    } WithErrorBlock:^(NSURLSessionDataTask *task, NSError *error) {
        [HXLoadingView hide];
    } WithFailureBlock:^{
        [HXLoadingView hide];
    }];
}


#pragma mark - 收起键盘
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self stopKeyboard];
}

-(void)stopKeyboard
{
    for (int i=0; i<3; i++) {
        for (int j=0; j<2; j++) {
            cartCell = [self.applyCartTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            [cartCell.contentLable resignFirstResponder];
        }
    }
    [buyServerCell.otherServer resignFirstResponder];
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
