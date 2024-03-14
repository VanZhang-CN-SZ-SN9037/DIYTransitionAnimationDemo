//
//  HPMenuOperation.h
//  NSRTCSDKDemo
//
//  Created by VanZhang on 2020/12/9.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import <Foundation/Foundation.h>
 
#import "HPMenuItem.h"
 

#define     NSColor(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     BlackForMenu     NSColor(71, 70, 73, 1.0)
#define     BlackForMenuHL   NSColor(65, 64, 67, 0.15)
#define     GrayLine         [UIColor colorWithWhite:0.5 alpha:0.3]

typedef NS_ENUM(NSInteger, HPMenuBackgroundStyle) {
    HPMenuBackgroundStyleDark,
    HPMenuBackgroundStyleLight
};

typedef NS_ENUM(NSInteger, HPMenuSegmenteLineStyle) {
    HPMenuSegmenteLineStylefollowContent,
    HPMenuSegmenteLineStyleFill
};

@interface HPMenuOperation : NSObject

@property (nullable, nonatomic, strong) UIColor *titleColor; //标题颜色
@property (nullable, nonatomic, strong) UIFont *titleFont; // 标题字体
@property (nullable, nonatomic, strong) UIColor *menuBackGroundColor; //背景颜色
@property (nullable, nonatomic, strong) UIColor *segmenteLineColor;//分割线颜色

@property (nonatomic, assign) CGFloat arrowHight;    //指向按钮的箭头的高度
@property (nonatomic, assign) CGFloat menuCornerRadiu;   //下拉框的圆角
@property (nonatomic, assign) CGFloat minMenuItemHeight;  //按钮最小高度
@property (nonatomic, assign) CGFloat minMenuItemWidth;  //按钮最小宽度
@property (nonatomic, assign) UIEdgeInsets edgeInsets;   //下拉框的内边距
@property (nonatomic, assign) CGFloat gapBetweenImageTitle;  //图片和标题间距
@property (nonatomic, assign) HPMenuBackgroundStyle menuBackgroundStyle;    //背景类型
@property (nonatomic, assign) HPMenuSegmenteLineStyle menuSegmenteLineStyle;    //分割线类型
@property (nonatomic, assign) BOOL showShadow;  //是否显示阴影

- (instancetype)initWithItems:(NSArray *)items;
- (instancetype)initWithItems:(NSArray *)items BackgroundStyle:(HPMenuBackgroundStyle)backgroundStyle;

- (void)addMenuItem:(HPMenuItem *)menuItem;

- (void)showFromRect:(CGRect)rect inView:(UIView *)view;
- (void)showFromNavigationController:(UINavigationController *)navigationController WithX:(CGFloat)x;
- (void)showFromTabBarController:(UITabBarController *)tabBarController WithX:(CGFloat)x;

- (void) dismissMenu;

@end
 
