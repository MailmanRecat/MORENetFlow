//
//  dataView.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataView : UIScrollView

@property( nonatomic, strong ) UILabel *usage;
@property( nonatomic, strong ) UILabel *DateUsage;
@property( nonatomic, strong ) UILabel *sent;
@property( nonatomic, strong ) UILabel *DateSent;
@property( nonatomic, strong ) UILabel *amount;
@property( nonatomic, strong ) UILabel *DateAmount;

- (void)hideAmount;
- (void)showAmount;

@end
