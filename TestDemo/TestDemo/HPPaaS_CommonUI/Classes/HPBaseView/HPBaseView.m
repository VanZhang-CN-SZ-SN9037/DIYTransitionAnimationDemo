//
//  HPBaseView.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/8.
//

#import "HPBaseView.h"

@implementation HPBaseView
- (instancetype)initWithViewModel:(id<HPBaseViewModelProtocol>)viewModel{
    self = [super init];
    if (self) { 
        self.viewModel = viewModel;
        [self setupViews];
        [self setKeyBoardReturn];
        [self bindViewModel];
    }
    return self;
}

+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}
+ (NSString *)reuseIdentifier{
    return @"";
}

-(void)setupViews{}
-(void)bindViewModel{}
-(void)setKeyBoardReturn{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
