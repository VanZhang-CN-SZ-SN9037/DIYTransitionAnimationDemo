//
//  HPTransitionAnimationOption_Define.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/23.
//

#ifndef HPTransitionAnimationDefine_h
#define HPTransitionAnimationDefine_h

typedef void(^HPTransitionAnimationComplection)(void);
typedef HPTransitionAnimationComplection HPTransitionAnimationHandler;


/*
 转场动画的方向 过渡方向
 */
typedef NS_ENUM(NSUInteger,HP_Animation_StartPosition) {
    HP_Animation_StartPosition_Top  = 0,//上
    HP_Animation_StartPosition_Bottom,//下
    HP_Animation_StartPosition_Left,//左
    HP_Animation_StartPosition_Right,//右
};

typedef NS_ENUM(NSUInteger,HP_Animation_To_Position) {
    HP_Animation_To_Position_Top  = 0,//上
    HP_Animation_To_Position_Bottom,//下
    HP_Animation_To_Position_Left,//左
    HP_Animation_To_Position_Right,//右
};

typedef NS_ENUM(NSUInteger,HP_PageFlipAnimation_Options) {
    HP_PageFlipAnimation_Option_VerticalFlip  = 1,//垂直方向翻转
    HP_PageFlipAnimation_Option_HorizontalFlip = 2,//水平方向翻转
};
typedef NS_ENUM(NSUInteger,HP_BrickAnimation_Options) {
    HP_BrickAnimation_Option_OpenVertical  = 5,//垂直方向打开
    HP_BrickAnimation_Option_OpenHorizontal  = 6,//水平方向打开
    HP_BrickAnimation_Option_CloseVertical = 7,//垂直方向关闭
    HP_BrickAnimation_Option_CloseHorizontal = 8,//水平方向关闭
};

typedef NS_ENUM(NSUInteger,HP_FragmentAnimation_Options) {
    HP_FragmentAnimation_Option_Show = 9,
    HP_FragmentAnimation_Option_Hide = 10
};
 


 

typedef NS_ENUM(NSUInteger,HPPageTransitionState) {
   HPPageTransitionState_NavigationTransition_None = -1,//默认是不开启,回避Hook之后的动画选择上的bug
#pragma mark-NavigationTransition
   HPPageTransitionState_NavigationTransition_Push = 0,//开启
   HPPageTransitionState_NavigationTransition_Pop,//关闭
#pragma mark-ModalTransition
   HPPageTransitionState_ModalTransition_Present  ,
   HPPageTransitionState_ModalTransition_Dissmiss, 
};
 

 

typedef NS_ENUM(NSUInteger,HPPageTransitionAnimationOptions) {
    
    HPPageTransitionAnimationOption_PushFromItem = 0,
   
    HPPageTransitionAnimationOption_PageFlip_Vertical   ,
    HPPageTransitionAnimationOption_PageFlip_Horizontal   ,
   
    HPPageTransitionAnimationOption_PageCover,
    
    HPPageTransitionAnimationOption_Brick_Open_Vertical  ,
    HPPageTransitionAnimationOption_Brick_Open_Horizontal   ,
    HPPageTransitionAnimationOption_Brick_Close_Vertical  ,
    HPPageTransitionAnimationOption_Brick_Close_Horizontal  ,
    
    HPPageTransitionAnimationOption_Fragment_Show   ,
    HPPageTransitionAnimationOption_Fragment_Hide   ,
    
    HPPageTransitionAnimationOption_Boom,
    HPPageTransitionAnimationOption_InsideThenPush,

    
    HPPageTransitionAnimationOption_Spread_OnePoint,
    HPPageTransitionAnimationOption_Spread_OneSide,
     
    HPPageTransitionAnimationOption_SpringWithDamping  , 
    
    HPPageTransitionAnimationOption_Modal_PresentNextPageWithHalfFrame,
    
    
    HPPageTransitionAnimationOption_Last_Option
};

typedef NS_ENUM(NSUInteger,HPTabBarSelectItemTransitionAnimationOptions) {
     
    HPTabBarSelectItemTransitionAnimationOption_PageFlip_Vertical  = 0 ,
//    HPTabBarSelectItemTransitionAnimationOption_PageFlip_Horizontal   ,
//
//    HPTabBarSelectItemTransitionAnimationOption_PageCover,
//
//    HPTabBarSelectItemTransitionAnimationOption_Brick_Open_Vertical  ,
//    HPTabBarSelectItemTransitionAnimationOption_Brick_Open_Horizontal   ,
//    HPTabBarSelectItemTransitionAnimationOption_Brick_Close_Vertical  ,
//    HPTabBarSelectItemTransitionAnimationOption_Brick_Close_Horizontal  ,
//
//    HPTabBarSelectItemTransitionAnimationOption_Fragment_Show   ,
//    HPTabBarSelectItemTransitionAnimationOption_Fragment_Hide   ,
//
//    HPTabBarSelectItemTransitionAnimationOption_Boom,
//    HPTabBarSelectItemTransitionAnimationOption_InsideThenPush,
//
//
//    HPTabBarSelectItemTransitionAnimationOption_Spread_OnePoint,
//    HPTabBarSelectItemTransitionAnimationOption_Spread_OneSide,
//
//    HPTabBarSelectItemTransitionAnimationOption_SpringWithDamping  , 
};


//已经写好了动画类型
/*
 转场动画的过渡效果
 fade           //交叉淡化过渡(不支持过渡方向)
 push           //新视图把旧视图推出去
 moveIn         //新视图移到旧视图上面
 reveal         //将旧视图移开,显示下面的新视图
 cube           //立方体翻滚效果
 oglFlip        //上下左右翻转效果
 suckEffect     //收缩效果，如一块布被抽走(不支持过渡方向)
 rippleEffect   //滴水效果(不支持过渡方向)
 pageCurl       //向上翻页效果
 pageUnCurl     //向下翻页效果
 cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
 cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 */

typedef NS_ENUM(NSInteger, HP_CATransition_Animation_Options) {
    HP_CATransition_Animation_Option_Fade = 0,
    HP_CATransition_Animation_Option_Push,
    HP_CATransition_Animation_Option_MoveIn,
    HP_CATransition_Animation_Option_Reveal,
    HP_CATransition_Animation_Option_Cube,
    HP_CATransition_Animation_Option_OglFlip,
    HP_CATransition_Animation_Option_SuckEffect,
    HP_CATransition_Animation_Option_RippleEffect,
    HP_CATransition_Animation_Option_PageCurl,
    HP_CATransition_Animation_Option_PageUnCurl,
    
    HP_CATransition_Animation_Option_CameraIrisHollowOpen,
    HP_CATransition_Animation_Option_CameraIrisHollowClose,
};



/*
 转场动画的方向 过渡方向
 */
typedef NS_ENUM(NSUInteger,HP_CATransition_Animation_FlipPosition) {
    HP_CATransition_Animation_FlipPosition_Top  = HP_Animation_StartPosition_Top,//上
    HP_CATransition_Animation_FlipPosition_Bottom = HP_Animation_StartPosition_Bottom,//下
    HP_CATransition_Animation_FlipPosition_Left = HP_Animation_StartPosition_Left,//左
    HP_CATransition_Animation_FlipPosition_Right = HP_Animation_StartPosition_Right,//右
};

typedef NS_ENUM(NSInteger,HPGestureType){
    HPGestureTypeNone,
    HPGestureTypePanLeft,
    HPGestureTypePanRight,
    HPGestureTypePanUp,
    HPGestureTypePanDown, 
};


#endif /* HPTransitionAnimationDefine_h */
