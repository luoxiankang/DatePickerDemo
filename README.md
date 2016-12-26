# DatePickerDemo
1、封装了年月日，年月，文字的日期选择器，也可以自定义其他选择器，使用简单，直接导入2行代码搞定\n
2、使用详情：\n                                  
1、在需要使用的.h中导入需要使用的文件，并申明属性和代理 \n                             
import "LXKColorChoice.h"   \n                                  
import "LXKDatePickerView.h"  \n                                         
import "LXKDatePickerForYMDView.h"      \n                                        
@interface ViewController ()<LXKColorChoiceDelegate,LXKDatePickerViewDelegate,LXKDatePickerForYMDViewDelegate>\n
@property(nonatomic,strong)LXKDatePickerForYMDView *yearAndMonthAndDayDatePickerView;\n
@property(nonatomic,strong)LXKDatePickerView *yearAndMonthDatePickerView;\n
@property(nonatomic,strong)LXKColorChoice *colorDatePickerView;\n
@property(nonatomic,strong)NSArray *colorArr;//文字选择器的数据源\n
2，加方法实例化对象和设置代理
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
3、实现代理方法
pragma mark == 年月日代理方法
-(void)getdatepickerForYearMonthDayChangeValues:(NSString *)dayStr
{
    self.selectedResultLabel.text = dayStr;
}
pragma mark == 年月代理方法
-(void)getdatepickerForYearAndMonthChangeValues:(NSString *)values
{
    self.selectedResultLabel.text = values;
}
pragma mark == 颜色代理方法
-(void)getColorChoiceValues:(NSString *)values
{
    self.selectedResultLabel.text = values;
}
效果图如下：
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/1.png)
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/2.png)
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/3.png)
