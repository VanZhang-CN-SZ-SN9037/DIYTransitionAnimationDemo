//
//  HPPercentDrivenInteractiveTransition.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import <UIKit/UIKit.h>
 
#import "HPTransitionAnimationDefine.h"

typedef NS_ENUM(NSUInteger, HPDrivenInteractiveTransitionGestureDirection) {//手势的方向
    HPDrivenInteractiveTransition_Gesture_Direction_Left = 0,
    HPDrivenInteractiveTransition_Gesture_Direction_Right,
    HPDrivenInteractiveTransition_Gesture_Direction_Up,
    HPDrivenInteractiveTransition_Gesture_Direction_Down
};

typedef NS_ENUM(NSUInteger, HPDrivenInteractiveTransitionState) {//手势控制哪种转场
    HPDrivenInteractiveTransition_State_Present = 0,
    HPDrivenInteractiveTransition_State_Dismiss,
    HPDrivenInteractiveTransition_State_Push,
    HPDrivenInteractiveTransition_State_Pop,
};
typedef void(^HPPercentDrivenInteractiveGestureHandler)(CGFloat percentage,BOOL shouldComplete);

@interface HPPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
/**记录是否开始手势，判断pop操作是手势触发还是返回键触发*/
@property (nonatomic, assign) BOOL interacting;
/**促发手势present的时候的config，config中初始化并present需要弹出的控制器*/
@property (nonatomic, copy) HPPercentDrivenInteractiveGestureHandler modalHandlerBlock;
/**促发手势push的时候的config，config中初始化并push需要弹出的控制器*/
@property (nonatomic, copy) HPPercentDrivenInteractiveGestureHandler navigationHandlerBlock;

//初始化方法
+ (instancetype)interactiveTransitionWithTransitionState:(HPDrivenInteractiveTransitionState)state gestureDirection:(HPDrivenInteractiveTransitionGestureDirection)direction;
- (instancetype)initWithTransitionState:(HPDrivenInteractiveTransitionState)state gestureDirection:(HPDrivenInteractiveTransitionGestureDirection)direction;
/** 给传入的控制器添加手势*/
- (void)wireToViewController:(UIViewController*)viewController;

@end
