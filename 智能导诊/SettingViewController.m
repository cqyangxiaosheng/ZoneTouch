//
//  SettingViewController.m
//  智能导诊
//
//  Created by frank on 2017/5/11.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UITextField *theTextField;

@property (nonatomic) NSString *age;
@property (nonatomic) CAPersonSex sex;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitInfo)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableViewDataSource

// 设置section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 设置cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

// 返回在某个cell。与table view的cell类似
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                            forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    for (id obj in cell.contentView.subviews)
    {
        [obj removeFromSuperview];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(15, 0, 65, cell.frame.size.height)];
            [label setText:@"性别"];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setFont:[UIFont systemFontOfSize:16.0f]];
            
            [cell.contentView addSubview:label];
            
            NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"男",@"女",nil];
            
            _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
            _segmentedControl.frame = CGRectMake(cell.frame.size.width - 140, 10, 120, 24.0);
            _segmentedControl.selectedSegmentIndex = self.sex;//设置默认选择项索引
            
            [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:_segmentedControl];
            
            break;
        }
            
        case 1:
        {
            CGRect theTextFieldLeftLabelFrame = CGRectMake(0, 0, 65, cell.frame.size.height);
            
            UILabel *theTextFieldLeftLable = [[UILabel alloc] initWithFrame:theTextFieldLeftLabelFrame];
            [theTextFieldLeftLable setBackgroundColor:[UIColor clearColor]];
            [theTextFieldLeftLable setTextColor:[UIColor blackColor]];
            [theTextFieldLeftLable setFont:[UIFont systemFontOfSize:16.0f]];
            [theTextFieldLeftLable setText:@"年龄"];
            
            CGRect theTextFieldFrame = CGRectMake(15, 0, cell.frame.size.width - 35, cell.frame.size.height);
            
            _theTextField =[[UITextField alloc] initWithFrame:theTextFieldFrame];
            
            [_theTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            [_theTextField setReturnKeyType:UIReturnKeyDone];
            [_theTextField setClearButtonMode:YES];
            [_theTextField setTag:indexPath.row];
            [_theTextField setBackgroundColor:[UIColor whiteColor]];
            [_theTextField setFont:[UIFont boldSystemFontOfSize:16.0f]];
            [_theTextField setText:_age];
            
            [_theTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            
            [_theTextField setPlaceholder:@"请输入被问诊人员年龄"];
            [_theTextField setTextAlignment:NSTextAlignmentRight];
            
            UIColor *textColor = [UIColor colorWithRed:144.0/255
                                                 green:144.0/255
                                                  blue:144.0/255
                                                 alpha:1.0];
            
            [_theTextField setTextColor:textColor];
            
            [cell.contentView addSubview:_theTextField];
            
            [_theTextField setLeftViewMode:UITextFieldViewModeAlways];
            [_theTextField setLeftView:theTextFieldLeftLable];
            
            [_theTextField addTarget:self
                             action:@selector(modifyTextFieldDoneEditing:)
                   forControlEvents:UIControlEventEditingDidEndOnExit];
            
            [_theTextField addTarget:self
                             action:@selector(modifyTextFieldWithText:)
                   forControlEvents:UIControlEventEditingChanged];
            
            break;
        }
            
        default:
            break;
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44.0f;
}

// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 75;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    [footerView setUserInteractionEnabled:YES];
    [footerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *labelAttention = [[UILabel alloc] init];
    [labelAttention setFont:[UIFont systemFontOfSize:16.0f]];
    [labelAttention setTextColor:[UIColor darkGrayColor]];
    [labelAttention setBackgroundColor:[UIColor clearColor]];
    [labelAttention setTextAlignment:NSTextAlignmentLeft];
    
    [labelAttention setFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 75)];
    [labelAttention setText:[NSString stringWithFormat:@"测试结果仅供参考，可能产生误诊、漏诊，不能代替医生和其它医务人员的建议。\n18周岁以下人士禁止使用本测试。"]];
    [labelAttention setFont:[UIFont systemFontOfSize:15.0f]];
    [labelAttention setTextAlignment:NSTextAlignmentLeft];
    [labelAttention setLineBreakMode:NSLineBreakByCharWrapping];
    [labelAttention setNumberOfLines:0];
    
    [footerView addSubview:labelAttention];
    
    return footerView;
}

- (UITableView*)tableView
{
    if (!_tableView) {
        CGRect tableViewFrame = CGRectMake(0,
                                           0,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height);
        
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
        
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        UIColor *tableViewBackgroundColor = [UIColor colorWithRed:239.0f/255.0f
                                                            green:239.0f/255.0f
                                                             blue:244.0f/255.0f
                                                            alpha:1.0f];
        
        [_tableView setBackgroundColor:tableViewBackgroundColor];
        [_tableView setRowHeight:44.0f];
        [_tableView setSectionFooterHeight:75.0f];
        
        [_tableView setBounces:YES];
        [_tableView setScrollEnabled:YES];
        [_tableView setAllowsMultipleSelection:YES];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        
        UITableViewCell *myTableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:@"cell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView addSubview:myTableCell];
    }
    
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_theTextField resignFirstResponder];
}

#pragma mark - UITextFieldEvent

//获得输入栏里面的值
- (void)modifyTextFieldWithText:(UITextField *)textField
{
    _age = textField.text;
}

- (void)modifyTextFieldDoneEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)segmentAction:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.sex = CAPersonMan;
    }
    else if (segmentedControl.selectedSegmentIndex == 1)
    {
        self.sex = CAPersonWoman;
    }
}

- (void)keyboardHide
{
    [self.view endEditing:YES];
}

- (void)submitInfo
{
    if (![self isPureInt:_age]) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请输入正确年龄" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [av show];
        
        return;
    }
    
    if (self.sexAgeBlock != nil) {
        self.sexAgeBlock(_age.integerValue, self.sex);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (void)setSex:(CAPersonSex)personSex
{
    _sex = personSex;
}

@end
