//
//  HPCommonUI.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//

#ifndef HPCommonUI_h
#define HPCommonUI_h


#import "HPCommonUIProtocol.h"
#import "HPCommonUIFactory.h"
/*
 1.容器控制器
 2.视图控制器
 3.UI控件
 4.UI插件
 */


#pragma mark - 1.容器控制器

/*TabBarController*/
#import "HPTabBarController.h"

/*NavigationController*/
#import "HPBaseNavigationController.h"
#import "HPNavigationController.h"
#import "HFNavigationController.h"
/*HPSliderContainerKit卡片切换*/
#import "HPSliderContainerKit.h"
#pragma mark -  2.视图控制器
/*ViewController*/
#import "HPBaseViewController.h"
#import "HPViewController.h"
#pragma mark - 3.视图插件

#pragma mark 3.0 MVVM基础视图
#import "HPBaseView.h"
#pragma mark 3.1 列表
/*HPTableView*/
#import "HPTableView.h"
#import "HPTableViewCell.h"
#import "HPBaseTableViewModel.h"
#import "HPTableViewController.h"

#pragma mark 3.2 宫格

/*HPCollectionView*/
#import "HPCollectionView.h"
#import "HPCollectionViewCell.h"
#import "HPCollectionViewFlowLayout.h"
#import "HPBaseCollectionViewModel.h"
#import "HPCollectionViewController.h"

#pragma mark 3.3 菜单
/*MenuUIBanner*/
#import "HPMenuOperation.h"

#pragma mark 3.4 浮窗
#import "HPBubble.h"
#pragma mark 3.5 按钮
#import "HPButton.h" 

#pragma mark - 4.UI插件
/*Categories*/ 
#import "UIImageView+HPCommonUI.h"
#import "UIView+HPCommonUI.h" 
//颜色处理
#import "HPCommonColor.h"
//UI工厂工具
#import "HPCommonUIFactory.h"
#endif /* HPCommonUI_h */
