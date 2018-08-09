//
//  HXLineTalksController.m
//  HXTG
//
//  Created by grx on 2017/3/23.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "HXLineTalksController.h"
#import "HXLineTalkCell.h"

@interface HXLineTalksController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    HXLineTalkCell *cell;
}

@property(nonatomic,strong) UITableView *lineTalkTableView;

@end

@implementation HXLineTalksController


/*! 懒加载 */
-(UITableView *)lineTalkTableView
{
    if (!_lineTalkTableView) {
        _lineTalkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _lineTalkTableView.delegate = self;
        _lineTalkTableView.dataSource = self;
        _lineTalkTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _lineTalkTableView.backgroundColor = UIColorBgLightTheme;
        [_lineTalkTableView registerClass:[HXLineTalkCell class] forCellReuseIdentifier:LineTalkCellIdentifier];

    }
    return _lineTalkTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.lineTalkTableView];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:LineTalkCellIdentifier forIndexPath:indexPath];
    WeakSelf(weakSelf);
    cell.keyBoadShow = ^(){
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.lineTalkTableView.frame = CGRectMake(0, -120, Main_Screen_Width, Main_Screen_Height+120);
        }];
    };
    cell.popToUpViewController = ^(){
        
        if (weakSelf.popToController) {
            weakSelf.popToController();
        }
    };
    
    return cell;
}


#pragma mark - ================滑动收回键盘=============================
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (int i=10; i<14; i++) {
        UITextField *field = (UITextField *)[cell viewWithTag:i];
        [field resignFirstResponder];
    }
    [cell.messageFeild resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        self.lineTalkTableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
