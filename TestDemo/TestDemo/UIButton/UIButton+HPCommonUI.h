//
//  UIButton+HPCommonUI.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import <UIKit/UIKit.h>


typedef void(^HPButtonHandler)(UIButton*sendor);


typedef NS_ENUM(NSUInteger,HPButtonContentStyle) {
    HPButtonContent_LeftIcon_RightTitle_Default = 0,//默认
    HPButtonContent_RightIcon_LeftTitle,//右边icon 左边标题
    HPButtonContent_TopIcon_BottomTitle,//头部icon 底部标题
    HPButtonContent_BottomIcon_TopTitle,//底部icon 头部标题
};

@interface UIButton (HPCommonUI)
- (void)click:(HPButtonHandler)block;
 
+ (instancetype)customBtnWithTitle:(NSString*)title titleColor:(UIColor*)titleColor  titleFont:(UIFont*)tFont  image:(UIImage*)image frame:(CGRect)rect contentHAligment:(UIControlContentHorizontalAlignment)ha contentStyle:(HPButtonContentStyle)contentStyle click:(HPButtonHandler)actionClickBlock;
@end
 
