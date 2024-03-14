//
//  HPSliderTagItemModel.m
//  HPSliderContainerKitDemo
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import "HPSliderTagItemModel.h"

@implementation HPSliderTagItemModel
+ (instancetype)modelWithtagTitle:(NSString *)title
               andNormalTitleFont:(UIFont *)normalTitleFont
             andSelectedTitleFont:(UIFont *)selectedTitleFont
              andNormalTitleColor:(UIColor *)normalTitleColor
            andSelectedTitleColor:(UIColor *)selectedTitleColor
{
    HPSliderTagItemModel *tag = [[self alloc]init];
    tag.tagTitle = title;
    tag.normalTitleFont = normalTitleFont;
    tag.selectedTitleFont = selectedTitleFont;
    tag.normalTitleColor = normalTitleColor;
    tag.selectedTitleColor = selectedTitleColor;
    tag.selected  = NO;
    return tag;
}
@end
