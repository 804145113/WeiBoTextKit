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
    _weibo = weibo;
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
    // 1.解析话题
    NSString *mentionPattern = @"#([^\\#|.]+)#";
    NSRegularExpression *mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:nil];
    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

        if (result != nil) {
            NSString *subString = [text substringWithRange:result.range];
            NSDictionary *attributes = @{
                                         NSAttachmentAttributeName: subString,
                                         @"CustomDetectionType": @"Mention",
                                         };
            [attributedString addAttributes:attributes range:result.range];
        }
    }];

    // 2.解析@
    mentionPattern = @"@[\\u4e00-\\u9fa5\\w\\-]+";
    mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:nil];
    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

        if (result != nil) {
            NSString *subString = [text substringWithRange:result.range];
            NSDictionary *attributes = @{
                                         NSLinkAttributeName: subString,
                                         NSAttachmentAttributeName:subString
                                         };
            [attributedString addAttributes:attributes range:result.range];
        }
    }];

    // 3.解析http://短链接
    mentionPattern = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
    mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:nil];
    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {

        if (result != nil) {
            NSString *subString = [text substringWithRange:result.range];
            NSDictionary *attributes = @{
                                         NSLinkAttributeName: subString
                                         };
            [attributedString addAttributes:attributes range:result.range];
        }
    }];

    // 4.解析表情
    __block int number0 = 0;
    __block int number1 = 0;
    __block NSRange range = NSMakeRange(0, 0);
    mentionPattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\]";
    mentionExpression = [NSRegularExpression regularExpressionWithPattern:mentionPattern options:NSRegularExpressionCaseInsensitive error:nil];
    [mentionExpression enumerateMatchesInString:text options:NSMatchingReportProgress range:textRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        UIImage *image = nil;
        if (result != nil) {

            NSTextAttachment *imageAttachment = [NSTextAttachment new];

            //从文件包加载数据
            NSString *bundlePath=[[NSBundle mainBundle]pathForResource:@"Emoticons" ofType:@"bundle"];//获取bundle路径，我的bundle包名为image.bundle
            if ([bundlePath length]>0) {//判断路径是否获取成功
                //定义bundle,获取自定义包
                NSBundle *imageBundle=[NSBundle bundleWithPath:bundlePath];
                if (imageBundle!=nil) {
                    NSString *path=[imageBundle pathForResource:@"d_zuiyou" ofType:@"png"inDirectory:nil];
                    if ([path length]>0) {
//                       image =[UIImage imageWithContentsOfFile:path];
                        imageAttachment.bounds = CGRectMake(0, 0, 16, 16);
                        image = [UIImage imageNamed:@"d_aini"];
                        if (image!=nil) {
                            NSLog(@"从文件包中加载成功！");
                        }
                        else
                            NSLog(@"保存失败");
                    }
                    else
                        NSLog(@"路径不存在");
                }
                else
                    NSLog(@"bundle不存在");
            }


            image = [UIImage imageNamed:@"d_aini"];


            imageAttachment.image = image;
            imageAttachment.bounds = CGRectMake(0, 0, 13, 13);

            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:imageAttachment];


            if (range.length == 0) {
                range = result.range;
            }

            range.length = result.range.length;
            range.location = (result.range.location - number0) + number1;
            [attributedString deleteCharactersInRange:range];

            // 记录减去的字符
            number0 += result.range.length;

            [attributedString insertAttributedString:attachString atIndex:range.location];
            // 记录添加的表情字符每次一个
            number1 += attachString.length;



        }
    }];
    number1 = 0;
    number0 = 0;
    range = NSMakeRange(0, 0);
    return attributedString;
}

//链接委托
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    
    UITextView *textLabel = [self viewWithTag:102];
    NSAttributedString *detectionType = [textLabel.attributedText attribute:@"CustomDetectionType" atIndex:characterRange.location effectiveRange:nil];
    if([detectionType isEqual:@"Mention"]) {

    }

    return YES;
}

//附件委托
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return NO;
}

@end
