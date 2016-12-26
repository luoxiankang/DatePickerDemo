//
//  LXKDatePickerForYMDView.h
//  DatePickerDemo
//
//  Created by LXK on 2016/11/15.
//  Copyright © 2016年 lxkboy. All rights reserved.
//

#import "LXKDatePickerForYMDView.h"
#import "AppDelegate.h"
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface LXKDatePickerForYMDView ()
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)NSDate *getData;
@end

@implementation LXKDatePickerForYMDView
//初始化View以及添加单击蒙层逻辑
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    return self;
}
//蒙层添加到Window上
+(instancetype)makeViewWithMask:(CGRect)frame setTitle:(NSString *)title
{
    LXKDatePickerForYMDView *mview = [[self alloc]initWithFrame:frame];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:mview];
    //横屏
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationLandscapeLeft) {
        mview.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT *2/5, SCREEN_WIDTH, SCREEN_HEIGHT *3/5);
    }
    //添加底部view添加的window上
    mview.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height *3/5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height *2/5)];
    mview.bottomView.backgroundColor = [UIColor whiteColor];
    
    [delegate.window addSubview:mview.bottomView];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 30)];
    timeLab.text = title;
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.textColor = [UIColor grayColor];
    [mview.bottomView addSubview:timeLab];
    
    //添加一个时间选择器
    UIDatePicker *date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(timeLab.frame),[UIScreen mainScreen].bounds.size.width,mview.bottomView.frame.size.height - CGRectGetMaxY(timeLab.frame) - 40)];
    //  设置只显示中文
    [date setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    // 设置只显示日期
    date.datePickerMode=UIDatePickerModeDate;
    //设置监听
    [date addTarget:mview action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [mview.bottomView addSubview:date];

    //添加底部button
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 20 - 80, CGRectGetMaxY(date.frame) , 60, 37);
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:mview action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:cancelBtn];
    //确定按钮
    UIButton *makeSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    makeSureBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 + 20 , CGRectGetMaxY(date.frame)  , 60, 30);
    [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [makeSureBtn addTarget:mview action:@selector(makeSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [mview.bottomView addSubview:makeSureBtn];
    return mview;
}
//监听日期改变
-(void)changeDate:(UIDatePicker *)changeDate
{
  self.getData = [changeDate date];
}
//取消
-(void)cancelBtn:(UIButton *)cancelBtn
{
  [self removeView];
}
-(void)makeSureBtn:(UIButton *)makeSureBtn
{
    //代理传值
    if ([_delegate respondsToSelector:@selector(getdatepickerForYearMonthDayChangeValues:)]) {
        if (!self.getData) {
            self.getData = [NSDate date];//获取当前时间，日期
        }
        //设置日期样式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        [_delegate getdatepickerForYearMonthDayChangeValues:[dateFormatter stringFromDate:self.getData]];
    }
    [self removeView];
}
//取消蒙层
-(void)removeView{
    [self.bottomView removeFromSuperview];
    [self removeFromSuperview];
}
@end
