//
//  UIBarButtonItem+HPCommonUI.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import <UIKit/UIKit.h>
#import "UIButton+HPCommonUI.h"

typedef void(^HPBarBtnItemHandler)(UIButton*sendor);
@interface UIBarButtonItem (HPCommonUI)

+ (instancetype)leftItemWithImage:(UIImage*)image click:(HPBarBtnItemHandler)actionClickBlock;
+ (instancetype)rightItemWithImage:(UIImage*)image click:(HPBarBtnItemHandler)actionClickBlock;


+ (instancetype)leftItemWithImage:(UIImage*)image  frame:(CGRect)rect click:(HPBarBtnItemHandler)actionClickBlock;
+ (instancetype)rightItemWithImage:(UIImage*)image frame:(CGRect)rect  click:(HPBarBtnItemHandler)actionClickBlock;

//

+ (instancetype)leftItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont  click:(HPBarBtnItemHandler)actionClickBlock;
+ (instancetype)rightItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)tFont  click:(HPBarBtnItemHandler)actionClickBlock;
 //
+ (instancetype)leftItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  titleFont:(UIFont*)tFont  image:(UIImage*)image contentStyle:(HPButtonContentStyle)contentStyle click:(HPBarBtnItemHandler)actionClickBlock;

+ (instancetype)rightItemWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  titleFont:(UIFont*)tFont image:(UIImage*)image  contentStyle:(HPButtonContentStyle)contentStyle click:(HPBarBtnItemHandler)actionClickBlock;
- (UIButton*)customBtn;
@end
