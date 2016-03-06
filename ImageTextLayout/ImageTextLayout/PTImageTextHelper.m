//
//  PTImageTextHelper.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/5.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextHelper.h"

@implementation PTImageTextHelper


+ (void)setDefaultPropertiesWithTextView:(SETextView *)textView
{
    [textView setBackgroundColor:[UIColor clearColor]];
    textView.textAlignment = NSTextAlignmentJustified;
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    textView.lineSpacing = 10;
    textView.paragraphSpacing = 20;
    textView.lineHeight = 0;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title
{
    
    UIFont *font = [UIFont fontWithName:@"PMingLiU" size:20];
    CTFontRef ctfont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    NSColor *textColor = [[self class] getTitleColor];
    
    NSDictionary *attributes = @{(id)kCTForegroundColorAttributeName: (id)textColor.CGColor, (id)kCTFontAttributeName: (__bridge id)ctfont};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title attributes:attributes];
    CFRelease(ctfont);
    
    
    return attributedString;
}

+ (NSAttributedString *)attributedStringWithTextInfo:(NSDictionary *)textInfo
{
    
    NSString *text = textInfo[@"text"];
    NSString *user = textInfo[@"user"];
    if (user.length > 0)
    {
        text = [NSString stringWithFormat:@"@%@ %@",user,text];
    }
    
    UIFont *font = [UIFont fontWithName:@"PMingLiU" size:15];
    CTFontRef ctfont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    
    NSColor *textColor = [[self class] getTextColor];
    NSColor *linkColor = [[self class] getUserNameColor];
    
    NSDictionary *attributes = @{(id)kCTForegroundColorAttributeName: (id)textColor.CGColor, (id)kCTFontAttributeName: (__bridge id)ctfont};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    CFRelease(ctfont);
    
    if (user.length > 0)
    {
        NSRange range = NSMakeRange(0, user.length + 1);
        [attributedString addAttributes:@{NSLinkAttributeName: [text substringWithRange:range], (id)kCTForegroundColorAttributeName: (id)linkColor.CGColor}
                                  range:range];
    }
    
    return attributedString;
}

+ (CGFloat)heightOfTextCellWithTextInfo:(NSDictionary *)textInfo constraintWidth:(CGFloat)width
{
    NSString *text = textInfo[@"text"];
    NSString *user = textInfo[@"user"];
    if (user.length > 0)
    {
        text = [NSString stringWithFormat:@"@%@ %@",user,text];
    }
    
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:text];;
    
    UIFont *font = [UIFont fontWithName:@"PMingLiU" size:15];
    CGRect frame = [SETextView frameRectWithAttributtedString:attributedString constraintSize:CGSizeMake(width, 1000) lineSpacing:10 paragraphSpacing:20 font:font];
    
    return frame.size.height + 20;
}

+ (CGFloat)heightOfTextCellWithImageInfo:(NSDictionary *)imageInfo constraintWidth:(CGFloat)width
{
    CGFloat radio = [imageInfo[@"ratio"] floatValue];
    
    return radio * width + 20;
}

+ (void)addTitle:(NSString *)title toArray:(NSMutableArray *)arr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = @(ImageTextTypeTitle);
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"title"] = title.length>0?title:@"";
    
    dic[@"info"] = info;
    
    [arr addObject:dic];
}

+ (void)addText:(NSString *)text userName:(NSString *)userName toArray:(NSMutableArray *)arr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = @(ImageTextTypeText);
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"text"] = text.length > 0 ? text : @"";
    info[@"user"] = userName.length > 0 ? userName : @"";
    
    dic[@"info"] = info;
    
    [arr addObject:dic];
}

+ (void)addImage:(NSString *)imagePath aspectRatio:(CGFloat)ratio toArray:(NSMutableArray *)arr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = @(ImageTextTypeImage);
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[@"image"] = imagePath.length > 0 ? imagePath : @"";
    info[@"ratio"] = @(ratio);
    
    dic[@"info"] = info;
    
    [arr addObject:dic];
}


+ (UIColor *)getBackgroundColor
{
    return [UIColor colorWithRed:235/255.0 green:240/255.0 blue:245/255.0 alpha:1.0];
}

+ (UIColor *)getTitleColor
{
    return [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0];
}

+ (UIColor *)getTextColor
{
    return [UIColor colorWithRed:73/255.0 green:73/255.0 blue:73/255.0 alpha:1.0];
}

+ (UIColor *)getUserNameColor
{
    return [UIColor colorWithRed:0/255.0 green:65/255.0 blue:131/255.0 alpha:1.0];
}

+ (UIColor *)getTitleLeftViewColor
{
    return [UIColor colorWithRed:27/255.0 green:156/255.0 blue:222/255.0 alpha:1.0];
}

@end
