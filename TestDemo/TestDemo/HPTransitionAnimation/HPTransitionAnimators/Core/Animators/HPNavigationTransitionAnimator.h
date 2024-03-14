//
//  HPNavigationTransitionAnimator.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPBaseTransitionAnimator.h"



@interface HPNavigationTransitionAnimatorParams :HPBaseTransitionAnimatorParams
@end
 

@interface HPNavigationTransitionAnimator : HPBaseTransitionAnimator
 
+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options;
+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options startPosition:(HP_Animation_StartPosition)position;
 

@end 
