//
//  DemoViewController.m
//  HybridShellProj
//
//  Created by VanZhang on 2021/8/17.
//



#import "DemoViewController.h"


//#import "HPDubheAdapterInterface.h"
//#import "HPContext.h"

//#import "HPMicroApplication.h"
#import "DemoCollectionViewController.h"

#import "HPCommonUIFactory.h"
#import "Masonry.h"
//#import "HPViewUtilities.h"

#import "UIBarButtonItem+HPCommonUI.h"
#import "UIViewController+HPTransitionAnimation.h"
#import "UINavigationController+HPTransitionAnimation.h"

#import "TestViewController.h"
@interface DemoViewController ()
//Desc:
@property (assign, nonatomic) NSInteger pageCurl_index;
@property (assign, nonatomic) NSInteger cube_index;
@property (assign, nonatomic) NSInteger OglFlip_index;
@property (assign, nonatomic) NSInteger MoveIn_index;
@property (assign, nonatomic) NSInteger Reveal_index;
@property (assign, nonatomic) NSInteger Push_index;
@property (assign, nonatomic) NSInteger Fragment_Show_index;
@property (assign, nonatomic) NSInteger Fragment_Hide_index;
@property (assign, nonatomic) NSInteger Spread_OneSide_index;



@end

@implementation DemoViewController



//===================================//

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageCurl_index = 0;
    self.cube_index = 0;
    self.OglFlip_index = 0;
    self.MoveIn_index = 0;
    self.Reveal_index = 0;
    self.Push_index = 0;
    self.Fragment_Show_index = 0;
    self.Fragment_Hide_index = 0;
    self.Spread_OneSide_index = 0;
    [self hp_setupUI];
}

- (void)test{
    __weak typeof(self)  weakSelf = self;
    HPPageTransitionAnimationOptions option = HPPageTransitionAnimationOption_Modal_PresentNextPageWithHalfFrame;
    TestViewController *testVc = [[TestViewController alloc]init];
    testVc.option = option;
    HPModalTransitionAnimatorParams *params = [[HPModalTransitionAnimatorParams alloc]init];
   
    [weakSelf presentViewController:testVc animationOption:option params:params completion:^{
        NSLog(@"hhh");
    }];
    
}
- (void)hp_setupUI{
    __weak typeof(self)  weakSelf = self; 
    
    NSString*filePath = [[NSBundle mainBundle]pathForResource:@"Demos" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *allItems = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSArray *allItems  = [NSArray arrayWithContentsOfFile:filePath];
 
    UITableView *tableView = [HPCommonUIFactory tableViewWithSuperView:self.view  datasource:^(HPTableView *tableView, HPDataSource *dataSource) {
        //1.Registe Class
        NSMutableArray *ClassList  = [NSMutableArray array];
        [ClassList addObject:[HPTableViewCell class]];
        [ClassList addObject:[HPTableViewHeaderFooterView class]];
        for (Class cellClass in ClassList) {
            BOOL isTbClass  = [cellClass isSubclassOfClass:[UITableViewCell class]];
            BOOL isTbHeaderFooterClass  = [cellClass isSubclassOfClass:[UITableViewHeaderFooterView class]];
            if (isTbClass||isTbHeaderFooterClass) {
                dataSource.registTableViewCellWithClass(cellClass,tableView);
            }
        }

        //2.Set section row
        [dataSource tb_SetNumberOfSections:^NSUInteger(UITableView *tableView) {
            return allItems.count;
        } setNumberOfRows:^NSUInteger(UITableView *tableView, NSUInteger section) {
            NSArray *sectionItems = [allItems objectAtIndex:section];
            return sectionItems.count;
        } setCellForRow:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HPTableViewCell  hp_reuseIdentifier]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256)/255.0) alpha:1.0];
            NSArray *sectionItems = [allItems objectAtIndex:indexPath.section];
            NSDictionary *item = sectionItems[indexPath.row];
            NSString *title = item[@"title"];
            if([item[@"title"] isKindOfClass:[NSArray class]]){
                title = [(NSArray*)item[@"title"] objectAtIndex:self.pageCurl_index];
                if ([title containsString:@"PageCurl"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.pageCurl_index];
                }else if ([title containsString:@"Cube"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.cube_index];
                }else if ([title containsString:@"OglFlip"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.OglFlip_index];
                }else if ([title containsString:@"MoveIn"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.MoveIn_index];
                }else if ([title containsString:@"Reveal"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.Reveal_index];
                }else if ([title containsString:@"Push"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.Push_index];
                }else if ([title containsString:@"Fragment_Show"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.Fragment_Show_index];
                }else if ([title containsString:@"Fragment_Hide"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.Fragment_Hide_index];
                }else if ([title containsString:@"Spread_OneSide"]) {
                    title = [(NSArray*)item[@"title"] objectAtIndex:self.Spread_OneSide_index];
                }
            }
            cell.textLabel.text = title;
            return cell;
        }];
    } delegate:^(HPTableView *tableView, HPDelegate *delegate) {
        [delegate tb_SetHeightForHeader:^CGFloat(UITableView *tableView, NSUInteger section) {
            return 50;
        } SetHeightForFooter:NULL SetHeightForRow:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            CGFloat rowHeight = 50;
            return rowHeight;
        }];
        [delegate tb_SetViewForHeader:^UIView *(UITableView *tableView, NSUInteger section) {
            NSArray *sectionItems = [allItems objectAtIndex:section];
            NSDictionary *item = sectionItems[0];
            NSString *sectionTitle = item[@"sectionTitle"];
            HPTableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[HPTableViewHeaderFooterView hp_reuseIdentifier]];
            header.textLabel.text = sectionTitle;
            return header;
        } SetViewForFooter:NULL];
        [delegate tb_SetSelectResponseForRow:^(UITableView *tableView, NSIndexPath *indexPath) {
            NSArray *sectionItems = [allItems objectAtIndex:indexPath.section];
            NSDictionary *item = sectionItems[indexPath.row];
            NSString *title = item[@"title"];
            NSInteger flip = self.pageCurl_index;
            if([title isKindOfClass:[NSArray class]]){
                title = [(NSArray*)title objectAtIndex:self.pageCurl_index];
                if ([title containsString:@"PageCurl"]) {
                    flip = self.pageCurl_index;
                    if (self.pageCurl_index<3) {
                        self.pageCurl_index +=1;
                    }else{
                        self.pageCurl_index = 0;
                    }
                }else if ([title containsString:@"Cube"]) {
                    flip = self.cube_index;
                    if (self.cube_index<3) {
                        self.cube_index +=1;
                    }else{
                        self.cube_index = 0;
                    }
                }else if ([title containsString:@"OglFlip"]) {
                    flip = self.OglFlip_index;
                    if (self.OglFlip_index<3) {
                        self.OglFlip_index +=1;
                    }else{
                        self.OglFlip_index = 0;
                    }
                }else if ([title containsString:@"MoveIn"]) {
                    flip = self.MoveIn_index;
                    if (self.MoveIn_index<3) {
                        self.MoveIn_index +=1;
                    }else{
                        self.MoveIn_index = 0;
                    }
                }else if ([title containsString:@"Reveal"]) {
                    flip = self.Reveal_index;
                    if (self.Reveal_index<3) {
                        self.Reveal_index +=1;
                    }else{
                        self.Reveal_index = 0;
                    }
                }else if ([title containsString:@"Push"]) {
                    flip = self.Push_index;
                    if (self.Push_index<3) {
                        self.Push_index +=1;
                    }else{
                        self.Push_index = 0;
                    }
                }else if ([title containsString:@"Fragment_Show"]) {
                    flip = self.Fragment_Show_index;
                    if (self.Fragment_Show_index<3) {
                        self.Fragment_Show_index +=1;
                    }else{
                        self.Fragment_Show_index = 0;
                    }
                }else if ([title containsString:@"Fragment_Hide"]) {
                    flip = self.Fragment_Hide_index;
                    if (self.Fragment_Hide_index<3) {
                        self.Fragment_Hide_index +=1;
                    }else{
                        self.Fragment_Hide_index = 0;
                    }
                }else if ([title containsString:@"Spread_OneSide"]) {
                    flip = self.Spread_OneSide_index;
                    if (self.Spread_OneSide_index<3) {
                        self.Spread_OneSide_index +=1;
                    }else{
                        self.Spread_OneSide_index = 0;
                    }
                }
            }
            NSString *viewControllerClassName = item[@"viewController"];
            NSString *impFunction = item[@"impFunction"];
            if (viewControllerClassName.length>0) {
                Class vcClass = NSClassFromString(viewControllerClassName);
                UIViewController *colVc = [[vcClass alloc]init];
                [weakSelf.navigationController pushViewController:colVc animated:YES];
                if ([viewControllerClassName isEqualToString:@"ModalDemoViewController"]) {
                    [colVc setValue:@(indexPath.row) forKey:@"animationType"];
                    [colVc setValue:@(flip) forKey:@"flip"];
                }else   if ([viewControllerClassName isEqualToString:@"PushPopViewController"]) {
                    [colVc setValue:@(indexPath.row) forKey:@"animationType"];
                    [colVc setValue:@(indexPath.row) forKey:@"animationType"];
                    [colVc setValue:@(flip) forKey:@"flip"];
                }else   if ([viewControllerClassName isEqualToString:@"DemoCollectionViewController"]) {
                  
                    [colVc setValue:@([title containsString:@"Modal"]) forKey:@"isModal"];
                    [colVc setValue:@(indexPath.row) forKey:@"animationType"];
                    [colVc setValue:@(flip) forKey:@"startPosition"];
                    HPModalTransitionAnimatorParams *params = [[HPModalTransitionAnimatorParams alloc]init];
                   
                    [colVc setValue:params forKey:@"params"];
                     
                }else   if ([viewControllerClassName isEqualToString:@"ModalViewController"]) {
                    [colVc setValue:@(indexPath.row) forKey:@"option"]; 
                    HPModalTransitionAnimatorParams *params = [[HPModalTransitionAnimatorParams alloc]init];
                
                    [colVc setValue:params forKey:@"params"];
                } else if([viewControllerClassName isEqualToString:@"VCTransitionDemoViewController"]){
                    [colVc setValue:@(indexPath.row) forKey:@"options"];
                }
            }else if (impFunction.length>0){
                SEL sel = NSSelectorFromString(impFunction);
                if ([self respondsToSelector:sel]) {
                    [self performSelector:sel];
                }
            }
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }didSelectForRow:NULL];
        [delegate SetDidScroll:NULL];
    }];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.offset([UIView hp_navigationBar_Height]);
    }];
}
//-(void)startApps{
//    HPMicroApplication *currApp = [HPContextGet() currentApplication];
//////    NSUInteger count = [HPContextGet() findApplicationsByName:@"Launcher"].count;
//////    if (count>=10) {
//////        [HPContextGet() exitAllApplications];
//////    }else{
//        if ([currApp.descriptor.name isEqualToString:@"LoginRegisterLauncher"]) {
//    //        [[HPDubheAdapterInterface shareInstance]startH5ViewControllerWithParams:@{@"url":@"https://www.baidu.com"}];
////            [HPContextGet() startApplication:@"Launcher" params:@{@"key1":@"value1"} animated:YES];
//
//            [HPContextGet() startApplication:@"Launcher" params:@{@"key1":@"value1"} launchMode:kHPMicroApplicationLaunchModeFlipFromLeft];
//        }else if ([currApp.descriptor.name isEqualToString:@"Launcher"]){
//            HPMicroApplication *app = [HPContextGet() findApplicationByName:@"LoginRegisterLauncher"];
//            if (app) {
//                Class rootVcClass =  NSClassFromString(@"HPSTabBarController");
//                if (![app.rootController isKindOfClass:rootVcClass]) {
//                    UIViewController * rootPage = [[rootVcClass alloc]init];
//                    [HPContextGet() setViewControllers:@[rootPage] forApplicationObject:app animated:YES];
//                }else{
////                    [HPContextGet() startApplication:@"LoginRegisterLauncher" params:@{@"key1":@"value1"} animated:YES];
//                    [HPContextGet() startApplication:@"LoginRegisterLauncher" params:@{@"key1":@"value1"} launchMode:kHPMicroApplicationLaunchModeFlipFromRight];
//                }
//            }else{
////                [HPContextGet() startApplication:@"LoginRegister" params:@{@"key1":@"value1"} animated:YES];
//                [HPContextGet() startApplication:@"LoginRegisterLauncher" params:nil launchMode:kHPMicroApplicationLaunchModeFlipFromRight];
//            }
//        }
////    }
//
//   
//}
//- (void)getCurrentAppVcs{
//        NSUInteger count = HPContextGet().currentApplication.viewControllers.count;
//    //    [self.navigationController pushViewController:vc animated:YES];
//        if (count<=5) {
//            DemoViewController *vc = [[DemoViewController alloc]init];
//            if (self.navigationController) {
//                [self.navigationController presentViewController:vc animated:YES completion:^{
//                    NSLog(@"viewControllers:%@",HPContextGet().currentApplication.viewControllers);
//                }];
//            }else{
//                [self presentViewController:vc animated:YES completion:^{
//                    NSLog(@"viewControllers:%@",HPContextGet().currentApplication.viewControllers);
//                }];
//            }
//        }else{
//            if (self.navigationController) {
//                [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                    NSLog(@"viewControllers:%@",HPContextGet().currentApplication.viewControllers);
//                }];
//            }else{
//                [self dismissViewControllerAnimated:YES completion:^{
//                    NSLog(@"viewControllers:%@",HPContextGet().currentApplication.viewControllers);
//                }];
//            }
//        }
//}

@end
