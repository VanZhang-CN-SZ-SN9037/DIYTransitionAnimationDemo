//
//  HPTabBarCtrlTransitionAnimator.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import "HPBaseTransitionAnimator.h"
 
@interface HPTabBarCtrlTransitionAnimatorParams:NSObject
@end

@interface HPTabBarCtrlTransitionAnimator : HPBaseTransitionAnimator

 
@property (assign, nonatomic) HPTabBarSelectItemTransitionAnimationOptions tabOption;

+ (instancetype)animatorWithTransitionAnimationOptions:(HPTabBarSelectItemTransitionAnimationOptions)options;

+ (instancetype)animatorWithTransitionAnimationOptions:(HPTabBarSelectItemTransitionAnimationOptions)options startPosition:(HP_Animation_StartPosition)position;


@end
