//
//  PTImageTextTextCell.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextTextCell.h"
#import "SETextView.h"
#import "PTImageTextHelper.h"

@interface PTImageTextTextCell()

@property (nonatomic, strong) SETextView *textTextView;

@end

@implementation PTImageTextTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self loadTextTextView];
        
         self.backgroundColor = [PTImageTextHelper getBackgroundColor];
    }
    
    return self;
}

- (void)loadTextTextView
{
    
    _textTextView = [[SETextView alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width - 20, 100)];
    
    [PTImageTextHelper setDefaultPropertiesWithTextView:_textTextView];
    
    [self addSubview:_textTextView];
}

- (void)updateInfo:(NSDictionary *)info
{
    [_textTextView setAttributedText:[PTImageTextHelper attributedStringWithTextInfo:info]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _textTextView.frame = CGRectMake(10, 20, self.frame.size.width - 20, self.frame.size.height - 20);
}


@end
