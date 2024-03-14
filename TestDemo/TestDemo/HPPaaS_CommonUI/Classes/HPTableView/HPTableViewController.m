//
//  HPTableViewController.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//

#import "HPTableViewController.h"
#import "Masonry.h"
@interface HPTableViewController ()

@end

@implementation HPTableViewController
-(HPTableView *)tableView{
    if (!_tableView) {
        _tableView =  [[HPTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI{
    __weak typeof(self)  weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.view);
        make.top.equalTo(@(-35));
    }];
    [self.tableView reloadData];
}
- (void)bindViewModel{
    
}
- (void)setupNoticeMonitors{}
- (void)dataSouece:(void(^)(HPTableView *tableView,HPDataSource*datasource))datasourceHandlerBlock delegate:(void(^)(HPTableView *tableView,HPDelegate*delegate))delegateHandlerBlock{ 
    !datasourceHandlerBlock?:datasourceHandlerBlock(self.tableView,self.tableView.ns_dataSource);
    !delegateHandlerBlock?:delegateHandlerBlock(self.tableView,self.tableView.ns_delegate);
}


@end
