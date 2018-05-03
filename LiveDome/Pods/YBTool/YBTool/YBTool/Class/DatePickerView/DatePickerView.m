//
//  DatePickerView.m
//  testDome
//
//  Created by zbwx on 2017/12/29.
//  Copyright © 2017年 zbwx. All rights reserved.
//

#import "DatePickerView.h"
@interface DatePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 选择的年 */
@property (nonatomic, assign)NSInteger selectYear;
/** 选择的月 */
@property (nonatomic, assign)NSInteger selectMonth;
/** 选择的日 */
@property (nonatomic, assign)NSInteger selectDay;

@property (nonatomic, assign)NSInteger currentYear;
@property (nonatomic, assign)NSInteger currentMonth;
@property (nonatomic, assign)NSInteger currentDay;
@property (nonatomic, assign)NSInteger defaultYear;
@property (nonatomic, assign)NSInteger defaultMonth;
@property (nonatomic, assign)NSInteger defaultDay;

@property (nonatomic, assign)NSInteger minShowYear;

@property (nonatomic, assign)NSInteger yearSum;
@end
@implementation DatePickerView

- (void)initPickView{
    [super initPickView];
    
    _minShowYear = 1940;//最小年份

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    
    _yearSum = comp.year-_minShowYear+1;
    _currentYear=comp.year;
    _currentMonth=comp.month;
    _currentDay=comp.day;
    
    _selectYear  = comp.year;
    _selectMonth = comp.month;
    _selectDay   = comp.day;
    _defaultYear = comp.year;
    _defaultMonth = comp.month;
    _defaultDay=comp.day;
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
}
-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay{
    
    if (defaultSelectYear!=0) {
        _defaultYear=defaultSelectYear;
    }
    
    if (defaultSelectMonth!=0) {
        _defaultMonth = defaultSelectMonth;
    }
    
    if (defaultSelectDay!=0) {
        _defaultDay=defaultSelectDay;
    }
    
    
    if (defaultSelectYear==-1) {
        _defaultYear=_currentYear+1;
        _defaultMonth=1;
        _defaultDay=1;
    }
    
    [self.pickerView selectRow:(_defaultYear - _minShowYear) inComponent:0 animated:NO];
    
    [self.pickerView selectRow:(_defaultMonth - 1) inComponent:1 animated:NO];
    [self.pickerView reloadComponent:1];
    
    [self.pickerView selectRow:(_defaultDay-1) inComponent:2 animated:NO];
    [self.pickerView reloadComponent:2];
    
    [self refreshPickViewData];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if(component == 1) {
        return 12;
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [self getDaysWithYear:yearSelected month:monthSelected];
    }
    
    
}
- (NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    //每一行的高度
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSInteger selectYear;
    NSInteger selectMonth;
    
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            selectYear = row+_minShowYear;
            [pickerView reloadComponent:2];
            break;
        case 1:
            selectMonth = row+1;
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self refreshPickViewData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%zd年", row + _minShowYear];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%02zd月", row + 1];
    }else{
        text = [NSString stringWithFormat:@"%02zd日", row + 1];
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    
    return label;
}


- (void)clickConfirmButton{
    if (self.pickerViewBlock) {
        self.pickerViewBlock(self.selectYear, self.selectMonth, self.selectDay);
    }
    [super clickConfirmButton];
}



- (void)refreshPickViewData{
    self.selectYear  = [self.pickerView selectedRowInComponent:0] + self.minShowYear;
    
    self.selectMonth = [self.pickerView selectedRowInComponent:1] + 1;
    
    self.selectDay   = [self.pickerView selectedRowInComponent:2] + 1;
    
}


- (void)setYearLeast:(NSInteger)yearLeast{
    _minShowYear = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum{
    _yearSum = yearSum;
}
#pragma mark - --- getters 属性 ---


@end
