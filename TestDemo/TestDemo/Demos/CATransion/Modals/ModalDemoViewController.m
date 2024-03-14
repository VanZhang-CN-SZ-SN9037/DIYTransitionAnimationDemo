//
//  ModalDemoViewController.m
//  HybridShellProj
//
//  Created by VanZhang on 2021/9/23.
//

#import "ModalDemoViewController.h" 
#import "ModalDemoDetailViewController.h"
#import "UIViewController+HPTransitionAnimation.h"
#import "Masonry.h"
@interface ModalDemoViewController ()

@end

@implementation ModalDemoViewController

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
     
    ModalDemoDetailViewController *detailPage = [[ModalDemoDetailViewController alloc]init];
    detailPage.animationType = self.animationType;
    detailPage.flip = self.flip;
    
    
    switch (self.animationType) {
        case HP_CATransition_Animation_Option_PageCurl:{
            detailPage.animationType = HP_CATransition_Animation_Option_PageUnCurl;
        }break;
        case HP_CATransition_Animation_Option_PageUnCurl:{
            detailPage.animationType = HP_CATransition_Animation_Option_PageCurl;
        }break;
        default:
            break;
    }
     
    switch (self.flip) {
        case HP_CATransition_Animation_FlipPosition_Top:{detailPage.flip = HP_CATransition_Animation_FlipPosition_Bottom;}break;
        case HP_CATransition_Animation_FlipPosition_Bottom:{detailPage.flip = HP_CATransition_Animation_FlipPosition_Top;}break;
        case HP_CATransition_Animation_FlipPosition_Left:{detailPage.flip = HP_CATransition_Animation_FlipPosition_Right;}break;
        case HP_CATransition_Animation_FlipPosition_Right:{detailPage.flip = HP_CATransition_Animation_FlipPosition_Left;}break;
            break;
    }  
    
    
    
    [self presentViewController:detailPage animation:self.animationType flipPosition:self.flip completion:^{
        NSLog(@"present");
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
