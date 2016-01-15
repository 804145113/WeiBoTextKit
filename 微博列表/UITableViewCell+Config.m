//
//  UITableViewCell+Config.m
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "UITableViewCell+Config.h"

@implementation UITableViewCell (Config)
- (void)configData:(WeiboModel *)weibo {
    UILabel *textLabel = [self viewWithTag:102];
    textLabel.text = weibo.weibo_text;

    NSLog(@"weibo_text:%@",weibo.weibo_text);

    PhotoCollectionView *collectView = [self viewWithTag:1011];
    collectView.delegate = collectView;
    collectView.dataSource = collectView;

    collectView.images_url = weibo.weibo_imageUrls;
}

@end
