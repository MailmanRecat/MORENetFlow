//
//  dataView.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "dataView.h"
#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

@interface dataView()

@property( nonatomic, strong ) UILabel *DataUsage;
@property( nonatomic, strong ) UILabel *DataSent;
@property( nonatomic, strong ) UILabel *DataAmount;

@end

@implementation dataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.contentInset = UIEdgeInsetsMake(0, 0, 32, 0);
        
        UILabel *DataUsage = [UILabel new];
        UILabel *usage = [UILabel new];
        UILabel *DateUsage = [UILabel new];
        
        UILabel *DataSent = [UILabel new];
        UILabel *sent = [UILabel new];
        UILabel *DateSent = [UILabel new];
        
        UILabel *DataAmount = [UILabel new];
        UILabel *amount = [UILabel new];
        UILabel *DateAmount = [UILabel new];
        
        NSArray *allLabels = @[ DataUsage, usage, DateUsage, DataSent, sent, DateSent, DataAmount, amount, DateAmount ];
        
        for( UILabel *label in allLabels ){
            [label setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addSubview:label];
            label.textColor = [UIColor whiteColor];
        }
        
        CGFloat nameHeight = 20;
        CGFloat infoHeight = 48;
        NSInteger edgeInset = -16;
        NSInteger edgeOutset = 4;
        
//        -------------------------------------layout usage--------------------------------
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DataUsage type:EdgeTopZero constant: edgeInset * 2]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DataUsage type:EdgeLeftRightZero constant: edgeInset]];
        [DataUsage addConstraints:[NSLayoutConstraint SpactecledBearFixed:DataUsage type:SpactecledBearFixedHeight constant:nameHeight]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:usage type:EdgeLeftRightZero constant: edgeInset]];
        [usage addConstraints:[NSLayoutConstraint SpactecledBearFixed:usage type:SpactecledBearFixedHeight constant:infoHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:usage
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:DataUsage
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:edgeOutset]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DateUsage type:EdgeLeftRightZero constant: edgeInset]];
        [DateUsage addConstraints:[NSLayoutConstraint SpactecledBearFixed:DateUsage type:SpactecledBearFixedHeight constant:nameHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:DateUsage
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:usage
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:edgeOutset]];
        
//        ------------------------------------layout sent----------------------------------
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DataSent type:EdgeLeftRightZero constant: edgeInset]];
        [DataSent addConstraints:[NSLayoutConstraint SpactecledBearFixed:DataSent type:SpactecledBearFixedHeight constant:nameHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:DataSent
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:DateUsage
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant: - (edgeInset * 2) - 8]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:sent type:EdgeLeftRightZero constant: edgeInset]];
        [sent addConstraints:[NSLayoutConstraint SpactecledBearFixed:sent type:SpactecledBearFixedHeight constant:infoHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:sent
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:DataSent
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:edgeOutset]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DateSent type:EdgeLeftRightZero constant: edgeInset]];
        [DateSent addConstraints:[NSLayoutConstraint SpactecledBearFixed:DateSent type:SpactecledBearFixedHeight constant:nameHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:DateSent
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:sent
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:edgeOutset]];
        
//        ---------------------------------------layout amount------------------------------------
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DataAmount type:EdgeLeftRightZero constant: edgeInset]];
        [DataAmount addConstraints:[NSLayoutConstraint SpactecledBearFixed:DataAmount type:SpactecledBearFixedHeight constant:nameHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:DataAmount
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:DateSent
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant: - (edgeInset * 2) - 8]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:amount type:EdgeLeftRightZero constant: edgeInset]];
        [amount addConstraints:[NSLayoutConstraint SpactecledBearFixed:amount type:SpactecledBearFixedHeight constant:infoHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:amount
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:DataAmount
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:edgeOutset]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:self to:DateAmount type:EdgeLeftRightZero constant: edgeInset]];
        [DateAmount addConstraints:[NSLayoutConstraint SpactecledBearFixed:DateAmount type:SpactecledBearFixedHeight constant:nameHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:DateAmount
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:amount
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:edgeOutset]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:DateAmount to:self type:EdgeBottomZero constant:0]];
        
        
        for( UILabel *label in @[ DataUsage, DataSent, DataAmount ] ){
            label.font = [UIFont fontWithName:@"Roboto-bold" size:16];
        }
        
        for( UILabel *label in @[ usage, sent, amount ] ){
            label.font = [UIFont fontWithName:@"Roboto" size:48];
            label.textColor = [UIColor colorWithRed:127 / 255.0 green:200 / 255.0 blue:187 / 255.0 alpha:1];
        }
        
        for( UILabel *label in @[ DateUsage, DateSent, DateAmount ] ){
            label.font = [UIFont fontWithName:@"Roboto" size:14];
        }
        
        DataUsage.text = @"Data useage";
        usage.text = @"0 MB";
        DateUsage.text = @"Nov 11 - Nov 11";
        
        DataSent.text = @"Data sent";
        sent.text = @"0 MB";
        DateSent.text = @"Nov 11 - Nov 11";
        
        DataAmount.text = @"Data Amount";
        amount.text = @"0 MB";
        DateAmount.text = @"Nov 11 - Nov 11";
        
        _DataUsage = DataUsage;
        _usage = usage;
        _DateUsage = DateUsage;
        _DataSent = DataSent;
        _sent = sent;
        _DateSent = DateSent;
        _DataAmount = DataAmount;
        _amount = amount;
        _DateAmount = DateAmount;
        
    }
    return self;
}

- (void)hideAmount{
    
    _DataAmount.hidden = YES;
    _amount.hidden = YES;
    _DateAmount.hidden = YES;
    
}

- (void)showAmount{
    
    _DataAmount.hidden = NO;
    _amount.hidden = NO;
    _DateAmount.hidden = NO;
    
}

@end
