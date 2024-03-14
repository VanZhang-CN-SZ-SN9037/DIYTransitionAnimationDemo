//
//  UITabBarController+HPTransitionAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import <UIKit/UIKit.h>
 
#import "HPTransitionAnimationDefine.h"
#import "HPTabBarCtrlTransitionAnimator.h"

@interface UITabBarController (HPTransitionAnimation)
@property (strong, nonatomic,readonly) HPTabBarCtrlTransitionAnimator *selectItemAnimator;
- (void)setDidSelectItem:(NSUInteger)itemIndex animationOptions:(HPTabBarSelectItemTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;

- (void)setDidSelectViewController:(UIViewController *)viewController animationOptions:(HPTabBarSelectItemTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;
- (void)resetTabBarCtrlDelegate;
@end
 
