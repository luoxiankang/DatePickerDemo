
<div># DatePickerDemo</div>
<div>1、封装了年月日，年月，文字的日期选择器，也可以自定义其他选择器，使用简单，直接导入2行代码搞定</div>
<div>2、使用详情 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>
<div>1、在需要使用的.h中导入需要使用的文件，并申明属性和代理 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>#import "LXKColorChoice.h" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>#import "LXKDatePickerView.h" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>#import "LXKDatePickerForYMDView.h" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
<div>@interface ViewController ()&lt;LXKColorChoiceDelegate,LXKDatePickerViewDelegate,LXKDatePickerForYMDViewDelegate&gt;</div>
<div>@property(nonatomic,strong)LXKDatePickerForYMDView *yearAndMonthAndDayDatePickerView;</div>
<div>@property(nonatomic,strong)LXKDatePickerView *yearAndMonthDatePickerView;</div>
<div>@property(nonatomic,strong)LXKColorChoice *colorDatePickerView;</div>
<div>@property(nonatomic,strong)NSArray *colorArr;//文字选择器的数据源</div>
<div>2，加方法实例化对象和设置代理</div>
<div>-(void)cliclDatePickerBtn:(UIButton *)btn</div>
<div>{</div>
<div>//通过tag值获取btn</div>
<div>&nbsp; &nbsp; switch (btn.tag - 10) {</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; case 0:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //年月日</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.yearAndMonthAndDayDatePickerView = [LXKDatePickerForYMDView makeViewWithMask:self.view.frame setTitle:@"年月日选择"];</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.yearAndMonthAndDayDatePickerView.delegate = self;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; case 1:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //年月</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.yearAndMonthDatePickerView = [LXKDatePickerView makeViewWithMaskDatePicker:self.view.frame setTitle:@"年月选择"];</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.yearAndMonthDatePickerView.delegate = self;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; case 2:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //颜色选择</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.colorDatePickerView = [LXKColorChoice makeViewWithMaskDatePicker:self.view.frame setTitle:@"颜色选择" Arr:self.colorArr];</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; self.colorDatePickerView.delegate = self;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; default:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div>
<div>&nbsp; &nbsp; }</div>
<div>}</div>
<div>3、实现代理方法</div>
<div>#pragma mark == 年月日代理方法</div>
<div>-(void)getdatepickerForYearMonthDayChangeValues:(NSString *)dayStr</div>
<div>{</div>
<div>&nbsp; &nbsp; self.selectedResultLabel.text = dayStr;</div>
<div>}</div>
<div>#pragma mark == 年月代理方法</div>
<div>-(void)getdatepickerForYearAndMonthChangeValues:(NSString *)values</div>
<div>{</div>
<div>&nbsp; &nbsp; self.selectedResultLabel.text = values;</div>
<div>}</div>
<div>#pragma mark == 颜色代理方法</div>
<div>-(void)getColorChoiceValues:(NSString *)values</div>
<div>{</div>
<div>&nbsp; &nbsp; self.selectedResultLabel.text = values;</div>
<div>}</div>
<div>效果图如下：</div>
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/1.png)
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/2.png)
![image](https://github.com/luoxiankang/DatePickerDemo/blob/master/DatePickerDemo/screenphoto/3.png)
<div><br></div>
