//
//  ViewController.m
//  DatePickerDemo
//
//  Created by LXK on 2016/12/26.
//  Copyright © 2016年 lxkboy. All rights reserved.
//

#import "ViewController.h"
#import "LXKColorChoice.h"
#import "LXKDatePickerView.h"
#import "LXKDatePickerForYMDView.h"
@interface ViewController ()<LXKColorChoiceDelegate,LXKDatePickerViewDelegate,LXKDatePickerForYMDViewDelegate>
@property(nonatomic,strong)LXKDatePickerForYMDView *yearAndMonthAndDayDatePickerView;
@property(nonatomic,strong)LXKDatePickerView *yearAndMonthDatePickerView;
@property(nonatomic,strong)LXKColorChoice *colorDatePickerView;
@property(nonatomic,strong)NSArray *colorArr;
@property(nonatomic,strong)UILabel *selectedResultLabel;
@end

@implementation ViewController
-(NSArray *)colorArr
{
    if (!_colorArr) {
        _colorArr = @[@"红色",@"黄色",@"蓝色",@"绿色",@"黑色",@"白色",@"紫色",@"七彩色",@"绚烂红",@"中国好",@"军绿色"];
    }
    return _colorArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //选择按钮
    for (int i = 0; i <3; i++) {
        UIButton *datePickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        datePickerBtn.frame = CGRectMake(20 + i*80, 50, 60, 30);
        datePickerBtn.backgroundColor = [UIColor grayColor];
        datePickerBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        if (i == 0) {
            [datePickerBtn setTitle:@"年月日" forState:UIControlStateNormal];
        }
        if (i == 1) {
            [datePickerBtn setTitle:@"自定义年月" forState:UIControlStateNormal];
        }
        if (i == 2) {
            [datePickerBtn setTitle:@"自定义文字" forState:UIControlStateNormal];
        }
        datePickerBtn.tag = 10+i;
        [datePickerBtn addTarget:self action:@selector(cliclDatePickerBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:datePickerBtn];
    }
    //显示结果的view
    self.selectedResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.selectedResultLabel.center = self.view.center;
    self.selectedResultLabel.textAlignment = NSTextAlignmentCenter;
    self.selectedResultLabel.textColor = [UIColor redColor];
    self.selectedResultLabel.text = @"选择结果显示";
    [self.view addSubview:self.selectedResultLabel];
}
-(void)cliclDatePickerBtn:(UIButton *)btn
{
//通过tag值获取btn
    switch (btn.tag - 10) {
        case 0:
            //年月日
            self.yearAndMonthAndDayDatePickerView = [LXKDatePickerForYMDView makeViewWithMask:self.view.frame setTitle:@"年月日选择"];
            self.yearAndMonthAndDayDatePickerView.delegate = self;
            break;
        case 1:
            //年月
            self.yearAndMonthDatePickerView = [LXKDatePickerView makeViewWithMaskDatePicker:self.view.frame setTitle:@"年月选择"];
            self.yearAndMonthDatePickerView.delegate = self;
            break;
        case 2:
            //颜色选择
            self.colorDatePickerView = [LXKColorChoice makeViewWithMaskDatePicker:self.view.frame setTitle:@"颜色选择" Arr:self.colorArr];
            self.colorDatePickerView.delegate = self;
            break;
        default:
            break;
    }
}
#pragma mark == 年月日代理方法
-(void)getdatepickerForYearMonthDayChangeValues:(NSString *)dayStr
{
    self.selectedResultLabel.text = dayStr;
}
#pragma mark == 年月代理方法
-(void)getdatepickerForYearAndMonthChangeValues:(NSString *)values
{
    self.selectedResultLabel.text = values;
}
#pragma mark == 颜色代理方法
-(void)getColorChoiceValues:(NSString *)values
{
    self.selectedResultLabel.text = values;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
