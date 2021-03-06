//
//  BlackChocolate.h
//  12306
//
//  Created by caine on 7/13/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuskyButton.h"
#import "UIFont+MaterialDesignIcons.h"

@interface BlackChocolate : UITableViewCell

@property( nonatomic, strong ) HuskyButton *husky;
@property( nonatomic, strong ) UILabel     *check;
@property( nonatomic, assign ) BOOL         isCheck;
@property( nonatomic, strong ) NSIndexPath *indexPath;

- (void)setChecked;
- (void)setUncheck;

@end
