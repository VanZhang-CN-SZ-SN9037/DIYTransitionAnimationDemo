//
//  UINavigationController+HPNavigationTransition.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/23.
//

#import <UIKit/UIKit.h>

#import "HPTransitionAnimationDefine.h"
#import "UIViewController+HPTransitionAnimation.h"

#import "HPNavigationTransitionAnimator.h"


//@interface UIViewController (TempDelegate)
//@property (nonatomic, weak ,readonly) id tempNavDelegate;
//@property (assign, nonatomic) HPPageTransitionAnimationOptions last_Navigation_Option;
//@end
@interface UINavigationController (HPTransitionAnimation)


@property (strong, nonatomic ,readonly) HPNavigationTransitionAnimator*pushAnimator;
@property (strong, nonatomic ,readonly) HPNavigationTransitionAnimator*popAnimator;

- (void)pushViewController:(UIViewController *)viewController animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;
- (UIViewController *)popViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)option params:(HPBaseTransitionAnimatorParams*)params;

@end


@interface UINavigationController (CATransition)
- (void)pushViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option;
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animation:(HP_CATransition_Animation_Options)option;
- (UIViewController *)popViewControllerAnimation:(HP_CATransition_Animation_Options)option;
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option;
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimation:(HP_CATransition_Animation_Options)option;


- (void)pushViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position;
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position;
- (UIViewController *)popViewControllerAnimation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position;
- (NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position;
- (NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position;
@end
