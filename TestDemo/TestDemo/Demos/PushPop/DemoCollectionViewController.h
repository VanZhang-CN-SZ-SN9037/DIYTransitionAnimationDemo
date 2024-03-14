//
//  DemoCollectionViewController.h
//  DemoTransitions
//
//  Created by Chris Hu on 16/7/18.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoCollectionViewController : UIViewController
@property (assign, nonatomic) NSInteger animationType;
@property (assign, nonatomic) NSInteger startPosition;

@property (strong, nonatomic) id params;
@property (assign, nonatomic) NSInteger isModal;
@end
