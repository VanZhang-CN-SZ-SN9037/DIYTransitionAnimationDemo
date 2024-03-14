//
//  DemoViewController.h
//  HybridShellProj
//
//  Created by VanZhang on 2021/8/17.
//

#import <UIKit/UIKit.h>

#define kHP_IS_Instance_RespondToSelector(InstanceClass,selectorName) [InstanceClass instancesRespondToSelector:@selector(selectorName)]

#define kHP_IS_Screen_RespondTo_CurrentMode kHP_IS_Instance_RespondToSelector(UIScreen,currentMode)
#define kHP_IS_Screen_CurrentMode_Size [[UIScreen mainScreen] currentMode].size

#define kHP_Size(x,y) CGSizeMake(x, y)
#define kHP_IS_Size_Equal_To_XxY_YxX(x,y,CGSize_Instance) (CGSizeEqualToSize(kHP_Size(x, y), CGSize_Instance) || CGSizeEqualToSize(kHP_Size(y, x), CGSize_Instance))
 
#define kHP_IS_Screen_CurrentMode_Size_Equal_To_XxY_YxX(x,y) kHP_IS_Size_Equal_To_XxY_YxX(x,y,kHP_IS_Screen_CurrentMode_Size)


#define kHP_Is_iPhoneX     \
(kHP_IS_Screen_RespondTo_CurrentMode ? kHP_IS_Screen_CurrentMode_Size_Equal_To_XxY_YxX(1125,2436) : NO)


#define kHP_Is_iPhoneXR    \
(kHP_IS_Screen_RespondTo_CurrentMode ? kHP_IS_Screen_CurrentMode_Size_Equal_To_XxY_YxX(828,1792) : NO)
NS_ASSUME_NONNULL_BEGIN
#pragma mark- HPNavgationBar
@interface UIView (HPNavgationBar)
+ (CGFloat)hp_statusBar_Height;
+ (CGFloat)hp_navigationBar_Height;
+ (CGFloat)hp_navigationBarIcon_Height;

+ (UIFont*)hp_navigationBar_title_font;
+ (CGFloat)hp_navigationBar_title_fontSize;

+ (UIImage*)hp_navigationBar_background_Img;


@end



#pragma mark- HPNavgationBar
@implementation UIView (HPNavgationBar)
+ (CGFloat)hp_statusBar_Height{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    return statusBarHeight;
}
+ (CGFloat)hp_navigationBar_Height{
   
    return (kHP_Is_iPhoneX||kHP_Is_iPhoneXR)?145:64;
}
+ (CGFloat)hp_navigationBarIcon_Height{
    return 20;
}
//PingFangSC-Medium,中粗体
//PingFangSC-Semibold,粗体
//PingFangSC-Light,白体
//PingFangSC-Ultralight,纤细体
//PingFangSC-Regular,常规体
//PingFangSC-Thin 细
+ (UIFont*)hp_navigationBar_title_font{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:self.hp_navigationBar_title_fontSize];
}
+ (CGFloat)hp_navigationBar_title_fontSize{
    return 18;
}

+ (UIImage*)hp_navigationBar_background_Img{
    return [UIImage imageNamed:@"head_navigationBar_background"];
}

@end


@interface DemoViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

