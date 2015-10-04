//
//  MORELanguage.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MORELanguage.h"

@implementation MORELanguage

+ (NSString *)currentLanguage{
    
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}

+ (NSString *)stringWWAN{
    
    NSString *language = [self currentLanguage];
    
    NSString *target = @"WWAN";
    
    if( [language isEqualToString:@"en-US"] ){
        target = @"WWAN";
    }
    
    return target;
    
}

+ (NSString *)stringWIFI{
    
    NSString *language = [self currentLanguage];
    
    NSString *target = @"WIFI";
    
    if( [language isEqualToString:@"en-US"] ){
        target = @"WIFI";
    }
    
    return target;
    
}

+ (NSString *)stringSettingUnitAuto{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingUnitMGAlways{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingUnitGBAlways{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingDisplayFlowAmountYES{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingDisplayFlowAmountNO{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

@end
