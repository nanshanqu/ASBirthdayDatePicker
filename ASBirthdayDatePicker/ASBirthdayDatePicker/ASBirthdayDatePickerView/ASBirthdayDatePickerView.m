//
//  ASBirthdayDatePickerView.m
//  ASBirthdayDatePicker
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ASBirthdayDatePickerView.h"
#import <Masonry.h>

@interface ASBirthdayDatePickerView ()

@property (nonatomic, strong) UIView * mainBGView;

@property (nonatomic, strong) UIButton * sureButton;

@property (nonatomic, strong) UIButton * cancelButton;

@property (nonatomic, strong) UIDatePicker * datePicker;

@property (nonatomic, copy  ) void(^birthdayDateOperation)(NSString *date);
@property (nonatomic, copy  ) void(^cancelOperation)(void);

@end

static ASBirthdayDatePickerView *_birthdayDatePickerViewManager = nil;

@implementation ASBirthdayDatePickerView

- (instancetype)showBirthdayDatePickerViewWirthdayDateOperation:(void(^)(NSString *birthday))birthdayDateOperation {
    
    if (self == [super init]) {
        
        self.birthdayDateOperation = birthdayDateOperation;
        [self setupUI];
    }
    return self;
}

+ (instancetype)showBirthdayDatePickerViewWirthdayDateOperation:(void(^)(NSString *birthday))birthdayDateOperation {
    
    if (_birthdayDatePickerViewManager == nil) {
        
        _birthdayDatePickerViewManager = [[self alloc] showBirthdayDatePickerViewWirthdayDateOperation:birthdayDateOperation];
        _birthdayDatePickerViewManager.frame = [UIScreen mainScreen].bounds;
        _birthdayDatePickerViewManager.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
        [mainWindow addSubview:_birthdayDatePickerViewManager];
    }
    return _birthdayDatePickerViewManager;
}

- (void)setupUI {
    
    [self addSubview:self.mainBGView];
    [self.mainBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(400, 200));
    }];
    
    [self.mainBGView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.mainBGView);
    }];
    
    CGSize buttonSize = CGSizeMake(50, 20);
    CGFloat margin = 10;

    [self.mainBGView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainBGView).offset(margin);
        make.top.mas_equalTo(self.mainBGView).offset(margin+5);
        make.size.mas_equalTo(buttonSize);
    }];

    [self.mainBGView addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mainBGView).offset(-margin);
        make.top.mas_equalTo(self.mainBGView).offset(margin+5);
        make.size.mas_equalTo(buttonSize);
    }];
}

#pragma mark- function

- (void)sureButtonAction {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *birthday = [formatter  stringFromDate:self.datePicker.date];
    
    if (self.birthdayDateOperation) {
        self.birthdayDateOperation(birthday);
    }
    [self hiddenBirthdayDatePickerView];
}

- (void)cancelButtonAction {
    
    if (self.cancelOperation) {
        self.cancelOperation();
    }
    [self hiddenBirthdayDatePickerView];
}

- (void)hiddenBirthdayDatePickerView {
    
    [_birthdayDatePickerViewManager removeFromSuperview];
    _birthdayDatePickerViewManager = nil;
}

+ (void)hiddenBirthdayDatePickerView {
    
    [_birthdayDatePickerViewManager removeFromSuperview];
    _birthdayDatePickerViewManager = nil;
}

#pragma mark- lazying

- (UIView *)mainBGView {
    if (!_mainBGView) {
        _mainBGView = [[UIView alloc] init];
        _mainBGView.backgroundColor = [UIColor whiteColor];
        _mainBGView.layer.cornerRadius = 10;
        _mainBGView.layer.borderColor = [UIColor redColor].CGColor;
        _mainBGView.layer.borderWidth = 5;
    }
    return _mainBGView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        //设置地区: zh-中国
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置日期模式(Displays month, day, and year depending on the locale setting)
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
        
    }
    return _datePicker;
}



@end
