//
//  UISettingViewController.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define BAR_HEIGHT 56

#import "UIFont+MaterialDesignIcons.h"
#import "UISettingViewController.h"
#import "BlackChocolate.h"
#import "UISetting.h"

@interface UISettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) WindPark *park;

@end

@implementation UISettingViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if( scrollView.contentOffset.y <= - STATUS_BAR_HEIGHT - BAR_HEIGHT )
        [self.park sunrise];
    else
        [self.park sunset];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:51 / 255.0 blue:57 / 255.0 alpha:1];
    
    WindPark *park = [WindPark new];
    [park setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:park];
    _park = park;

    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:park to:self.view type:EdgeTopLeftRightZero]];
    
    park.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1];
//    park.backgroundColor = [UIColor whiteColor];
    
    [park disappearCliff];
    
    park.herb.titleLabel.font = [UIFont MaterialDesignIcons];
    [park.herb setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
    [park.herb addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
//    [park.herb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [park nameplate:@"Setting"];
    park.nameplate.textColor = [UIColor whiteColor];
//    park.nameplate.textColor = [UIColor blackColor];
    
    [self loadChocolateBox];
    
}

- (void)loadChocolateBox{
    
    UITableView *chocolateBox = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [chocolateBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    chocolateBox.dataSource = self;
    chocolateBox.delegate   = self;
    chocolateBox.backgroundColor = [UIColor whiteColor];
    chocolateBox.separatorStyle = UITableViewCellSeparatorStyleNone;
    chocolateBox.contentInset = UIEdgeInsetsMake(BAR_HEIGHT + STATUS_BAR_HEIGHT, 0, 0, 0);
    [self.view insertSubview:chocolateBox belowSubview:_park];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:chocolateBox to:self.view type:EdgeAroundZero]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[UISetting settings] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *settings = [UISetting settings];
    return [settings[ [settings allKeys][ section ] ] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *title = [[UISetting settings] allKeys][ section ];
        
    HuskyButton *hu = [HuskyButton new];
    hu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    hu.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    hu.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:16];
    [hu setTitle:title forState:UIControlStateNormal];
    [hu setTitleColor:[UIColor colorWithRed:119 / 255.0 green:119 / 255.0 blue:119 / 255.0 alpha:1] forState:UIControlStateNormal];
    hu.backgroundColor = tableView.backgroundColor
    ;
    
    CALayer *border = [CALayer layer];
    border.backgroundColor  = [UIColor clearColor].CGColor;
    CGRect   frame  = CGRectMake(0, 0, tableView.frame.size.width, 1);
    border.frame    = frame;
    
    [hu.layer addSublayer:border];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor clearColor].CGColor;
    borderBottom.frame    = CGRectMake(0, 39, tableView.frame.size.width, 1);
    [hu.layer addSublayer:borderBottom];
    
    if( section != 0 ){
        
        border.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1].CGColor;
        
    }
    
    hu.enabled = NO;
    
    return hu;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CELL_ID = @"CELL_ID";
    
    BlackChocolate *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if( !cell ){
         cell = [[BlackChocolate alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    NSDictionary *settings = [UISetting settings];
    NSDictionary *set = settings[ [settings allKeys][ indexPath.section ] ][ indexPath.row ];
    NSString *text = set[ @"text" ];
    NSString *check = set[ @"check" ];
    
    if( [check isEqualToString:@"YES"] )
        [cell setChecked];
    else
        [cell setUncheck];
    
    cell.indexPath = indexPath;
    cell.husky.backgroundColor = tableView.backgroundColor;
    [cell.husky setTitle:text forState:UIControlStateNormal];
    
    return cell;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dismissSelf{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
