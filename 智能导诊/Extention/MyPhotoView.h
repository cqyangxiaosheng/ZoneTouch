//
//  MyPhotoView.h
//  智能导诊
//
//  Created by frank on 2017/5/11.
//  Copyright © 2017年 frank. All rights reserved.
//

#import <VIPhotoView/VIPhotoView.h>

typedef NS_ENUM(NSInteger, CAPersonFace) {
    CAPersonFront,
    CAPersonBack,
};

typedef NS_ENUM(NSInteger, CAPersonSex) {
    CAPersonMan,
    CAPersonWoman,
};

typedef void (^TouchEventBlock)(NSString *name);

@interface MyPhotoView : VIPhotoView

@property (nonatomic, copy) TouchEventBlock touchEventBlock;

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
- (void)setBoundlePath:(NSString *)plistName;
- (void)setImage:(UIImage *)image;
- (void)setPersonFace:(CAPersonFace)face;

@end
