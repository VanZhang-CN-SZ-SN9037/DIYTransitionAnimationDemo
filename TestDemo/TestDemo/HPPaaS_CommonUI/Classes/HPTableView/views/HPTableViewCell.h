//
//  HPTableViewCell.h
//  HPCommonUI
//
//  Created by VanZhang on 2020/11/26.
//

#import <UIKit/UIKit.h>

#pragma mark-单元格重用标识、加载Xib
@protocol HPCommonUIProtocol <NSObject>
@optional
+ (UINib *)hp_nib ;
+ (NSString *)hp_reuseIdentifier ;
@end


@interface HPTableViewCell : UITableViewCell<HPCommonUIProtocol>

@end
 
@interface HPTableViewHeaderFooterView : UITableViewHeaderFooterView<HPCommonUIProtocol>

@end
