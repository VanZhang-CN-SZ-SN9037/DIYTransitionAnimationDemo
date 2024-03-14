//
//  HPModalTransitionAnimator+SpringWithDampingAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import "HPBaseTransitionAnimator+SpringWithDampingAnimation.h"

@implementation HPBaseTransitionAnimator (SpringWithDampingAnimation)

- (void)springWithDampingAnimationWithTransitionState:(HPPageTransitionState)state{
  
    __weak typeof(self)  weakSelf = self;
    void (^CallOpenPageHandler)(void) = ^(void){
         
            // fromView的起始frame
            weakSelf.fromView.frame = [weakSelf.transitionContext initialFrameForViewController:weakSelf.fromViewController];
            
            // 设置toView在转场开始时的位置和alpha.
            weakSelf.toView.frame = [weakSelf.transitionContext initialFrameForViewController:weakSelf.toViewController]; // 全为0, 则toView从左上角扩散出来
        //    self.toView.frame = CGRectMake(CGRectGetMinX(self.fromView.frame),
        //                              CGRectGetHeight(self.fromView.frame),
        ////                              CGRectGetMaxY(self.fromView.frame) / 2, // 从中间往上弹出来
        ////                              CGRectGetMinY(self.fromView.frame), // 在fromView之上渐变出现
        //                              CGRectGetWidth(self.fromView.frame),
        //                              CGRectGetHeight(self.fromView.frame));
            weakSelf.toView.alpha = 0.0f;
            
            // containerView为transitionContext所包含的, 所有的动画都在该view中进行.
            [weakSelf.containerView addSubview:weakSelf.toView];

            NSTimeInterval duration = [weakSelf transitionDuration:weakSelf.transitionContext];
         
            
            weakSelf.toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            
            [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                weakSelf.toView.transform = CGAffineTransformIdentity;
                
                // 指定位置
                weakSelf.toView.frame = [weakSelf.transitionContext finalFrameForViewController:weakSelf.toViewController];
                weakSelf.toView.alpha = 1.0f;
                
            } completion:^(BOOL finished) {
                BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
                [weakSelf.transitionContext completeTransition:!wasCancelled];
            }];
    };
    
    void (^CallClosePageHandler)(void) = ^(void){
        weakSelf.toView.frame = [weakSelf.transitionContext finalFrameForViewController:weakSelf.toViewController];
        [weakSelf.containerView insertSubview:weakSelf.toView belowSubview:weakSelf.fromView];
        NSTimeInterval duration = [weakSelf transitionDuration:weakSelf.transitionContext];
        weakSelf.fromView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            weakSelf.fromView.frame = CGRectZero;
            weakSelf.fromView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
            [weakSelf.transitionContext completeTransition:!wasCancelled];
        }];
    };
    
    switch (state) {
        
        case HPPageTransitionState_NavigationTransition_Push:
        case HPPageTransitionState_ModalTransition_Present:
            CallOpenPageHandler();
            break;
        case HPPageTransitionState_NavigationTransition_Pop:
        case HPPageTransitionState_ModalTransition_Dissmiss:
            CallClosePageHandler();
            break;
        case HPPageTransitionState_NavigationTransition_None:break;
    } 
}
@end
