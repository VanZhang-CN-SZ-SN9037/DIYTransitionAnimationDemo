//
//  HPModalTransitionAnimator.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPBaseTransitionAnimator.h"
 
@interface HPModalTransitionAnimatorParams :HPBaseTransitionAnimatorParams
@end
  




@interface HPModalTransitionAnimator : HPBaseTransitionAnimator
//Desc:
+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options;
@end
 
