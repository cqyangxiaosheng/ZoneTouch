//
//  SettingViewController.h
//  智能导诊
//
//  Created by frank on 2017/5/11.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPhotoView.h"

typedef void (^SetSexBlock)(NSInteger age, CAPersonSex sex);

@interface SettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) SetSexBlock sexAgeBlock;

- (void)setSex:(CAPersonSex)personSex;

@end
