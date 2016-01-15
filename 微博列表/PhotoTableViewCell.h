//
//  PhotoTableViewCell.h
//  微博列表
//
//  Created by GXY on 16/1/15.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "PhotoCollectionView.h"

@interface PhotoTableViewCell : UITableViewCell
- (void)configData:(WeiboModel *)weibo;
@end
