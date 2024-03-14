//
//  CollectionViewItemViewController.m
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/19.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "CollectionViewItemViewController.h"
#import "UIBarButtonItem+HPCommonUI.h"
 
#import "UINavigationController+HPTransitionAnimation.h"
#import "UIViewController+HPTransitionAnimation.h"

@interface CollectionViewItemViewController ()

@end

@implementation CollectionViewItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [imageBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld", (long)_imageIndex]] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageBtn];
    
    imageBtn.center = self.view.center; 
    __weak typeof(self)  weakSelf = self;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftItemWithTitle:@"返回" titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:12.0f] click:^(UIButton *sendor) {
        [weakSelf.navigationController popViewControllerAnimationOptions:self.animationType params:nil];
    }];
    self.navigationController.pushAnimator.params.transitionAnimationView = imageBtn;
}
- (void)click:(UIButton*)sendor{
    
    [self dismissViewControllerAnimationOptions:self.animationType params:self.params completion:^{
        NSLog(@"dissmiss");
    }];
}
@end
