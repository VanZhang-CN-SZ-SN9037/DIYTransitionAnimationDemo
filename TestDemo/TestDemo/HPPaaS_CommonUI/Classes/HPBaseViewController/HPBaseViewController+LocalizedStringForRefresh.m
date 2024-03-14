//
//  HPBaseViewController+LocalizedStringForRefresh.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+LocalizedStringForRefresh.h"

#ifdef MJRefresh
#import <MJRefresh.h>

@implementation HPBaseViewController (LocalizedStringForRefresh)
#pragma mark - 配置上下拉刷新
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header {
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderIdleText", @"MJRefresh", @"下拉可以刷新") forState:MJRefreshStateIdle];
    [header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderPullingText", @"MJRefresh", @"松开立即刷新") forState:MJRefreshStatePulling];
    [header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderRefreshingText", @"MJRefresh",@"正在刷新数据中...") forState:MJRefreshStateRefreshing];
    return header;
}
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer {
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterIdleText", @"MJRefresh",@"上拉可以加载更多") forState:MJRefreshStateIdle];
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterPullingText", @"MJRefresh",@"松开立即加载更多") forState:MJRefreshStatePulling];
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterRefreshingText", @"MJRefresh",@"正在加载更多的数据...") forState:MJRefreshStateRefreshing];
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterNoMoreDataText", @"MJRefresh",@"已经全部加载完毕") forState:MJRefreshStateNoMoreData];
    return footer;
}

- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer {
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterIdleText", @"MJRefresh",@"点击或上拉加载更多") forState:MJRefreshStateIdle];
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterRefreshingText", @"MJRefresh",@"正在加载更多的数据...") forState:MJRefreshStateRefreshing];
    [footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterNoMoreDataText", @"MJRefresh",@"已经全部加载完毕") forState:MJRefreshStateNoMoreData];
    return footer;
}

@end

#endif
