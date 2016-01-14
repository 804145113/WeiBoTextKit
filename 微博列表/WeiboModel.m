//
//  WeiboModel.m
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [[WeiboModel alloc] init];
    if (self) {
        self.weibo_text = [dic objectForKey:@"text"];
        self.weibo_imageUrls = [dic objectForKey:@"pic_urls"];
    }
    return self;
}

@end

@implementation WeiboModel (Tools)

- (NSArray *)weibos:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray new];

    for (NSDictionary *msgDic in [dic objectForKey:@"statuses"]) {
        WeiboModel *wModel = [self initWithDictionary:msgDic];
        [array addObject:wModel];
    }

    return array;
}

@end
