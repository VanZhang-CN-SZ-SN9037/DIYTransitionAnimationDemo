//
//  HPTransitionAnimation+ViewControllerTransitioningDelegate.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//
#import<UIKit/UIKit.h>
#import "HPTransitionAnimation.h"
 

@interface HPTransitionAnimation (ViewControllerTransitioningDelegate)<UIViewControllerTransitioningDelegate>
//Desc:
@property (strong, nonatomic) UIViewController *viewController;
@end
 
