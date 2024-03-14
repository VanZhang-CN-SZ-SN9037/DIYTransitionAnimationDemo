//
//  HPBaseViewController+MicroApplication.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+MicroApplication.h"

@implementation HPBaseViewController (MicroApplication)

- (void)hp_startApplication:(NSString *)name params:(NSDictionary *)params animated:(BOOL)animated completion:(HPStartAppComplectionHandlerBlock)completion {
    NSLog(@"%s",__func__);
}

- (void)hp_start_LoginRegister_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion {
    NSLog(@"%s",__func__);
}

- (void)hp_start_Main_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion {
    NSLog(@"%s",__func__);
}

- (void)hp_start_SimpleVerion_Main_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion {
    NSLog(@"%s",__func__);
}

@end
