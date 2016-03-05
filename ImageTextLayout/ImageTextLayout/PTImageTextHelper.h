//
//  PTImageTextHelper.h
//  ImageTextLayout
//
//  Created by Peter on 16/3/5.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SETextView.h"

typedef NS_ENUM(NSUInteger, ImageTextType)
{
    ImageTextTypeTitle,
    ImageTextTypeText,
    ImageTextTypeImage,
};

@interface PTImageTextHelper : NSObject

+ (void)setDefaultPropertiesWithTextView:(SETextView *)textView;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title;

+ (NSAttributedString *)attributedStringWithTextInfo:(NSDictionary *)textInfo;

+ (CGFloat)heightOfTextCellWithTextInfo:(NSDictionary *)textInfo constraintWidth:(CGFloat)width;

+ (CGFloat)heightOfTextCellWithImageInfo:(NSDictionary *)imageInfo constraintWidth:(CGFloat)width;

+ (void)addTitle:(NSString *)title toArray:(NSMutableArray *)arr;

+ (void)addText:(NSString *)text userName:(NSString *)userName toArray:(NSMutableArray *)arr;

+ (void)addImage:(NSString *)imagePath aspectRatio:(CGFloat)ratio toArray:(NSMutableArray *)arr;


+ (UIColor *)getBackgroundColor;

+ (UIColor *)getTitleColor;

+ (UIColor *)getTextColor;

+ (UIColor *)getUserNameColor;

+ (UIColor *)getTitleLeftViewColor;

@end
