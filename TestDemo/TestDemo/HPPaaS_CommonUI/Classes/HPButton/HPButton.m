//
//  HPButton.m
//  HPPaaS_MobileFramework
//
//  Created by VanZhang on 2021/9/10.
//

#import "HPButton.h"

static const CGFloat kbadgeWH = 16;
@implementation HPButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    UIButton *badgebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    badgebtn.backgroundColor = [UIColor redColor];
    [badgebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGRect frame = badgebtn.frame;
    frame.size = CGSizeMake(kbadgeWH, kbadgeWH);
    badgebtn.frame = frame;
    badgebtn.layer.cornerRadius = badgebtn.frame.size.width/2;
    badgebtn.layer.masksToBounds = YES;
    badgebtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    badgebtn.hidden = YES;
    [self addSubview:badgebtn];
    self.badgeBtn = badgebtn;
}

-(void)setBadge:(NSInteger)badge
{
    _badge = badge;
    // 判断修改红点数字
    if (_badge == 0)
    {
        self.badgeBtn.hidden = YES;
        [self.badgeBtn setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        self.badgeBtn.hidden = NO;
        if (badge > 99)
        {
            badge = 99;
        }
        [self.badgeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_badge] forState:UIControlStateNormal];
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    
    self.badgeBtn.frame = CGRectMake(self.bounds.size.width/2.0 , self.bounds.size.height/2.0 - image.size.height/2.0 - kbadgeWH/5.0, self.badgeBtn.bounds.size.width, self.badgeBtn.bounds.size.height);
    
    
}

-(void)showBadgeButtonWithoutNum
{
    self.badgeBtn.hidden = NO;
    [self.badgeBtn setTitle:@"" forState:UIControlStateNormal];
}

@end
