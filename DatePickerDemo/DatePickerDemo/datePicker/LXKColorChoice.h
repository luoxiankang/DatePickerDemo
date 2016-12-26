//
//  LXKColorChoice.h
//  DatePickerDemo
//
//  Created by LXK on 2016/12/19.
//  Copyright © 2016年 lxkboy. All rights reserved.
//文字数组封装

#import <UIKit/UIKit.h>
@protocol  LXKColorChoiceDelegate<NSObject>
-(void)getColorChoiceValues:(NSString *)values;//获取颜色改变的代理方法
@end
@interface LXKColorChoice : UIView
//委托变量
@property(nonatomic,weak) id<LXKColorChoiceDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
+(instancetype)makeViewWithMaskDatePicker:(CGRect)frame setTitle:(NSString *)title Arr:(NSArray *)arr;
@end
