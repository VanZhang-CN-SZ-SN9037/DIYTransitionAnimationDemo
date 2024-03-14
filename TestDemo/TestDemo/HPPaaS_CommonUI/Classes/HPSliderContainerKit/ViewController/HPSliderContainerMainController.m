//
//  HPSliderContainerMainController.m
//  HPSliderContainerKitDemo
//
//  Created by Mac on 2018/10/9.
//  Copyright © 2018 VanZhang. All rights reserved.
//

#import "HPSliderContainerMainController.h"

#import "HPSliderContainerTitleBanner.h"
#import "HPSliderPageContainer.h"
@interface HPSliderContainerMainController ()<HPSliderContainerTitleBannerProtocol,HPSliderPageContainerProtocol>
@property (weak, nonatomic) HPSliderContainerTitleBanner *titleBanner;
@property (weak, nonatomic) HPSliderPageContainer *container;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *childViewControllers;
@property (strong, nonatomic) NSArray *params;
@end
 

@implementation HPSliderContainerMainController
+(instancetype)initWithTitles:(NSArray *)titles childViewControllers:(NSArray *)childViewControllers{
    return [self initWithTitles:titles childViewControllers:childViewControllers childVcParams:nil];
}

+(instancetype)initWithTitles:(NSArray *)titles childViewControllers:(NSArray *)childViewControllers childVcParams:(NSArray *)params{
    HPSliderContainerMainController *ctrl = [[self alloc]init];
    ctrl.titles = [titles copy];
    ctrl.childViewControllers = [childViewControllers copy];
    ctrl.params = [params copy];
    [ctrl reloadAllPages];
    return ctrl;
}
-(void)loadView{
    [super loadView];
    HPSliderContainerTitleBanner *titleBanner = [HPSliderContainerTitleBanner bannerWithFrame:CGRectMake(0, 0, 300, 40)  delegate:self];
    self.navigationItem.titleView = titleBanner;
    
    
    HPSliderPageContainer *container = [HPSliderPageContainer containerWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64-44)  delegate:self];
    [self.view addSubview:container];
    
    self.titleBanner  = titleBanner;
    self.container = container;
    [self reloadAllPages];
}
- (void)reloadAllPages {
    for (UIViewController *childVc in self.childViewControllers) {
        [self addChildViewController:childVc];
    }
    [self.titleBanner reloadDataWithItems:self.titles];
    [self.container reloadDataWithSubViewDisplayVcInstance:self.childViewControllers withParams:self.params];
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)banner:(HPSliderContainerTitleBanner *)banner didSelectItemAtIndex:(NSInteger)index{
    if (self.container) {
         [self.container selectItemAtIndex:index];
    }
}
-(void)container:(HPSliderPageContainer *)container didScrollToItemAtIndex:(NSInteger)index{
    if (self.titleBanner) {
        [self.titleBanner selectItemAtIndex:index];
    }
}
 

@end
