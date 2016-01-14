//
//  MBProgressHUD+Loading.m
//  微博列表
//
//  Created by GXY on 16/1/14.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "MBProgressHUD+Loading.h"

@implementation MBProgressHUD (Loading)
+ (instancetype)wbShowText:(NSString *)text inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    return hud;
}

+ (void)wbHideHudInView:(UIView *)view {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
}

@end
