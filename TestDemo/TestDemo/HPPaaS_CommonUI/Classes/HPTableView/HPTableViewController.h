//
//  HPTableViewController.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//

#import <UIKit/UIKit.h>
#import "HPTableView.h"

@interface HPTableViewController : UIViewController
//Desc:
@property (strong, nonatomic) HPTableView *tableView;

- (void)dataSouece:(void(^)(HPTableView *tableView,HPDataSource*datasource))datasourceHandlerBlock delegate:(void(^)(HPTableView *tableView,HPDelegate*delegate))delegateHandlerBlock;

@end
