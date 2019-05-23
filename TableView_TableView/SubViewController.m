//
//  SubViewController.m
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/15.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import "SubViewController.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SubViewController ()
@property (nonatomic, strong) NSMutableArray *ds;
@end

@implementation SubViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}




@end
