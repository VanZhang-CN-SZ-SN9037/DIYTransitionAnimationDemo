//
//  VCTransitionDemoViewController.m
//  HybridShellProj
//
//  Created by VanZhang on 2021/9/23.
//

#import "VCTransitionDemoViewController.h"
#import "VCTransitionDetailViewController.h"

#import "HPTransitionAnimation.h"
#import "Masonry.h"
@interface VCTransitionDemoViewController ()

@end

@implementation VCTransitionDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *openPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openPageBtn setTitle:@"跳转" forState:UIControlStateNormal];
    [openPageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    openPageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:openPageBtn];
    [openPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@30);
        make.height.equalTo(@50);
    }];
    [openPageBtn addTarget:self action:@selector(openPage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f green:arc4random_uniform(255.0f)/255.0f blue:arc4random_uniform(255.0f)/255.0f alpha:1.0]];
}
- (void)openPage:(UIButton*)sendor{
    VCTransitionDetailViewController *firstDetailVc = [[VCTransitionDetailViewController alloc]init];
    firstDetailVc.options = self.options;
    VCTransitionDetailViewController *secondDetailVc = [[VCTransitionDetailViewController alloc]init];
    secondDetailVc.options = self.options;
    [self addChildViewController:firstDetailVc];
    [self addChildViewController:secondDetailVc];
    [HPTransitionAnimation openViewWithTransitionFromViewController:firstDetailVc toViewController:secondDetailVc duration:0.357 options:self.options];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
