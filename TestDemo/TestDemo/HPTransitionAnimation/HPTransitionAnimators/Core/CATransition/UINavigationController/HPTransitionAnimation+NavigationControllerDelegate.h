//
//  HPTransitionAnimation+NavigationControllerDelegate.h
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/24.
//

#import<UIKit/UIKit.h>
#import "HPTransitionAnimation.h"
 
@interface HPTransitionAnimation (NavigationControllerDelegate)<UINavigationControllerDelegate> 
@property (strong, nonatomic) UINavigationController *navigationController;
@end
 
