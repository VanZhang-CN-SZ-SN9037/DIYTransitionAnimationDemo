//
//  HPTransitionAnimation.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import "HPTransitionAnimation.h"
@interface HPTransitionAnimation ()
 
@end
@implementation HPTransitionAnimation
//===============SingleTon====================//
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _instance;
}
- (id)mutableCopy{
    return _instance;
}
- (id)copy{
    return _instance;
}
+ (instancetype)shareInstance{
    return [[self alloc]init];
}
//===================================//
@end
@implementation HPTransitionAnimation(CATransition)
+ (CATransition*)animator{
    CATransition *animator = [CATransition animation];
    animator.duration = 0.5;
    animator.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animator.subtype = kCATransitionFromRight;
    return animator;
}
// fromVC 可以是普通控制器 也可以是 NavigationController导航控制器
+ (CATransition*)createAnimation:(HP_CATransition_Animation_Options)animation  withFlipPosition:(HP_CATransition_Animation_FlipPosition)position{
    CATransition *animator = [self animator];
    CATransitionSubtype subtype = kCATransitionFromRight;
    switch (position) {
        case HP_CATransition_Animation_FlipPosition_Top:{
            subtype = kCATransitionFromTop;
        }break;
        case HP_CATransition_Animation_FlipPosition_Bottom:{
            subtype = kCATransitionFromBottom;
        }break;
        case HP_CATransition_Animation_FlipPosition_Left:{
            subtype = kCATransitionFromLeft;
        }break;
        case HP_CATransition_Animation_FlipPosition_Right:{
            subtype = kCATransitionFromRight;
        }break;
    }
    switch (animation) {
            /*
             常见的四种动画
                kCATransitionFade：渐变
                kCATransitionMoveIn：覆盖
                kCATransitionPush：推出
                kCATransitionReveal：揭开
            */
            
        case HP_CATransition_Animation_Option_Fade:{
            animator.type = kCATransitionFade;
        } break;
        case HP_CATransition_Animation_Option_Push:{
            animator.type = kCATransitionPush;
            animator.subtype = subtype;
            animator.duration = 0.35f;;
        }break;
        case HP_CATransition_Animation_Option_MoveIn:{
            animator.type = kCATransitionMoveIn;
            animator.subtype = subtype;
        }break;
        case HP_CATransition_Animation_Option_Reveal:{
            animator.type = kCATransitionReveal;
            animator.subtype = subtype;
        }break;
            /*
             cube：立方体旋转
             suckEffect：吮吸 {不支持设置转场方向}
             oglFlip：翻转
             rippleEffect：水波动画 {不支持设置转场方向}
             pageCurl：翻页
             pageUnCurl：反翻页
             cameraIrisHollowOpen：开镜头 {不支持设置转场方向}
             cameraIrisHollowClose：关镜头 {不支持设置转场方向}
             */
        //以下是 常见的四种动画之外的 几种私有类型
        //效果类似,无法设置转场方向
        case HP_CATransition_Animation_Option_SuckEffect:{
            animator.type = @"suckEffect";
        }break;
        case HP_CATransition_Animation_Option_RippleEffect:{
            animator.type = @"rippleEffect";
        }break;
        case HP_CATransition_Animation_Option_CameraIrisHollowOpen:{
            animator.type = @"cameraIrisHollowOpen";
        }break;
        case HP_CATransition_Animation_Option_CameraIrisHollowClose:{
            animator.type = @"cameraIrisHollowClose";
        }break;
            
            
        case HP_CATransition_Animation_Option_OglFlip:{
            animator.type = @"oglFlip";
            animator.subtype = subtype;
        }break;
        case HP_CATransition_Animation_Option_Cube:{
            animator.type = @"cube";
            animator.subtype = subtype;
        }break;
        case HP_CATransition_Animation_Option_PageCurl:{
            animator.type = @"pageCurl";
            animator.subtype = subtype;
        }break;
        case HP_CATransition_Animation_Option_PageUnCurl:{
            animator.type = @"pageUnCurl";
            animator.subtype = subtype;
        }break;
    }
    return animator;
}

@end
@implementation HPTransitionAnimation(UIContainerViewController)

#pragma mark-openView
+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options{
    [self openViewWithTransitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:NULL];
}

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations{
    [self openViewWithTransitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:animations completion:NULL];
}
+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion{
    [self openViewWithTransitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:NULL completion:completion];
}

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    UIViewController *parentViewController_from = fromViewController.parentViewController;
    UIViewController *parentViewController_to = toViewController.parentViewController;
    if ((parentViewController_from == parentViewController_to)&&(parentViewController_from != nil)) {
        UIViewController *parentViewController = parentViewController_from;
        [parentViewController transitionFromViewController:fromViewController
                                          toViewController:toViewController
                                                  duration:duration
                                                   options:options
                                                animations:animations
                                                completion:completion];
    }
}


#pragma mark-closeView
+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options{
    [self closeViewWithTransitionFromViewController:fromViewController duration:duration options:options animations:NULL];
}

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations{
    [self closeViewWithTransitionFromViewController:fromViewController duration:duration options:options animations:animations completion:NULL];
}

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion{
    [self closeViewWithTransitionFromViewController:fromViewController duration:duration options:options animations:NULL completion:completion];
}

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    UIViewController *parentViewController = fromViewController.parentViewController;
    if (parentViewController) {
        NSArray *childVcs = [parentViewController childViewControllers];
        if (childVcs.count>=2) {
            NSUInteger currVCIndex = [childVcs indexOfObject:fromViewController];
            UIViewController * toViewController =(currVCIndex<(childVcs.count-1))?childVcs[currVCIndex+1]:childVcs[0];
            [parentViewController transitionFromViewController:fromViewController toViewController:toViewController duration:duration options:options animations:animations completion:^(BOOL finished) {
                [fromViewController.view removeFromSuperview];
                [fromViewController removeFromParentViewController];
                !completion?:completion(finished);
            }];
        }else{
            [UIView animateWithDuration:duration delay:0 options:options animations:animations completion:^(BOOL finished) {
                [fromViewController.view removeFromSuperview];
                [fromViewController removeFromParentViewController];
                !completion?:completion(finished);
            }];
        }
    }
}

@end

