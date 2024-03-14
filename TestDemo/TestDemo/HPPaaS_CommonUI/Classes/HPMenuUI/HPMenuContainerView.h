//
//  HPMenuContainerView.h
//  NSRTCSDKDemo
//
//  Created by VanZhang on 2020/12/9.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import <UIKit/UIKit.h>
 

/*BackgroundCoverColor*/
typedef NS_ENUM(NSUInteger,HPMenuContainerCoverStyle) {
    MenuCoverColor_Clear  = 0,
    MenuCoverColor_Gray ,
    
};
@interface HPMenuContainerView : UIView
+ (instancetype)menuWithFrame:(CGRect)frame coverStyle:(HPMenuContainerCoverStyle)style;

@end
 
