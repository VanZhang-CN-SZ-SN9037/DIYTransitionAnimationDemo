//
//  HPNavigationTransitionAnimator+InsideThenPushAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPBaseTransitionAnimator (InsideThenPushAnimation)
- (void)insideThenPushAnimationWithTransitionState:(HPPageTransitionState)state; 
@end

NS_ASSUME_NONNULL_END
