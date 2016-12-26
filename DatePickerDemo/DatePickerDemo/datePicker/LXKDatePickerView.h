//
//  LXKDatePickerView.h
//  DatePickerDemo
//
//  Created by LXK on 2016/11/16.
//  Copyright © 2016年 lxkboy. All rights reserved.
////年月datepickage封装

#import <UIKit/UIKit.h>
@protocol LXKDatePickerViewDelegate<NSObject>
-(void)getdatepickerForYearAndMonthChangeValues:(NSString *)values;//获取日期改变的代理方法
@end
@interface LXKDatePickerView : UIView
//委托变量
@property(nonatomic,weak) id<LXKDatePickerViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker:(CGRect)frame setTitle:(NSString *)title;
@end
