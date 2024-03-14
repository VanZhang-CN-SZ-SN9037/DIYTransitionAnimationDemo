//
//  HPNavigationTransitionAnimator+BrickAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN



@interface HPBaseTransitionAnimator (BrickAnimation)

- (void)presentWithBrickAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_BrickAnimation_Options)option;
@end

NS_ASSUME_NONNULL_END
