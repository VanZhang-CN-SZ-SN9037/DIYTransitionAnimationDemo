//
//  HPButton.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import <UIKit/UIKit.h>
 
#if __has_include(<UIButton+HPCommonUI.h>)
#import "UIButton+HPCommonUI.h" 
#endif
@interface HPButton : UIButton

@property (nonatomic, assign) NSInteger badge;  //数值

@property (nonatomic, weak) UIButton *badgeBtn;
/**
 *  显示按钮红点 无数字
 */
- (void)showBadgeButtonWithoutNum;

@end

