//
//  WeiboModel.h
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, strong) NSString *weibo_text;
@property (nonatomic, strong) NSArray *weibo_imageUrls;

@end

@interface WeiboModel (Tools)

- (NSArray *)weibos:(NSDictionary *)dic;

@end
