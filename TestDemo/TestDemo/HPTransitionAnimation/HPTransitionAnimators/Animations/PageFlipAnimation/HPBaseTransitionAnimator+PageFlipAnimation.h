//
//  HPNavigationTransitionAnimator+PageFlipAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPBaseTransitionAnimator (PageFlipAnimation)
- (void)pageFlipAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_PageFlipAnimation_Options)option; 

@end

NS_ASSUME_NONNULL_END
