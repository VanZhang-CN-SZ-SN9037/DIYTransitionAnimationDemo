//
//  HPSliderContainerMainController.h
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPSliderContainerMainController : UIViewController
+(instancetype)initWithTitles:(NSArray*)titles childViewControllers:(NSArray*)childViewControllers;

+(instancetype)initWithTitles:(NSArray *)titles childViewControllers:(NSArray *)childViewControllers childVcParams:(NSArray*)params;
@end
