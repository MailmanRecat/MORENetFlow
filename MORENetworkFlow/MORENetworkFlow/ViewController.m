//
//  ViewController.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define BAR_HEIGHT 56
#define INFOMATION_HEIGHT 48

#import "ViewController.h"
#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "UIFont+MaterialDesignIcons.h"
#import "HuskyButton.h"
#import "dataView.h"
#import "MORENetWork.h"
#import "UILayoutScrollView.h"
#import "UISetting.h"
#import "UISettingViewController.h"
#import "WindPark.h"

#import "MORELanguage.h"
#import "MORETransitionAnimationPresent.h"
#import "MORETransitionAnimationDismiss.h"

@interface ViewController ()<UIScrollViewDelegate, MORETransitionDelegate, UIViewControllerTransitioningDelegate>

@property( nonatomic, strong ) UILabel *speed;

@property( nonatomic, strong ) UIScrollView *content;
@property( nonatomic, strong ) UIScrollView *nameplate;
@property( nonatomic, strong ) dataView *wifi;
@property( nonatomic, strong ) dataView *wwan;

@property( nonatomic, strong ) MORETransitionAnimationPresent *transitionPresent;
@property( nonatomic, strong ) MORETransitionAnimationDismiss *transitionDismiss;

@end

@implementation ViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if( scrollView.contentOffset.x == scrollView.contentSize.width / 2 ){
        
        [UIView animateWithDuration:0.17 animations:^{
            _nameplate.contentOffset = CGPointMake(100, 0);
        }];
        
    }else if( scrollView.contentOffset.x == 0 ){
        
        [UIView animateWithDuration:0.17 animations:^{
            _nameplate.contentOffset = CGPointMake(0, 0);
        }];
    }
    
}

- (void)didClickDismissButton:(UISettingViewController *)UISettingviewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.transitionPresent;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.transitionDismiss;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    _transitionPresent = [MORETransitionAnimationPresent new];
    _transitionDismiss = [MORETransitionAnimationDismiss new];
    
    [self loadScrollView];
    [self loadBar];
    [self loadInformation];
    
    [self refresh];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(refresh) userInfo:nil repeats:YES];
}

- (void)refresh{
    
    NSDictionary *info = [MORENetWork NetworkInfoWithUnit:MOREUNITKB];
    
    NSString *userUnit = [UISetting userUnit];
    
    [self formatWithUnit:userUnit andData:info];
    
}

- (void)formatWithUnit:(NSString *)unit andData:(NSDictionary *)data{
    
    BOOL displayAmount = [UISetting userDisplayAmount];
    
    if( displayAmount ){
        [_wifi showAmount];
        [_wwan showAmount];
    }else{
        [_wifi hideAmount];
        [_wwan hideAmount];
    }
    
    CGFloat WIFIR = [data[SWIFIR] floatValue];
    CGFloat WIFIS = [data[SWIFIS] floatValue];
    CGFloat WWANR = [data[SWWANR] floatValue];
    CGFloat WWANS = [data[SWWANS] floatValue];
    CGFloat SPEED = [data[SSPEED] floatValue];
    
    CGFloat WIFIA = WIFIR + WIFIS;
    CGFloat WWANA = WWANR + WWANS;
    
    NSArray *monkey = @[
                        [NSNumber numberWithFloat:WIFIR],
                        [NSNumber numberWithFloat:WIFIS],
                        [NSNumber numberWithFloat:WWANR],
                        [NSNumber numberWithFloat:WWANS],
                        [NSNumber numberWithFloat:WIFIA],
                        [NSNumber numberWithFloat:WWANA]
                        ];
    
    NSArray *target = @[ _wifi.usage, _wifi.sent, _wwan.usage, _wwan.sent,  _wifi.amount, _wwan.amount ];
    
    if( [unit isEqualToString:UNITAUTO] ){
        
        [monkey enumerateObjectsUsingBlock:^( id obj, NSUInteger index, BOOL *stop ){
            
            NSString *unit = @"MB";
            CGFloat flow = [obj floatValue];
            UILabel *l = (UILabel *)target[ index ];
            if( flow / 1024 > 1024 ){
                
                unit = @"GB";
                flow = flow / (1024 * 1024);
                l.text = [NSString stringWithFormat:@"%.2lf %@", flow, unit];
                
            }else{
                
                flow = flow / 1024;
                l.text = [NSString stringWithFormat:@"%d %@", (int)flow, unit];
                
            }
            
        }];
        
    }else if( [unit isEqualToString:UNITMB] ){
        
        [monkey enumerateObjectsUsingBlock:^( id obj, NSUInteger index, BOOL *stop ){
            
            NSString *unit = @"MB";
            CGFloat flow = [obj floatValue] / 1024;
            UILabel *l = (UILabel *)target[ index ];
            l.text = [NSString stringWithFormat:@"%d %@", (int)flow, unit];
            
        }];
        
    }else if( [unit isEqualToString:UNITGB] ){
        
        [monkey enumerateObjectsUsingBlock:^( id obj, NSUInteger index, BOOL *stop ){
            
            NSString *unit = @"GB";
            CGFloat flow = [obj floatValue] / (1024 * 1024);
            UILabel *l = (UILabel *)target[ index ];
            l.text = [NSString stringWithFormat:@"%.2lf %@", flow, unit];
            
        }];
        
    }
    
    if( SPEED > 1024 ){
        _speed.text = [NSString stringWithFormat:@"%0.1f MB/S", SPEED / 1024];
    }else{
        _speed.text = [NSString stringWithFormat:@"%d KB/S", (int)SPEED];
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)settingViewController{
    
    UISettingViewController *settingViewController = [UISettingViewController new];
    
    settingViewController.transitioningDelegate = self;
    settingViewController.MORETransitionDelegate = self;
    
    [self presentViewController:settingViewController animated:YES completion:nil];
    
}

- (void)loadBar{
    
    WindPark *park = [WindPark new];
    [park setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:park];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:park to:self.view type:EdgeTopLeftRightZero]];
    
    park.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1];
    
//    bar.layer.shadowColor = [UIColor blackColor].CGColor;
//    bar.layer.shadowOpacity = 0.3f;
//    bar.layer.shadowOffset = CGSizeMake(1, 1);
//    bar.layer.shadowRadius = 0.3f;
    
//    --------------------SETTING BUTTON--------------------
    
    [park disappearMountain];
    [park disappearHerb];
    
    park.cliff.titleLabel.font = [UIFont MaterialDesignIcons];
    [park.cliff setTitle:[UIFont mdiSettings] forState:UIControlStateNormal];
    [park.cliff addTarget:self action:@selector(settingViewController) forControlEvents:UIControlEventTouchUpInside];
    
//    --------------------SETTING BUTTON--------------------
    
//    --------------------SCROLLE LABEL--------------------
    
    UILayoutScrollView *nameplate = [UILayoutScrollView new];
    [nameplate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [park addSubview:nameplate];
    
    [park addConstraints:[NSLayoutConstraint SpactecledBearEdeg:nameplate to:park type:EdgeTopZero constant:STATUS_BAR_HEIGHT]];
    [park addConstraints:[NSLayoutConstraint SpactecledBearEdeg:nameplate to:park type:EdgeBottomZero]];
    [park addConstraints:[NSLayoutConstraint SpactecledBearEdeg:nameplate to:park type:EdgeLeftZero constant:16]];
    [nameplate addConstraints:[NSLayoutConstraint SpactecledBearFixed:nameplate type:SpactecledBearFixedWidth constant:100]];
    
    nameplate.showsHorizontalScrollIndicator = NO;
    nameplate.showsVerticalScrollIndicator = NO;
    nameplate.scrollEnabled = NO;
    _nameplate = nameplate;
    
    UILabel *WIFIText = [UILabel new];
    UILabel *WWANText = [UILabel new];
    
    [WIFIText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [WWANText setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [nameplate addViews:@[ WIFIText, WWANText ]];
    
    for( UILabel *label in @[ WIFIText, WWANText ] ){
        label.font = [UIFont fontWithName:@"Roboto-bold" size:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
    }
    
    WIFIText.text = @"WIFI";
    WWANText.text = @"WWAN";
    
//    --------------------SCROLLE LABEL--------------------
    
}

- (void)loadInformation{
    
    UIView *infomation = [UIView new];
    [infomation setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:infomation];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:infomation to:self.view type:EdgeBottomLeftRightZero]];
    [infomation addConstraints:[NSLayoutConstraint SpactecledBearFixed:infomation type:SpactecledBearFixedHeight constant:INFOMATION_HEIGHT]];
    
    infomation.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1];
    
    _speed = [UILabel new];
    [_speed setTranslatesAutoresizingMaskIntoConstraints:NO];
    [infomation addSubview:_speed];
    
    [infomation addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_speed to:infomation type:EdgeCenterXY]];
    [infomation addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_speed to:infomation type:EdgeEqualHeightWidth]];
    
    _speed.font = [UIFont fontWithName:@"Roboto-Bold" size:24];
    _speed.textAlignment = NSTextAlignmentCenter;
    _speed.textColor = [UIColor colorWithRed:127 / 255.0 green:200 / 255.0 blue:187 / 255.0 alpha:1];
    _speed.text = @"0 KB/S";
}

- (void)loadScrollView{
    
    UIScrollView *scrollView = [UIScrollView new];
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:scrollView];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:scrollView to:self.view type:EdgeAroundZero]];
    
    scrollView.contentInset = UIEdgeInsetsMake(STATUS_BAR_HEIGHT + BAR_HEIGHT, 0, INFOMATION_HEIGHT, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    _content = scrollView;
    
    dataView *wifi = [dataView new];
    dataView *wwan = [dataView new];
    _wifi = wifi;
    _wwan = wwan;
    
    [wifi setTranslatesAutoresizingMaskIntoConstraints:NO];
    [wwan setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [scrollView addSubview:wifi];
    [scrollView addSubview:wwan];
    
    scrollView.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:51 / 255.0 blue:57 / 255.0 alpha:1];
    
    CGFloat Height = [UIScreen mainScreen].bounds.size.height - BAR_HEIGHT - STATUS_BAR_HEIGHT - INFOMATION_HEIGHT;
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    [scrollView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:wifi to:scrollView type:EdgeTopLeftBottomZero]];
    [wifi addConstraints:[NSLayoutConstraint SpactecledBearFixed:wifi type:SpactecledBearFixedWidth constant:width]];
    [wifi addConstraints:[NSLayoutConstraint SpactecledBearFixed:wifi type:SpactecledBearFixedHeight constant:Height]];
    
    [scrollView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:wwan to:scrollView type:EdgeTopRightBottomZero]];
    [wwan addConstraints:[NSLayoutConstraint SpactecledBearFixed:wwan type:SpactecledBearFixedWidth constant:width]];
    [wwan addConstraints:[NSLayoutConstraint SpactecledBearFixed:wwan type:SpactecledBearFixedHeight constant:Height]];
    
    [scrollView addConstraint:[NSLayoutConstraint constraintWithItem:wwan
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:wifi
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:0]];
    
    NSString *date = [NSString stringWithFormat:@"%@ - %@", [UISetting startDate], [UISetting endDate]];
    wifi.DateSent.text = wifi.DateUsage.text = wifi.DateAmount.text = wwan.DateSent.text = wwan.DateUsage.text = wwan.DateAmount.text = date;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
