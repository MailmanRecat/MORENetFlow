//
//  UISetting.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const USERUNIT = @"userUnit";
static NSString *const UNITAUTO = @"auto";
static NSString *const UNITMB   = @"unitMB";
static NSString *const UNITGB   = @"unitGB";

static NSString *const USER_DISPLAY_AMOUNT = @"userDisplayAmount";

static NSString *const OPTION_UNIT = @"optionUnit";
static NSString *const OPTION_DISPLAY_FLOW = @"displayFlow";

@interface UISetting : NSObject

+ (NSString *)startDate;
+ (NSString *)endDate;

+ (NSString *)userUnit;
+ (NSString *)setUserUnit:(NSString *)unit;

+ (BOOL)userDisplayAmount;
+ (BOOL)setUserDisplayAmount:(BOOL)display;

+ (NSDictionary *)settings;
+ (void)optionsSetUnitTag:(int)tag;
+ (void)optionsSetDisplayFlowTag:(int)tag;

@end
