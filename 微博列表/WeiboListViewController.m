//
//  ViewController.m
//  微博列表
//
//  Created by GXY on 16/1/13.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

// https://api.weibo.com/2/statuses/public_timeline.json 获取最新公共微博
// https://api.weibo.com/oauth2/authorize

#define tAppKey @"2930554585"
#define tAppSecret @"3b8147ac12b7b33a43dd66c9dc04321b"
#define tCode @"5190d0d09126ca62529ba49dc9da79c9"

#import "WeiboListViewController.h"
#import "MBProgressHUD+Loading.h"
#import "PhotoTableViewCell.h"
#import "WeiboModel.h"
#import "ReactViewController.h"

@interface WeiboListViewController ()
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSArray *weibos;
@property (nonatomic, strong) UITableViewCell *prototypeCell;
@end

@implementation WeiboListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"微博信息";
    // https://api.weibo.com/oauth2/authorize?client_id=2930554585&redirect_uri=https://github.com/804145113 浏览器里面打开获取 authorization code 更新 tCode 值

    // https://api.weibo.com/2/statuses/public_timeline.json?access_token=2.00RFRlhF8H_1MD376daaed7d4Xk1UB&count=100 获取微博信息浏览器打开

    [self addHeaderRefresh];
    [MBProgressHUD wbShowText:@"载入中" inView:self.tableView];
    [self pullRefresh];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showRnView)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)showRnView {
    // Override point for customization after application launch.

    ReactViewController *rtVc = [[ReactViewController alloc] init];

    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://192.168.2.7:8081/ReactComponent/index.ios.bundle?platform=ios&dev=true"];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"SimpleApp"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    rtVc.view.backgroundColor = [UIColor whiteColor];
    rootView.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    [rtVc.view addSubview:rootView];
    [self.navigationController pushViewController:rtVc animated:YES];
}

- (void)addHeaderRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(pullRefresh) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - 微博返回数据代理方法
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result {
    if ([request.tag isEqualToString:@"101"]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        WeiboModel *model = [[WeiboModel alloc] init];
        self.weibos = [model weibos:dic];
        [MBProgressHUD wbHideHudInView:self.view];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell2"];
    WeiboModel *weibo = [self.weibos objectAtIndex:indexPath.row];
    [cell configData:weibo];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weibos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeiboModel *weibo = [self.weibos objectAtIndex:indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:@"weiboCell2" configuration:^(PhotoTableViewCell *cell) {
        [cell configData:weibo];
    }];
}

- (void)pullRefresh {
        // 1.登录Weibo获取授权
        [WBHttpRequest requestWithURL:@"https://api.weibo.com/oauth2/access_token" httpMethod:@"POST"
                               params:@{
                                        @"client_id":tAppKey,
                                        @"client_secret":tAppSecret,
                                        @"grant_type":@"authorization_code",
                                        @"code":tCode,
                                        @"redirect_uri":@"https://github.com/804145113",
                                        }
                                queue:[NSOperationQueue currentQueue]
                withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
                    NSLog(@"result:%@ == > ERROR:%@",result,[error description]);
                    self.wbtoken = [result objectForKey:@"access_token"];
                    self.wbtoken = @"2.00RFRlhF8H_1MD376daaed7d4Xk1UB";
                    if (self.wbtoken != nil) {
                        // 2.获取公共微博信息
                        [WBHttpRequest requestWithAccessToken:@"2.00RFRlhF8H_1MD376daaed7d4Xk1UB" url:@"https://api.weibo.com/2/statuses/public_timeline.json" httpMethod:@"GET" params:@{@"count":@"20"} delegate:self withTag:@"101"];
                    }
                }];
}

@end
