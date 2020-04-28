//
//  ASBirthdayDatePickerView.h
//  ASBirthdayDatePicker
//
//  Created by Mac on 2020/4/28.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASBirthdayDatePickerView : UIView

+ (instancetype)showBirthdayDatePickerViewWirthdayDateOperation:(void(^)(NSString *birthday))birthdayDateOperation;


@end

NS_ASSUME_NONNULL_END
