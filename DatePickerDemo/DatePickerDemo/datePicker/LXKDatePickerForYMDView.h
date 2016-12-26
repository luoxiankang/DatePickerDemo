//
//  LXKDatePickerForYMDView.h
//  DatePickerDemo
//
//  Created by LXK on 2016/11/15.
//  Copyright © 2016年 lxkboy. All rights reserved.
//年月日datepickage封装

#import <UIKit/UIKit.h>
@protocol LXKDatePickerForYMDViewDelegate<NSObject>
-(void)getdatepickerForYearMonthDayChangeValues:(NSString *)dayStr;//获取日期改变的代理方法
@end

@interface LXKDatePickerForYMDView : UIView<UIGestureRecognizerDelegate>
//委托变量
@property(nonatomic,weak) id<LXKDatePickerForYMDViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMask:(CGRect)frame setTitle:(NSString *)title;
@end
