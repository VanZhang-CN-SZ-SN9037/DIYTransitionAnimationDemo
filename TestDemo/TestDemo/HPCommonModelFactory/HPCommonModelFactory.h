//
//  HPCommonModelFactory.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/27.
//  Copyright © 2020 NebulaSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDelegate.h"
#import "HPDataSource.h"

@interface HPCommonModelFactory : NSObject

+ (HPDelegate*)delegate;

+ (HPDataSource*)datasource;

@end
 


