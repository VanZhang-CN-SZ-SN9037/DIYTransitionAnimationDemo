//
//  HPBaseView.h
//  HPPaaS_CommonUI
//
//  Created by VanZhang on 2021/9/8.
//

#import <UIKit/UIKit.h>
#import "HPBaseProtocol.h"

@interface HPBaseView : UIView<HPBaseViewProtocol>
@property (strong, nonatomic) id<HPBaseViewModelProtocol> viewModel;

@end
 
