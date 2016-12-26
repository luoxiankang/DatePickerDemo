//
//  LXKDatePickerView.m
//  DatePickerDemo
//
//  Created by LXK on 2016/11/16.
//  Copyright © 2016年 lxkboy. All rights reserved.
//

#import "LXKDatePickerView.h"
#import "AppDelegate.h"
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface LXKDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIView *bottomView;//底部view
@property (strong,nonatomic) UIPickerView *datePicker;
@property (strong,nonatomic) UIView*timeSelectView;//时间选择view
@property (strong,nonatomic) NSMutableArray *monthData;//月数据
@property (strong,nonatomic) NSMutableArray *yearData;//年数据

@property (strong,nonatomic) NSString  *timeSelectedString;//选择时间结果
@property (strong,nonatomic)NSString  *monthStr;//月
@property (strong,nonatomic)NSString  *yearStr;//年
@end

@implementation LXKDatePickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.userInteractionEnabled = YES;
    }
    return self;
}
+(instancetype)makeViewWithMaskDatePicker:(CGRect)frame setTitle:(NSString *)title
{
    LXKDatePickerView *mview = [[self alloc]initWithFrame:frame];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:mview];
    //添加底部view添加的window上
    mview.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT *3/5, SCREEN_WIDTH, SCREEN_HEIGHT *2/5)];
    mview.bottomView.backgroundColor = [UIColor whiteColor];
    [delegate.window addSubview:mview.bottomView];
    //横屏
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) {
        mview.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT *2/5, SCREEN_WIDTH, SCREEN_HEIGHT *3/5);
    }
    //顶部时间选择label
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,SCREEN_WIDTH, 30)];
    timeLab.text = title;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = [UIColor grayColor];
    [mview.bottomView addSubview:timeLab];
    
    //添加自定义一个时间选择器
    mview.datePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeLab.frame),SCREEN_WIDTH,mview.bottomView.frame.size.height - CGRectGetMaxY(timeLab.frame) - 40)];
    mview.datePicker.backgroundColor = [UIColor whiteColor];
    mview.datePicker.dataSource = mview;
    mview.datePicker.delegate = mview;
    //初始时间选择文字
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    mview.monthStr = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy"];
    mview.yearStr = [formatter1 stringFromDate:[NSDate date]];
    mview.timeSelectedString = [NSString stringWithFormat:@"%@-%@",mview.yearStr,mview.monthStr];
    [mview.datePicker selectRow:mview.monthStr.integerValue-1 inComponent:1 animated:NO];
    [mview.datePicker selectRow:mview.yearStr.integerValue-1900 inComponent:0 animated:NO];
    
    [mview.bottomView addSubview:mview.datePicker];
    
    //添加底部button
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 20 - 80, CGRectGetMaxY(mview.datePicker.frame) , 60, 37);
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:mview action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:cancelBtn];
    //确定按钮
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.frame = CGRectMake(SCREEN_WIDTH/2 + 20 , CGRectGetMaxY(mview.datePicker.frame), 60, 30);
    [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [makeSureBtn addTarget:mview action:@selector(makeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:makeSureBtn];
    return mview;
}
//取消
-(void)cancelBtn:(UIButton *)cancelBtn
{
    [self removeView];
}

-(void)makeSureBtn:(UIButton *)makeSureBtn
{
    //代理传值
    if ([_delegate respondsToSelector:@selector(getdatepickerForYearAndMonthChangeValues:)]) {
        if (!self.timeSelectedString) {
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            [self getdate:currentDate];
        }
        [_delegate getdatepickerForYearAndMonthChangeValues:self.timeSelectedString];
    }
    [self removeView];
}
//获取日期
-(void)getdate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM"];
    self.timeSelectedString = [dateFormatter stringFromDate:date];
}
//单击蒙层取消蒙层
-(void)removeView{
    [self.bottomView removeFromSuperview];
    [self removeFromSuperview];
}
#pragma mark pickDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //年，月
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.yearStr = self.yearData[row];
    }else{
        self.monthStr = self.monthData[row];
    }
    NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
    [formatterMonth setDateFormat:@"MM"];
    NSString *nowMonthStr = [formatterMonth stringFromDate:[NSDate date]];
    NSDateFormatter *formatterYear= [[NSDateFormatter alloc] init];
    [formatterYear setDateFormat:@"yyyy"];
    NSString *nowYearStr = [formatterYear stringFromDate:[NSDate date]];
    int a = [nowMonthStr intValue];
    int b = [nowYearStr intValue];
    int c = [self.monthStr intValue];
    int d = [self.yearStr intValue];
    //当时间大于当前时间时，返回到当前时间
    if (d>b||(d==b&&c>a)) {
        [self.datePicker selectRow:a-1 inComponent:1 animated:YES];
        [self.datePicker selectRow:b-1900 inComponent:0 animated:YES];
        self.yearStr = nowYearStr;
        self.monthStr = nowMonthStr;
    }
    self.timeSelectedString = [NSString stringWithFormat:@"%@-%@",self.yearStr,self.monthStr];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        //年分200年
        return 200;
    }else {
        //月份12各月
        return 12;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return  [NSString stringWithFormat:@"%@ 年",self.yearData[row]];
    }else {
        return  [NSString stringWithFormat:@"%@ 月",self.monthData[row]];
    }
}

-(NSMutableArray *)monthData{
    if (!_monthData) {
        _monthData = [[NSMutableArray alloc]init];
        for (int i = 1; i<13; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [self.monthData addObject:str];
        }
    }
    return _monthData;
}
-(NSMutableArray *)yearData{
    if (!_yearData) {
        _yearData = [[NSMutableArray alloc]init];
        for (int i = 1900; i<2100; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [self.yearData addObject:str];
        }
    }
    return _yearData;
}
@end
