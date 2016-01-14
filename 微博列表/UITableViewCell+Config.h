//
//  UITableViewCell+Config.h
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionView.h"
#import "WeiboModel.h"

#define PHOTOWEIDTH (CGRectGetWidth([UIScreen mainScreen].bounds) - 40)
#define PHOTOHEIGHT 120

@interface UITableViewCell (Config)

- (void)configData:(WeiboModel *)weibo;

@end
