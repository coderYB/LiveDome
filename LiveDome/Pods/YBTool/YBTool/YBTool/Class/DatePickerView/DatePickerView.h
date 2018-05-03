//
//  DatePickerView.h
//  testDome
//
//  Created by zbwx on 2017/12/29.
//  Copyright © 2017年 zbwx. All rights reserved.
//

#import "BasePickerView.h"
@interface DatePickerView : BasePickerView
@property (nonatomic,copy) void (^pickerViewBlock)(NSInteger year,NSInteger month,NSInteger day);
-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay;
@end
