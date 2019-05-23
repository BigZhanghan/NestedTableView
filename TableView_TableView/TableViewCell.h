//
//  TableViewCell.h
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/14.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import <UIKit/UIKit.h>

//刘海屏
#define kIs_iPhoneX ((kScreenHeight == 812.f || kScreenHeight == 896.f) ? YES : NO)
#define kNavigationBarHeight (kIs_iPhoneX ? 88.0f : 64.0f)
#define kBSafeAreaHeight (kIs_iPhoneX ? 34.0f : 0.0f)

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL cellCanScroll;
- (void)reloadTable;
@end

NS_ASSUME_NONNULL_END
