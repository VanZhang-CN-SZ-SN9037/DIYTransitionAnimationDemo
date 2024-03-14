//
//  HPTransitionAnimator.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import <UIKit/UIKit.h>
#import "HPTransitionAnimationDefine.h"
#import "HPPercentDrivenInteractiveTransition.h"
@interface UIView (FrameChange)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat bottomFromSuperView;
@end

@interface UIView (anchorPoint)
- (void)setAnchorPointTo:(CGPoint)point;
@end
@interface HPBaseTransitionAnimatorParams:NSObject
@property (assign , nonatomic) CGFloat animationPercentage;
@property (assign , nonatomic) BOOL shouldComplecte;
//Desc:
@property (weak, nonatomic) UIView *transitionAnimationView;
@end

@interface HPBaseTransitionAnimatorParams (HPPageTransitionAnimationOptionsPushFromItem)
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGPoint itemCenter;
@property (nonatomic,  copy) NSString *itemImageName;
@end


@interface HPBaseTransitionAnimatorParams (HPPageTransitionAnimationOption_Spread_OnePoint)
@property (nonatomic, assign) CGPoint point;
@end


@interface HPBaseTransitionAnimatorParams (HPPageTransitionAnimationCommonParams)
@property (nonatomic, assign) HP_Animation_StartPosition startPosition;;
@end



@interface HPBaseTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIViewController *fromViewController;
@property (nonatomic, strong) UIViewController *toViewController;

@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIView *toView;

@property (nonatomic, assign) NSTimeInterval duration;
 

@property (assign, nonatomic) HPPageTransitionState pageState;
@property (assign, nonatomic) HPPageTransitionAnimationOptions option;
//Desc:动画抽象参数
@property (strong, nonatomic) HPBaseTransitionAnimatorParams *params;
@property (copy, nonatomic) HPTransitionAnimationHandler completionBlock;


@property (strong, nonatomic) HPPercentDrivenInteractiveTransition *interactiveTransition;

//Desc:
-(HPPercentDrivenInteractiveTransition *)interactiveTransitionWithState:(HPDrivenInteractiveTransitionState)state direction:(HPDrivenInteractiveTransitionGestureDirection)direction;

@end
