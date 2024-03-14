//
//  HPTableViewCell.m
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import "HPTableViewCell.h"

@implementation HPTableViewCell
+ (UINib *)hp_nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)hp_reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
@interface HPTableViewHeaderFooterView ()

@end
@implementation HPTableViewHeaderFooterView
+ (UINib *)hp_nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)hp_reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
 
