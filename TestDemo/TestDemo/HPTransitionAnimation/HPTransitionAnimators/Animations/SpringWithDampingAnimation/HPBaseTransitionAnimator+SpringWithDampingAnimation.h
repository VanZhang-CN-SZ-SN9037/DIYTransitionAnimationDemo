//
//  HPModalTransitionAnimator+SpringWithDampingAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPBaseTransitionAnimator (SpringWithDampingAnimation)
- (void)springWithDampingAnimationWithTransitionState:(HPPageTransitionState)state;
@end

NS_ASSUME_NONNULL_END
