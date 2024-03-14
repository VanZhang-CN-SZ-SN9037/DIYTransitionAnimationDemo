//
//  HPMenuContainerView.m
//  NSRTCSDKDemo
//
//  Created by VanZhang on 2020/12/9.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import "HPMenuContainerView.h"

#import "HPMenuView.h"


@interface HPMenuContainerView ()
@property (assign, nonatomic) HPMenuContainerCoverStyle style;
@end
@implementation HPMenuContainerView
+ (instancetype)menuWithFrame:(CGRect)frame coverStyle:(HPMenuContainerCoverStyle)style{
    HPMenuContainerView *cover = [[HPMenuContainerView alloc]initWithFrame:frame];
    if (cover) {
        cover.style = style;
    }
    return cover;
}
- (void) dealloc { NSLog(@"dealloc %@", self); }

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}
- (void)setStyle:(HPMenuContainerCoverStyle)style{
    _style= style;
    if (style==MenuCoverColor_Gray) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }else if (style==MenuCoverColor_Clear){
        self.backgroundColor = [UIColor clearColor];
    }
}
- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[HPMenuView class]] && [subview respondsToSelector:@selector(dismissMenu:)]) {
            [subview performSelector:@selector(dismissMenu:) withObject:@(YES)];
        }
    }
}

@end
