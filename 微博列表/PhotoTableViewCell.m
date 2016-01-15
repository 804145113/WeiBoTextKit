//
//  PhotoTableViewCell.m
//  微博列表
//
//  Created by GXY on 16/1/15.
//  Copyright © 2016年 Tangxianhai. All rights reserved.
//

#import "PhotoTableViewCell.h"

@implementation PhotoTableViewCell
- (void)configData:(WeiboModel *)weibo {
    UITextView *textLabel = [self viewWithTag:102];
    textLabel.delegate = self;
    textLabel.attributedText = [self highlightText:weibo.weibo_text];

    NSLog(@"weibo_text:%@",weibo.weibo_text);

    PhotoCollectionView *collectView = [self viewWithTag:1011];
    collectView.delegate = collectView;
    collectView.dataSource = collectView;

    collectView.images_url = weibo.weibo_imageUrls;
}

- (NSAttributedString *)highlightText:(NSString *)text {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    NSRange textRange = NSMakeRange(0, text.length);

    NSString *mentionPattern = @"#[A-Za-z0-9_]+";


    NSRegularExpression *mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:nil];

    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

        if (result != nil) {
            NSString *subString = [text substringWithRange:result.range];
            NSDictionary *attributes = @{
                                         NSLinkAttributeName: subString,
                                         @"CustomDetectionType": @"Mention",
                                         };
            [attributedString addAttributes:attributes range:result.range];
        }

    }];
    
    return attributedString;
}
@end
