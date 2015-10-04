//
//  UISetting.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UISetting.h"
#import "TimeTalkerBird.h"
#import "MORELanguage.h"

static NSString *const STARTDATE = @"startDate";
static NSString *const ENDDATE = @"endDate";

@interface UISetting()

@end

@implementation UISetting

+ (NSString *)m:(NSUInteger)i{
    
    NSArray *name = @[ @"JAN", @"FEB", @"MAR", @"APR", @"MAY", @"JUN", @"JUL", @"AUG", @"SEP", @"OCT", @"NOV", @"DEC" ];
    return name[ i - 1 ];
    
}

+ (NSString *)startDate{
    
    NSString *startDate = [[NSUserDefaults standardUserDefaults] valueForKey:STARTDATE];
    
    if( !startDate ){
        
        NSDateComponents *date = [TimeTalkerBird currentDate];
        startDate = [NSString stringWithFormat:@"%@ %ld", [self m:date.month], (long)date.day];
        [[NSUserDefaults standardUserDefaults] setValue:startDate forKey:STARTDATE];
        
    }
    
    return startDate;
    
}

+ (NSString *)endDate{
    
    NSString *endDate;
    NSDateComponents *date = [TimeTalkerBird currentDate];
    endDate = [NSString stringWithFormat:@"%@ %ld", [self m:date.month], (long)date.day];
    
    return endDate;
    
}

+ (NSString *)userUnit{
    
    NSString *unit;
    unit = [[NSUserDefaults standardUserDefaults] stringForKey:USERUNIT];
    if( !unit ){
        
        unit = UNITAUTO;
        [[NSUserDefaults standardUserDefaults] setValue:unit forKey:USERUNIT];
        
    }
    
    return unit;
    
}

+ (NSString *)setUserUnit:(NSString *)unit{
    
    [[NSUserDefaults standardUserDefaults] setValue:unit forKey:USERUNIT];
    
    return unit;
    
}

+ (BOOL)userDisplayAmount{
    
    BOOL display;
    display = [[NSUserDefaults standardUserDefaults] boolForKey:USER_DISPLAY_AMOUNT];
    if( display != YES && display != NO ){
        
        display = NO;
        [[NSUserDefaults standardUserDefaults] setBool:display forKey:USER_DISPLAY_AMOUNT];
        
    }
    
    return display;
    
}

+ (BOOL)setUserDisplayAmount:(BOOL)display{
    
    [[NSUserDefaults standardUserDefaults] setBool:display forKey:USER_DISPLAY_AMOUNT];
    
    return display;
    
}

+ (NSArray *)optionsSetWithNames:(NSArray *)names andTag:(NSInteger)tag{
    
    NSMutableArray *options = [NSMutableArray new];
    
    if( tag >= [names count] ) return options;
    
    [names enumerateObjectsUsingBlock:^( id obj, NSUInteger index, BOOL *stop ){
       
        NSString *check = @"NO";
        if( tag == index ) check = @"YES";
        
        NSDictionary *unit = @{ @"text": names[index], @"check": check };
        [options addObject:unit];
    }];
    
    return options;
    
}

+ (NSArray *)optionsSetUnitWithTag:(int)tag{
    
    return [self optionsSetWithNames:@[ @"Auto", @"MB only", @"GB only" ] andTag:tag];
    
}

+ (NSArray *)optionsSetDisplayFlowWithTag:(int)tag{
    
    return [self optionsSetWithNames:@[ @"Show amount", @"Hide amount" ] andTag:tag];
    
}

+ (void)optionsSetUnitTag:(int)tag{
    
    [[NSUserDefaults standardUserDefaults] setInteger:tag forKey:OPTION_UNIT];
    
    switch (tag) {
        case 0:
            [self setUserUnit:UNITAUTO];
            
            break;
        case 1:
            [self setUserUnit:UNITMB];
            
            break;
        case 2:
            [self setUserUnit:UNITGB];
            
            break;
        default:
            break;
    }
    
}

+ (void)optionsSetDisplayFlowTag:(int)tag{
    
    [[NSUserDefaults standardUserDefaults] setInteger:tag forKey:OPTION_DISPLAY_FLOW];
    
    switch (tag) {
        case 0:
            [self setUserDisplayAmount:YES];
            
            break;
        case 1:
            [self setUserDisplayAmount:NO];
            
            break;
        default:
            break;
    }
    
}

+ (NSDictionary *)settings{
    
    NSInteger unitTag, displayFlow;
    
    NSString *unit = [self userUnit];
    
    if( [unit isEqualToString:UNITAUTO] )
        unitTag = 0;
    else if( [unit isEqualToString:UNITMB] )
        unitTag = 1;
    else if( [unit isEqualToString:UNITGB] )
        unitTag = 2;
    
    BOOL display = [self userDisplayAmount];
    
    if( display == YES )
        displayFlow = 0;
    else
        displayFlow = 1;
    
    NSArray *unitSection = [self optionsSetUnitWithTag:(int)unitTag];
    
    NSArray *displayFlowAmountSection = [self optionsSetDisplayFlowWithTag:(int)displayFlow];
    
    NSDictionary *settings = @{ @"Unit": unitSection, @"Display Amount": displayFlowAmountSection };
    
    return settings;
    
}

@end
