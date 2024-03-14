//
//  ModalDemoDetailViewController.m
//  HybridShellProj
//
//  Created by VanZhang on 2021/9/23.
//

#import "ModalDemoDetailViewController.h"
#import "UIViewController+HPTransitionAnimation.h"
#import "Masonry.h"

@interface ModalDemoDetailViewController ()

@end

@implementation ModalDemoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *topLb  = [[UILabel alloc]initWithFrame:CGRectZero];
    topLb.text = @"topLb";
    topLb.font = [UIFont boldSystemFontOfSize:13];
    topLb.textColor = [UIColor blackColor];
    topLb.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:topLb];
    [topLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(0));
        make.width.equalTo(@(100));
        make.height.equalTo(@(60));
    }];
    UILabel *bottomLb  = [[UILabel alloc]initWithFrame:CGRectZero];
    bottomLb.text = @"bottomLb";
    bottomLb.font = [UIFont boldSystemFontOfSize:13];
    bottomLb.textColor = [UIColor blackColor];
    bottomLb.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bottomLb];
    [bottomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.bottom.equalTo(@(0));
        make.width.equalTo(@(100));
        make.height.equalTo(@(60));
    }];
    UIButton *openPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [openPageBtn setTitle:@"返回" forState:UIControlStateNormal];
    [openPageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    openPageBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:openPageBtn];
    [openPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self.view);
        make.width.equalTo(@30);
        make.height.equalTo(@50);
    }];
    [openPageBtn addTarget:self action:@selector(closePage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:arc4random_uniform(255.0f)/255.0f green:arc4random_uniform(255.0f)/255.0f blue:arc4random_uniform(255.0f)/255.0f alpha:1.0]];
}
- (void)closePage:(UIButton*)sendor{
    [self dismissViewControllerAnimation:self.animationType flipPosition:self.flip completion:^{
        NSLog(@"dissmiss");
    }];
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
