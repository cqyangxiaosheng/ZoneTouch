//
//  MyPhotoView.m
//  智能导诊
//
//  Created by frank on 2017/5/11.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "MyPhotoView.h"

@interface MyPhotoView()

@property (nonatomic, strong) NSMutableDictionary *pathRefDic;

@property (nonatomic, strong) UIImageView *touchImageView;

@property (nonatomic) CGFloat screenWidthScale;
@property (nonatomic) CGFloat screenHeightScale;
@property (nonatomic) CAPersonFace personFace;

@end

@implementation MyPhotoView

- (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame andImage:image];
    
    if (self) {
        _screenWidthScale = frame.size.width/image.size.width;
        _screenHeightScale = frame.size.height/image.size.height;
        
        NSLog(@"screen width:%f height:%f",[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        _pathRefDic = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setContentRange:(NSString *)key range:(NSArray*)array
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    NSDictionary *dic = [array objectAtIndex:0];
    NSString *xaxis = [dic objectForKey:@"xaxis"];
    NSString *yaxis = [dic objectForKey:@"yaxis"];
    CGPathMoveToPoint(pathRef, NULL, xaxis.floatValue, yaxis.floatValue);
    
    for (NSInteger i = 1; i < array.count; i++) {
        
        dic = [array objectAtIndex:i];
        xaxis = [dic objectForKey:@"xaxis"];
        yaxis = [dic objectForKey:@"yaxis"];
        
        CGPathAddLineToPoint(pathRef, NULL, xaxis.floatValue, yaxis.floatValue);
    }
    
    CGPathCloseSubpath(pathRef);
    
    [_pathRefDic setObject:(__bridge id _Nonnull)(pathRef) forKey:key];
}

- (void)setBoundlePath:(NSString *)plistName
{
    //    _plistName = plistName;
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *keys = data.allKeys;
    [_pathRefDic removeAllObjects];
    
    for (NSInteger counter = 0; counter < keys.count; counter++) {
        
        NSString *key = [keys objectAtIndex:counter];
        NSArray *array = [data objectForKey:key];
        
        [self setContentRange:key range:array];
    }
}

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
}

- (void)setPersonFace:(CAPersonFace)face
{
    _personFace = face;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:self.containerView];
    
    touchLocation = CGPointMake(touchLocation.x/self.screenWidthScale, touchLocation.y/self.screenHeightScale);
    
    NSLog(@"widthScale:%f heightScale:%f",self.screenWidthScale, self.screenHeightScale);
    
    NSString *string = @"你摸到哪里去了";
    NSArray *keys = [_pathRefDic allKeys];
    
    for (NSInteger i = 0; i < keys.count; i++) {
        
        NSString *key = [keys objectAtIndex:i];
        CGMutablePathRef pathRef = (__bridge CGMutablePathRef)[_pathRefDic objectForKey:key];
        
        if (CGPathContainsPoint(pathRef, NULL, touchLocation, NO)) {
            string = key;
            
            break;
        }
    }
    
    if (self.touchEventBlock) {
        self.touchEventBlock(string);
    }
}
@end
