//
//  TableViewCell.m
//  TableView_TableView
//
//  Created by zhanghan on 2019/5/14.
//  Copyright © 2019 zhanghan. All rights reserved.
//

#import "TableViewCell.h"
#import <MJRefresh/MJRefresh.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TableViewCell ()<UITableViewDelegate,UITableViewDataSource>
/*
 添加到cell上的或者scrollview上的 容器视图：必须是UIScrollView
 否则子滚动视图滚动到底部时，会有问题：失去弹性
 */
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *ds;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.tableView];
    }
    return self;
}

- (void)reloadTable {
    [self loadData];
}

- (void)setCellCanScroll:(BOOL)cellCanScroll {
    _cellCanScroll = cellCanScroll;
}


- (UIScrollView *)containerView{
    if (!_containerView ) {
        _containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 44)];
    }
    return _containerView;
}

- (void)loadData {
    for (int i = 0; i < 10; i ++) {
        [self.ds addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ds.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.ds[indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBSafeAreaHeight)];
        
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.mj_footer = footer;
        
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",scrollView.contentOffset.y);
    if (!self.cellCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        self.cellCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    
    self.tableView.showsVerticalScrollIndicator = _cellCanScroll?YES:NO;
}

- (NSMutableArray *)ds {
    if (!_ds) {
        _ds = [NSMutableArray array];
    }
    return _ds;
}
@end
