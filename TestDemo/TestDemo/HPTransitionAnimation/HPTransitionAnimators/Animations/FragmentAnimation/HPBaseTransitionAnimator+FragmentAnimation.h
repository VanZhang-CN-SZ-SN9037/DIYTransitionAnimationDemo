//
//  HPNavigationTransitionAnimator+FragmentAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/26.
//

#import "HPBaseTransitionAnimator.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPBaseTransitionAnimator (FragmentAnimation)  
- (void)presentWithFragmentAnimationWithTransitionState:(HPPageTransitionState)state option:(HP_FragmentAnimation_Options)option startPosition:(HP_Animation_StartPosition)position;
@end

NS_ASSUME_NONNULL_END
