//
//  ViewController.m
//  ASBirthdayDatePicker
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ASBirthdayDatePickerView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * birthdayButton;

@property (nonatomic, strong) UILabel * birthdayLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.birthdayLabel];
    [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(400, 20));
    }];
    
    [self.view addSubview:self.birthdayButton];
    [self.birthdayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
}

- (void)birthdayButtonAction {
    
    __weak typeof(self) weakSelf = self;
    [ASBirthdayDatePickerView showBirthdayDatePickerViewWirthdayDateOperation:^(NSString * _Nonnull birthday) {
        
        NSLog(@"birthday:%@", birthday);
        weakSelf.birthdayLabel.text = [NSString stringWithFormat:@"出生日期：%@", birthday];
    }];
}

- (UIButton *)birthdayButton {
    if (!_birthdayButton) {
        _birthdayButton = [[UIButton alloc] init];
        [_birthdayButton setTitle:@"选择你的生日" forState:UIControlStateNormal];
        _birthdayButton.backgroundColor = [UIColor blueColor];
        [_birthdayButton addTarget:self action:@selector(birthdayButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthdayButton;
}

- (UILabel *)birthdayLabel {
    if (!_birthdayLabel) {
        _birthdayLabel = [[UILabel alloc] init];
        _birthdayLabel.text = @"出生日期：2010-10-1";
        _birthdayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _birthdayLabel;
}


@end
