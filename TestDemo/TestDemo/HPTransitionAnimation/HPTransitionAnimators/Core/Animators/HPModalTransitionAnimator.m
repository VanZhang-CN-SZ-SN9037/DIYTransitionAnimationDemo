//
//  HPModalTransitionAnimator.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPModalTransitionAnimator.h"
#import "HPModalTransitionAnimator+PresentTopHalfPageAnimation.h" 


 
@implementation HPModalTransitionAnimatorParams
@end

  
 
@interface HPModalTransitionAnimator ()


@end
@implementation HPModalTransitionAnimator
+ (instancetype)animatorWithTransitionState:(HPPageTransitionState)state animationOptions:(HPPageTransitionAnimationOptions)options{
    HPModalTransitionAnimator *animator = [[HPModalTransitionAnimator alloc]init];
    animator.pageState = state;
    animator.option = options;
    return animator;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.pageState = HPPageTransitionState_ModalTransition_Present;
    }
    return self;
}
 
// This method can only be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
    
    HPPageTransitionState transitionState = self.pageState;
    switch (self.option) {
        case HPPageTransitionAnimationOption_Modal_PresentNextPageWithHalfFrame:{
            [self presentTopHalfPageAnimationWithTransitionState:transitionState];
        }break;
        default:break;
    }
}

 

@end
