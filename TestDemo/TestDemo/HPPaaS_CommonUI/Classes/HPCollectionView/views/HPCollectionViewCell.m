//
//  HPCollectionViewCell.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import "HPCollectionViewCell.h"

@implementation HPCollectionViewCell
+ (UINib *)hp_nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)hp_reuseIdentifier {
    return NSStringFromClass([self class]);
}
@end
