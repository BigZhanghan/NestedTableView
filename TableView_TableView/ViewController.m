//
//  ViewController.m
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/14.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import "ViewController.h"
#import "SuperTableview.h"
#import "TableViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kIs_iOS11 @available(iOS 11.0, *)


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SuperTableview *tableView;
@property (nonatomic, strong) TableViewCell *contentCell;
@property (nonatomic, assign) BOOL canScroll;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leaveTop" object:nil];
}

- (void)leaveTop {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canScroll = YES;
    
    if (kIs_iOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveTop) name:@"leaveTop" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 170;
    } else if (indexPath.row == 1) {
        return 44;
    } else {
        return kScreenHeight - 64 - 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor redColor];
        return cell;
    } else if (indexPath.row == 1) {
        cell.backgroundColor = [UIColor greenColor];
        return cell;
    } else {
        NSString *tableCellId = @"TableViewCell";
        _contentCell = [tableView dequeueReusableCellWithIdentifier:tableCellId];
        if (_contentCell == nil) {
            _contentCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellId];
        }
        [_contentCell reloadTable];
        return _contentCell;
    }
}

- (SuperTableview *)tableView {
    if (!_tableView) {
        _tableView = [[SuperTableview alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 170 - kNavigationBarHeight) {
        self.tableView.contentOffset = CGPointMake(0, 170 - kNavigationBarHeight);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            self.tableView.contentOffset = CGPointMake(0, 170 - kNavigationBarHeight);
        }
    }
    
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

@end
