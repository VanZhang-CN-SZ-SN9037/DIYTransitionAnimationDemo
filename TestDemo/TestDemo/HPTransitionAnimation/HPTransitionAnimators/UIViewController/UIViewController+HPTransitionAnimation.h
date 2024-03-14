//
//  UIViewController+HPTransitionAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/23.
//

#import <UIKit/UIKit.h>

#import "HPTransitionAnimationDefine.h"
#import "HPModalTransitionAnimator.h"



@interface UIViewController (HPTransitionAnimation)

@property (strong, nonatomic,readonly) HPModalTransitionAnimator *presentAnimator;
@property (strong, nonatomic,readonly) HPModalTransitionAnimator *dissmissAnimator;

#pragma mark-ModalTransition
- (void)presentViewController:(UIViewController*)presentedViewController animationOption:(HPPageTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params completion:(HPTransitionAnimationComplection)completion;
- (void)dismissViewControllerAnimationOptions:(HPPageTransitionAnimationOptions)options params:(HPBaseTransitionAnimatorParams*)params completion:(HPTransitionAnimationComplection)completion;

@end
 

@interface UIViewController (CATransition)
- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(HP_CATransition_Animation_Options)option completion:(HPTransitionAnimationComplection)completion;
- (void)dismissViewControllerAnimation:(HP_CATransition_Animation_Options)option completion:(HPTransitionAnimationComplection)completion;


- (void)presentViewController:(UIViewController *)viewControllerToPresent animation:(HP_CATransition_Animation_Options)option flipPosition:(HP_CATransition_Animation_FlipPosition)position completion:(HPTransitionAnimationComplection)completion;
- (void)dismissViewControllerAnimation:(HP_CATransition_Animation_Options)option  flipPosition:(HP_CATransition_Animation_FlipPosition)position completion:(HPTransitionAnimationComplection)completion;
 
@end
