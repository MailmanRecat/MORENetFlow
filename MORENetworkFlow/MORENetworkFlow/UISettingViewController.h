//
//  UISettingViewController.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WindPark.h"

@class UISettingViewController;
@protocol MORETransitionDelegate <NSObject>

- (void)didClickDismissButton:(UISettingViewController *)UISettingviewController;

@end

@interface UISettingViewController : UIViewController

@property( nonatomic, weak ) id<MORETransitionDelegate> MORETransitionDelegate;

@end
