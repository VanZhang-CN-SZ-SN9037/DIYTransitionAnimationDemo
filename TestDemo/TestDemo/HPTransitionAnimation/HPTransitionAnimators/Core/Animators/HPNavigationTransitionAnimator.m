//
//  HPNavigationTransitionAnimator.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPNavigationTransitionAnimator.h"
#import <objc/runtime.h>
#import "HPBaseTransitionAnimator+PushFromItemAnimation.h"
#import "HPBaseTransitionAnimator+PageCoverAnimation.h"
#import "HPBaseTransitionAnimator+PageFlipAnimation.h"


#import "HPBaseTransitionAnimator+BoomAnimation.h"
#import "HPBaseTransitionAnimator+InsideThenPushAnimation.h"
#import "HPBaseTransitionAnimator+SpreadAnimation.h"
#import "HPBaseTransitionAnimator+BrickAnimation.h"
#import "HPBaseTransitionAnimator+FragmentAnimation.h"


#import "HPBaseTransitionAnimator+SpringWithDampingAnimation.h"

@implementation HPNavigationTransitionAnimatorParams
@end

@implementation HPNavigationTransitionAnimator

+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options{
    HPNavigationTransitionAnimator *animator = [[HPNavigationTransitionAnimator alloc]init];
    animator.pageState = state;
    animator.option = options;
    return animator;
}
+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options startPosition:(HP_Animation_StartPosition)position{
    HPNavigationTransitionAnimator *animator = [[HPNavigationTransitionAnimator alloc]init];
    animator.pageState = state;
    animator.option = options;
    animator.params.startPosition = position;
    return animator;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
} 
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}
  
 
@end
