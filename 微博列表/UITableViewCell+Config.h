//
//  UITableViewCell+Config.h
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface UITableViewCell (Config)

- (void)configData:(WeiboModel *)weibo;

@end
