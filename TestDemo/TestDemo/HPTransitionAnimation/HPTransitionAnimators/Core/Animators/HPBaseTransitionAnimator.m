//
//  HPTransitionAnimator.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPBaseTransitionAnimator.h"
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





@implementation UIView (anchorPoint)

- (void)setAnchorPointTo:(CGPoint)point{
    self.frame = CGRectOffset(self.frame, (point.x - self.layer.anchorPoint.x) * self.frame.size.width, (point.y - self.layer.anchorPoint.y) * self.frame.size.height);
    self.layer.anchorPoint = point;
}

@end

@implementation UIView (FrameChange)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)bottomFromSuperView{
    return self.superview.height - self.y - self.height;
}
@end

@implementation HPBaseTransitionAnimatorParams
@end

 
@implementation HPBaseTransitionAnimatorParams(HPPageTransitionAnimationOptionsPushFromItem)
- (void)setItemSize:(CGSize)itemSize{
    NSValue *sizeValue = [NSValue valueWithCGSize:itemSize];
    objc_setAssociatedObject(self, @selector(itemSize), sizeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGSize)itemSize{
    NSValue *sizeValue = objc_getAssociatedObject(self, _cmd);
    return  sizeValue.CGSizeValue;
}
- (void)setItemCenter:(CGPoint)itemCenter{
    NSValue *centerValue = [NSValue valueWithCGPoint:itemCenter];
    objc_setAssociatedObject(self, @selector(itemCenter), centerValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)itemCenter{
    NSValue *centerValue = objc_getAssociatedObject(self, _cmd);
    return  centerValue.CGPointValue;
}
- (void)setItemImageName:(NSString *)itemImageName{
    objc_setAssociatedObject(self, @selector(itemImageName), itemImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)itemImageName{
    return objc_getAssociatedObject(self, _cmd);
}
@end

@implementation HPBaseTransitionAnimatorParams(HPPageTransitionAnimationOption_Spread_OnePoint)
- (void)setPoint:(CGPoint)point{
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    objc_setAssociatedObject(self, @selector(point), pointValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)point{
    NSValue *pointValue = objc_getAssociatedObject(self, _cmd);
    return  pointValue.CGPointValue;
}
@end

@implementation HPBaseTransitionAnimatorParams(HPPageTransitionAnimationCommonParams)
- (void)setStartPosition:(HP_Animation_StartPosition)startPosition{
    objc_setAssociatedObject(self, @selector(startPosition), @(startPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HP_Animation_StartPosition)startPosition{
    return [objc_getAssociatedObject(self, _cmd) intValue];
}
@end



@interface HPBaseTransitionAnimator ()

@end
@implementation HPBaseTransitionAnimator
-(HPPercentDrivenInteractiveTransition *)interactiveTransitionWithState:(HPDrivenInteractiveTransitionState)state direction:(HPDrivenInteractiveTransitionGestureDirection)direction{
    return [HPPercentDrivenInteractiveTransition interactiveTransitionWithTransitionState:state gestureDirection:direction];
}
- (NSTimeInterval)duration{ 
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    return duration;
}
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
   NSTimeInterval duration = 0.5f;
   switch (self.option) {
       case HPPageTransitionAnimationOption_PushFromItem:
           duration = 0.7f;
           break;
       case HPPageTransitionAnimationOption_PageFlip_Vertical:
       case HPPageTransitionAnimationOption_Brick_Open_Horizontal:
       case HPPageTransitionAnimationOption_PageCover:
       case HPPageTransitionAnimationOption_SpringWithDamping:
           duration = 1;
           break;
       case HPPageTransitionAnimationOption_Boom:
           duration = 0.5f;
           break;
       case HPPageTransitionAnimationOption_Modal_PresentNextPageWithHalfFrame:
           duration = self.pageState == HPPageTransitionState_ModalTransition_Present ? 0.5 : 0.25;
           break;
           
       default:
           break;
   }
   return duration;
}
 
// This method can only be a no-op if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    self.containerView = [transitionContext containerView];
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // iOS8之后才有
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        self.fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        self.toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        self.fromView = self.fromViewController.view;
        self.toView = self.toViewController.view;
    }
     
    HPPageTransitionState transitionState = self.pageState;
    switch (self.option) {
        case HPPageTransitionAnimationOption_PushFromItem:{
            [self pushFromItemWithTransitionState:transitionState];
        } break;
        case HPPageTransitionAnimationOption_PageFlip_Horizontal:{
            [self pageFlipAnimationWithTransitionState:transitionState option:HP_PageFlipAnimation_Option_HorizontalFlip];
        } break;
        case HPPageTransitionAnimationOption_PageFlip_Vertical:{
            [self pageFlipAnimationWithTransitionState:transitionState option:HP_PageFlipAnimation_Option_VerticalFlip];
        } break;
            
        case HPPageTransitionAnimationOption_PageCover:{
            [self pageCoverAnimationWithTransitionState:transitionState];
        } break;
        case HPPageTransitionAnimationOption_Brick_Open_Vertical:{
            [self presentWithBrickAnimationWithTransitionState:transitionState option:HP_BrickAnimation_Option_OpenVertical];
        } break;
        case HPPageTransitionAnimationOption_Brick_Open_Horizontal:{
            [self presentWithBrickAnimationWithTransitionState:transitionState option:HP_BrickAnimation_Option_OpenHorizontal];
        } break;
        case HPPageTransitionAnimationOption_Brick_Close_Vertical:{
            [self presentWithBrickAnimationWithTransitionState:transitionState option:HP_BrickAnimation_Option_CloseVertical];
        } break;
        case HPPageTransitionAnimationOption_Brick_Close_Horizontal:{
            [self presentWithBrickAnimationWithTransitionState:transitionState option:HP_BrickAnimation_Option_CloseHorizontal];
        } break;
        case HPPageTransitionAnimationOption_Fragment_Show:{
            [self presentWithFragmentAnimationWithTransitionState:transitionState option:HP_FragmentAnimation_Option_Show startPosition:self.params.startPosition];
        } break;
        case HPPageTransitionAnimationOption_Fragment_Hide:{
            [self presentWithFragmentAnimationWithTransitionState:transitionState option:HP_FragmentAnimation_Option_Hide startPosition:self.params.startPosition];
        } break;
        case HPPageTransitionAnimationOption_Boom:{
            [self presentWithBoomAnimationWithTransitionState:transitionState];
        }break;
        case HPPageTransitionAnimationOption_InsideThenPush:{
            [self insideThenPushAnimationWithTransitionState:transitionState];
        }break;
        case HPPageTransitionAnimationOption_Spread_OnePoint:{
            [self presentWithPointSpreadAnimationWithTransitionState:transitionState];
        }break;
        case HPPageTransitionAnimationOption_Spread_OneSide:{
            [self presentWithSideSpreadAnimationWithTransitionState:transitionState startPosition:self.params.startPosition];
        }break;
            
        case HPPageTransitionAnimationOption_SpringWithDamping:{
            [self springWithDampingAnimationWithTransitionState:transitionState];
        } break;
            
        default:{
            if (self.option==HPPageTransitionAnimationOption_Modal_PresentNextPageWithHalfFrame) {
                 
            }else{
                [self pushFromItemWithTransitionState:transitionState];
            }
        }break;
    }
    
    
  
     
    
    
    NSLog(@"animationStart");
}

//  颗粒度小到View
/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
//- (id <UIViewImplicitlyAnimating>)interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    return nil;
//}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL)transitionCompleted{
    NSLog(@"animationEnded");
}
  

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    !self.completionBlock?:self.completionBlock();
}
@end





