//
//  HPBaseViewController+MicroServices.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+MicroServices.h"

@implementation HPBaseViewController (MicroServices)

- (BOOL)hp_checkUserSession {
    NSLog(@"%s",__func__);
    return NO;
}

- (void)hp_logout {
    NSLog(@"%s",__func__);
}

- (void)hp_relogin {
    NSLog(@"%s",__func__);
}

- (void)hp_start_phoneCall_withPhoneNumber:(NSString *)hp_number {
    //弹框提示，打完电话回到应用
    NSMutableString *str = [[NSMutableString alloc]initWithFormat:@"telprompt://%@",hp_number];
    NSURL *telUrl = [NSURL URLWithString:str];
    [self _openURL:telUrl];
}
- (void)_openURL:(NSURL*)url{
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:NULL];
        } else {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}
@end
