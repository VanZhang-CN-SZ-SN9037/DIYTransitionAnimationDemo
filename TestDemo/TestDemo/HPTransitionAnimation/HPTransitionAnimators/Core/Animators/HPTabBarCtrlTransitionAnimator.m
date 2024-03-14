//
//  HPTabBarCtrlTransitionAnimator.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "HPTabBarCtrlTransitionAnimator.h"



 
@implementation HPTabBarCtrlTransitionAnimatorParams
@end
@implementation HPTabBarCtrlTransitionAnimator
+ (instancetype)animatorWithTransitionAnimationOptions:(HPTabBarSelectItemTransitionAnimationOptions)options{
    HPTabBarCtrlTransitionAnimator *animator = [[HPTabBarCtrlTransitionAnimator alloc]init];
    animator.tabOption = options;
    return animator;
}
+ (instancetype)animatorWithTransitionAnimationOptions:(HPTabBarSelectItemTransitionAnimationOptions)options startPosition:(HP_Animation_StartPosition)position{
    HPTabBarCtrlTransitionAnimator *animator = [[HPTabBarCtrlTransitionAnimator alloc]init];
    animator.tabOption = options;
    animator.params.startPosition = position;
    return animator;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
} 
//- (NSTimeInterval)duration{
//    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
//    return duration;
//}
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
/**
 *  动画时长
 */
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//   NSTimeInterval duration = 0.5f;
//   switch (self.option) {
//       case HPTabBarSelectItemTransitionAnimationOption_PageFlip_Vertical:
//       case HPTabBarSelectItemTransitionAnimationOption_Brick_Open_Horizontal:
//       case HPTabBarSelectItemTransitionAnimationOption_PageCover:
//       case HPTabBarSelectItemTransitionAnimationOption_SpringWithDamping:
//           duration = 1;
//           break;
//       case HPTabBarSelectItemTransitionAnimationOption_Boom:
//           duration = 0.5f;
//           break;
//
//       default:
//           break;
//   }
//   return duration;
//}
 
// This method can only be a no-op if the transition is interactive and not a percentDriven interactive transition.
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    self.transitionContext = transitionContext;
//    self.containerView = [transitionContext containerView];
//    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    // iOS8之后才有
//    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
//        self.fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//        self.toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    } else {
//        self.fromView = self.fromViewController.view;
//        self.toView = self.toViewController.view;
//    }
//    switch (self.option) {
//        case HPTabBarSelectItemTransitionAnimationOption_PageFlip_Horizontal:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_PageFlip_Vertical:{
//
//        } break;
//
//        case HPTabBarSelectItemTransitionAnimationOption_PageCover:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Brick_Open_Vertical:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Brick_Open_Horizontal:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Brick_Close_Vertical:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Brick_Close_Horizontal:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Fragment_Show:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Fragment_Hide:{
//
//        } break;
//        case HPTabBarSelectItemTransitionAnimationOption_Boom:{
//
//        }break;
//        case HPTabBarSelectItemTransitionAnimationOption_InsideThenPush:{
//
//        }break;
//        case HPTabBarSelectItemTransitionAnimationOption_Spread_OnePoint:{
//
//        }break;
//        case HPTabBarSelectItemTransitionAnimationOption_Spread_OneSide:{
//
//        }break;
//
//        case HPTabBarSelectItemTransitionAnimationOption_SpringWithDamping:{
//
//        } break;
//
//        default:break;
//    }
//
//
//
//
//
//
//    NSLog(@"animationStart");
//}

//  颗粒度小到View
/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
//- (id <UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    return nil;
//}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
//- (void)animationEnded:(BOOL)transitionCompleted{
//    NSLog(@"animationEnded");
//}
//
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    !self.completionBlock?:self.completionBlock();
//}
@end
