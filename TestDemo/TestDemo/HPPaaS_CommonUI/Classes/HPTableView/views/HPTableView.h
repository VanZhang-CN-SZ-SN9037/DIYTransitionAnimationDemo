//
//  HPTableView.h
//  NSCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <UIKit/UIKit.h>

#import "HPDataSource.h"
#import "HPDelegate.h"
#import "HPTableViewCell.h"
@interface HPTableView : UITableView
@property (strong, nonatomic) HPDataSource <UITableViewDataSource>*ns_dataSource;
@property (strong, nonatomic) HPDelegate <UITableViewDelegate>*ns_delegate;

@end
 
