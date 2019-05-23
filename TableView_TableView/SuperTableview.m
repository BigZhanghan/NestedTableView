//
//  SuperTableview.m
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/14.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import "SuperTableview.h"

@interface SuperTableview ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SuperTableview

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
