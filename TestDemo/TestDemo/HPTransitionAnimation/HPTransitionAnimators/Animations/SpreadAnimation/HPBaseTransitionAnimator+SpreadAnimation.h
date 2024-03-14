//
//  HPNavigationTransitionAnimator+SpreadAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPBaseTransitionAnimator (SpreadAnimation) 
- (void)presentWithPointSpreadAnimationWithTransitionState:(HPPageTransitionState)state;
- (void)presentWithSideSpreadAnimationWithTransitionState:(HPPageTransitionState)state startPosition:(HP_Animation_StartPosition)position;
@end

NS_ASSUME_NONNULL_END
