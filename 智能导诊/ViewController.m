//
//  ViewController.m
//  智能导诊
//
//  Created by frank on 2017/5/11.
//  Copyright © 2017年 frank. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"

@interface ViewController ()

@property (strong, nonatomic) MyPhotoView *photoView;
@property (nonatomic) CAPersonSex personSex;
@property (nonatomic) CAPersonFace personFace;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *leftBarImage = [UIImage imageNamed:@"zndz_setting_normal"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:leftBarImage
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(sexSetting)];
    [rightBarButton setImageInsets:UIEdgeInsetsMake(5.0, 4.0, 5.0, 4.0)];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:89.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [self.view addSubview:self.photoView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self changeFaceButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MyPhotoView *)photoView
{
    if (!_photoView) {
        UIImage *image = [UIImage imageNamed:@"man_body_up"];
        NSString *plistName = @"man_front";
        
        if (_personSex == CAPersonWoman) {
            
            image = [UIImage imageNamed:@"women_body_up"];
            
            plistName = @"women_front";
        }
        
        _photoView = [[MyPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height) andImage:image];
        [_photoView setBackgroundColor:[UIColor clearColor]];
        _photoView.autoresizingMask = (1 << 6) -1;
        _photoView.userInteractionEnabled = YES;
        
        [_photoView setPersonFace:CAPersonFront];
        [_photoView setBoundlePath:plistName];
        
        _photoView.touchEventBlock = ^(NSString *name) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *showMessage = [NSString stringWithFormat:@"哇，您摸了我%@！咸猪手,臭不要脸的！",name];
                
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"流氓"
                                                             message:showMessage
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
                
                [av show];
            });
        };
    }
    
    return _photoView;
}

- (void)changeFaceButton
{
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [changeButton setFrame:CGRectMake(10, 110, 30, 30)];
    
    [changeButton setBackgroundImage:[UIImage imageNamed:@"zndz_turnback_normal"] forState:UIControlStateNormal];
    
    [changeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeButton.imageView.contentMode = UIViewContentModeCenter;
    changeButton.imageView.clipsToBounds = NO;
    changeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [changeButton addTarget:self action:@selector(headButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeButton];
}

- (void)headButtonClick
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    NSString *imageNameString = @"man_body_up";
    NSString *plistName = @"man_front";
    
    if (_personSex == CAPersonMan) {
        if (_personFace == CAPersonFront) {
            imageNameString = @"man_body_down";
            plistName = @"man_back";
        }
    }
    else if (_personSex == CAPersonWoman) {
        if (_personFace == CAPersonFront) {
            imageNameString = @"women_body_down";
            plistName = @"women_back";
        }
        else {
            imageNameString = @"women_body_up";
            plistName = @"women_front";
        }
    }
    
    if (_personFace == CAPersonFront) {
        
        _personFace = CAPersonBack;
    }
    else {
        
        _personFace = CAPersonFront;
    }
    
    _photoView.alpha = 0;
    [_photoView setImage:[UIImage imageNamed:imageNameString]];
    [_photoView setPersonFace:_personFace];
    [_photoView setBoundlePath:plistName];
    _photoView.alpha = 1;
    
    [UIView commitAnimations];
}

- (void)sexSetting
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    SettingViewController *vc = [[SettingViewController alloc] init];
    
    [vc setSex:_personSex];
    vc.sexAgeBlock = ^(NSInteger age, CAPersonSex mysex){
        
        if (_personSex != mysex) {
            _personSex = mysex;
        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        NSString *imageNameString = @"man_body_up";
        NSString *plistName = @"man_front";
        
        if (mysex == CAPersonMan) {
            if (_personFace == CAPersonBack) {
                imageNameString = @"man_body_down";
                plistName = @"man_back";
            }
        }
        else  if (_personSex == CAPersonWoman) {
            
            imageNameString = @"women_body_up";
            plistName = @"women_front";
            
            if (_personFace == CAPersonBack) {
                imageNameString = @"women_body_down";
                plistName = @"women_back";
            }
        }
        
        _photoView.alpha = 0;
        [_photoView setImage:[UIImage imageNamed:imageNameString]];
        [_photoView setPersonFace:_personFace];
        [_photoView setBoundlePath:plistName];
        _photoView.alpha = 1;
        
        [UIView commitAnimations];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
