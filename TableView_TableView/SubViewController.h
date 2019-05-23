//
//  SubViewController.h
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/15.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubViewController : UIViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
