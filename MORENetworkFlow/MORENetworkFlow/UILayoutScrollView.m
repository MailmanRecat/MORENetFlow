//
//  UILayoutScrollView.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "UILayoutScrollView.h"

@implementation UILayoutScrollView

- (void)addViews:(NSArray *)views{
    
    for( UIView *view in views ){
        [self addSubview:view];
    }
    
    if( [views count] == 0 ) return;
    
    if( [views count] == 1 ){
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:views[0] to:self type:EdgeAroundZero]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:views[0] to:self type:EdgeEqualHeightWidth]];
        
        return;
        
    }
    
    [views enumerateObjectsUsingBlock:^( id obj, NSUInteger index, BOOL *stop ){
        
        if( index == 0 ){
            
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeTopLeftBottomZero]];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeEqualHeightWidth]];
            
        }else if( index == [views count] - 1 ){
            
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeTopRightBottomZero]];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeEqualHeightWidth]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:obj
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:views[ index - 1 ]
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0]];
            
        }else{
            
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeTopBottomZero]];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:obj to:self type:EdgeEqualHeightWidth]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:obj
                                                             attribute:NSLayoutAttributeLeft
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:views[ index - 1 ]
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0
                                                              constant:0]];
            
        }
        
    }];
    
}

@end
