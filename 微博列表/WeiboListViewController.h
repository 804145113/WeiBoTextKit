//
//  ViewController.h
//  微博列表
//
//  Created by GXY on 16/1/13.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import <WBHttpRequest+WeiboUser.h>
#import <WBHttpRequest.h>
#import <UITableView+FDTemplateLayoutCell.h>

@interface WeiboListViewController : UITableViewController <WBHttpRequestDelegate>

@end

