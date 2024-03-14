//
//  AppDelegate.m
//  TestDemo
//
//  Created by Van Zhang on 2024/3/10.
//

#import "AppDelegate.h"
#import "DemoViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
//- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
//    NSLog(@"--- %s ---",__func__);//__func__打印方法名
//    return YES;
//}
//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window setRootViewController:[[UINavigationController alloc]initWithRootViewController:[[DemoViewController alloc]init]]];
    [_window makeKeyAndVisible];
    return YES;
}
//
//- (void)applicationWillResignActive:(UIApplication *)application {
//    NSLog(@"--- %s ---",__func__);
//}
//
//
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//  NSLog(@"--- %s ---",__func__);
//}
//
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    NSLog(@"--- %s ---",__func__);
//}
//
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"--- %s ---",__func__);
//}
//
//
//- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
//    NSLog(@"--- %s ---",__func__);
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//   NSLog(@"--- %s ---",__func__);
//}
@end
