//
//  HPTransitionAnimation+TabbarControllerDelegate.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/28.
//

#import <UIKit/UIKit.h>
#import "HPTransitionAnimation.h" 
 
@interface HPTransitionAnimation (TabbarControllerDelegate)<UITabBarControllerDelegate>
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
 
