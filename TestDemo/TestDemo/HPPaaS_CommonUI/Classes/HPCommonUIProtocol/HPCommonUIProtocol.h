//
//  HPCommonUIProtocol.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <UIKit/UIKit.h>
   

typedef void(^HPCommonHandlerBlock)(void);
#pragma mark-HUD协议
typedef NS_ENUM(NSUInteger,HP_EmptyType) {
    HP_EmptyType_DataError = 0,//数据缺失
    HP_EmptyType_ErrorNetWork = 1,//网络错误
    HP_EmptyType_ServicesIsDeveloping = 2,//业务开发中
    HP_EmptyType_BusinessError = 3//业务错误
};
typedef HPCommonHandlerBlock HPEmptyClickHandler;
@protocol HPHUDProtocol <NSObject>
/*1.LoadingView和空数据视图显示隐藏*/
//显示Loading
- (void)hp_showLoading;
//隐藏Loading
- (void)hp_hideLoading;
//显示空数据视图
- (void)hp_showEmptyViewWithType:(HP_EmptyType)emptyType;
//隐藏空数据视图
- (void)hp_hideEmptyView;
//设置点击空数据视图
- (void)hp_setEmptyViewClickHandler:(HPEmptyClickHandler)clickHandler;

/*2.toast提示(只文字)hp_*/
//SVProgressHUD
- (void)hp_showToast:(id)toast;
- (void)hp_showSuccess:(id)success;
- (void)hp_showError:(id )err;
- (void)hp_dissmissHud;
@end
 

#pragma mark-单元格重用标识、加载Xib
@protocol HPCommonUIProtocol <NSObject>
@optional
+ (UINib *)hp_nib ;
+ (NSString *)hp_reuseIdentifier ;
@end






#pragma mark-开启H5页面
@class HPH5WebViewController;
typedef BOOL(^HPWebViewCtrlPerformHandler)(HPH5WebViewController*weakWebCtrl,NSURL *url,NSString *methondName, NSDictionary *params);
@protocol HPStartWebViewProtocol<NSObject>
- (HPH5WebViewController*)hp_startWebPage_with_url:(NSString *)url andTitle:(NSString *)title;
- (HPH5WebViewController*)hp_startWebPage_with_url:(NSString *)url andTitle:(NSString *)title interceptWithURLScheme:(NSString*)interceptScheme performHandler:(HPWebViewCtrlPerformHandler)interceptHandle;
- (HPH5WebViewController*)hp_startWebPage_with_HTMLTextContent:(NSString *)content andTitle:(NSString *)title;
@end




 
typedef HPCommonHandlerBlock HPComplectionHandlerBlock;

#pragma mark-页面导航-导航栏处理
@protocol HPNavigationCtrlProtocol <NSObject>
/*导航栏按钮设置*/
/*1.隐藏导航栏，基类默认显示导航栏*/
- (void)hp_hideNavBar;
- (void)hp_showNavBar;
- (void)hp_cleanNavBar;





#pragma mark 界面切换
- (void)hp_popWithAnimated:(BOOL)animated;
//不需要传参数的push 只需告诉类名字符串
- (void)hp_pushViewController:(UIViewController*)controller;
- (void)hp_pushOrModalToNextPage:(UIViewController*)nextPage;
- (void)hp_popOrDissmissToLastPage;
//回到当前模块导航下的某一个页面
- (void)hp_returnToViewControllerWithClass:(Class)targetVcClass;
//切到指定模块下
- (void)hp_popToHomePageWithTabIndex:(NSInteger)index completion:(HPComplectionHandlerBlock)completion;
- (void)hp_setupBackItemWithTitle:(NSString*)title forViewController:(UIViewController*)vc backHandle:(HPComplectionHandlerBlock)backBlock;

@end

typedef void(^HPStartAppComplectionHandlerBlock)(BOOL success);
// 转变成微应用切换「微服务,只提供功能,没有UI交互界面」、「微应用,提供UI交互页面的独立功能模块」
@protocol HPStartMicroApplicationProtocol <NSObject>
// 登录注册模块
- (void)hp_start_LoginRegister_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion;
// 默认版本
- (void)hp_start_Main_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion;
// 简约版
- (void)hp_start_SimpleVerion_Main_App_withcompletion:(HPStartAppComplectionHandlerBlock)completion;


/**
 * 根据指定的名称启动一个应用。
 *
 * @param name 要启动的应用名。
 * @param params 应动应用时，需要转递给另一个应用的参数。
 * @param animated 指定启动应用时，是否显示动画。
 * @param completion 指定启动应用完成后的回调 ,应用启动成功返回YES，否则返回NO
 *
 */
// 其它扩展服务
- (void)hp_startApplication:(NSString *)name params:(NSDictionary *)params animated:(BOOL)animated completion:(HPStartAppComplectionHandlerBlock)completion;

 
@end

@protocol HPStartMicroServicesProtocol <NSObject>
 
- (void)hp_logout;
- (void)hp_relogin;
// 查验用户登录session{会话是否过期}
- (BOOL)hp_checkUserSession;
/*拨打电话*/
- (void)hp_start_phoneCall_withPhoneNumber:(NSString *)hp_number;

@end

 


@class MJRefreshNormalHeader;
@class MJRefreshBackNormalFooter;
@class MJRefreshAutoNormalFooter;

@protocol HPLocalizedStringForRefreshProtocol <NSObject>

#pragma mark - MJRefresh国际化处理
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header;
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer;
- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer;


@end
