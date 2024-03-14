//
//  HPBaseViewController+HUD.m
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/9.
//

#import "HPBaseViewController+HUD.h"
#import "HPHUDUtilities.h"
#import "HPEmptyPlaceholder.h"

@implementation HPBaseViewController (HUD)
- (void)hp_setEmptyViewClickHandler:(HPEmptyClickHandler)clickHandler{
    [self.view configReloadAction:clickHandler];
}


- (void)hp_hideEmptyView {
    [self.view hideErrorPageView];
}

- (void)hp_showEmptyViewWithType:(HP_EmptyType)emptyType {
//    HP_EmptyType_DataError = 0,//数据缺失
//    HP_EmptyType_ErrorNetWork = 1,//网络错误
//    HP_EmptyType_ServicesIsDeveloping = 2,//业务开发中
//    HP_EmptyType_BusinessError = 3//业务错误
    switch (emptyType) {
        case HP_EmptyType_DataError:{
            [self.view showErrorPageViewWithType:HPEmpty_DefaultType];
        }break;
        case HP_EmptyType_ErrorNetWork:{
            [self.view showErrorPageViewWithType:HPEmpty_ErrorNetWorkType];
        }break;
        case HP_EmptyType_ServicesIsDeveloping:{
            [self.view showErrorPageViewWithType:HPEmpty_DefaultType];
        }break;
        case HP_EmptyType_BusinessError:{
            [self.view showErrorPageViewWithType:HPEmpty_DefaultType];
        }break;
        default:
            break;
    }
}


- (void)hp_showLoading {
    [self.view showLoadingView];
}
- (void)hp_hideLoading {
    [self.view hideLoadingView];
}

- (void)hp_showToast:(id)toast {
    __weak typeof(self)  weakSelf = self;
    NSString *tipMsg = toast;
    if ([tipMsg isKindOfClass:[NSError class]]) {
        tipMsg = [(NSError*)toast description];
    }else if (![tipMsg isKindOfClass:[ NSString class]]){
        tipMsg = [NSString stringWithFormat:@"%@",tipMsg];
    }
    [SVProgressHUD showInfoWithStatus:tipMsg];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hp_dissmissHud];
    });
}


#pragma mark-SVProgressHUD
- (void)hp_showSuccess:(id)success {
    __weak typeof(self)  weakSelf = self;
    NSString *tipMsg = success;
    if ([tipMsg isKindOfClass:[NSError class]]) {
        tipMsg = [(NSError*)success description];
    }else if (![tipMsg isKindOfClass:[ NSString class]]){
        tipMsg = [NSString stringWithFormat:@"%@",tipMsg];
    }
    [SVProgressHUD showSuccessWithStatus:tipMsg];
 
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hp_dissmissHud];
    });
}

- (void)hp_showError:(id)err {
    __weak typeof(self)  weakSelf = self;
    NSString *tipMsg = err;
    if ([tipMsg isKindOfClass:[NSError class]]) {
        tipMsg = [(NSError*)err description];
    }else if (![tipMsg isKindOfClass:[ NSString class]]){
        tipMsg = [NSString stringWithFormat:@"%@",tipMsg];
    }
    [SVProgressHUD showErrorWithStatus:tipMsg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hp_dissmissHud];
    });
}

- (void)hp_dissmissHud {
    [SVProgressHUD dismiss];
}
@end
