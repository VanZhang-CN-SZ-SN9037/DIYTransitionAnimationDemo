//
//  HPTransitionAnimation.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/17.
//

#import <Foundation/Foundation.h>

#import "HPTransitionAnimationDefine.h"

#import "HPModalTransitionAnimator.h"
#import "HPNavigationTransitionAnimator.h"

//高级自定义动画_扩展的时候 分别拓展「HPModalTransitionAnimator-HPModalTransitionAnimationOptions」、「HPNavigationTransitionAnimator-HPNavigationTransitionAnimationOptions」即可
@interface HPTransitionAnimation : NSObject
+ (instancetype)shareInstance;

//Desc:
@property (strong, nonatomic) HPBaseTransitionAnimatorParams *tempPushAnimatorParams;
@property (strong, nonatomic) HPBaseTransitionAnimatorParams *tempPresentAnimatorParams;
@property (strong, nonatomic) HPBaseTransitionAnimatorParams *tempSelectTabItemAnimatorParams;
@end

@interface HPTransitionAnimation(CATransition)
+ (CATransition*)createAnimation:(HP_CATransition_Animation_Options)animation  withFlipPosition:(HP_CATransition_Animation_FlipPosition)position;
@end

/*
    UIViewAnimationOptionTransitionNone            = 0 << 20, // default
    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
*/

//自定义动画类型 必须是由 父、子 控制器 之间操作（比如 TabBarController 是可以使用以下扩展方法的、进行了addChildViewController的普通控制器也行）
@interface HPTransitionAnimation (UIContainerViewController)

#pragma mark-openView

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion;

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations;

+ (void)openViewWithTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

#pragma mark-closeView

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations;

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion;

+ (void)closeViewWithTransitionFromViewController:(UIViewController*)fromViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
@end




