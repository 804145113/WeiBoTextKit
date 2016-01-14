//
//  MBProgressHUD+Loading.h
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Loading)

+ (instancetype)wbShowText:(NSString *)text inView:(UIView *)view;
+ (void)wbHideHudInView:(UIView *)view;
@end
