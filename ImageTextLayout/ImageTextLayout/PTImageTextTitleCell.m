//
//  PTImageTextTitleCell.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextTitleCell.h"
#import "SETextView.h"
#import "PTImageTextHelper.h"

@interface PTImageTextTitleCell()

@property (nonatomic, strong) SETextView *titleTextView;
@property (nonatomic, strong) UIView *leftView;

@end


@implementation PTImageTextTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self loadTitleTextView];
        
        self.backgroundColor = [PTImageTextHelper getBackgroundColor];
    }
    
    return self;
}

- (void)loadTitleTextView
{
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 3, 20)];
    _leftView.backgroundColor = [PTImageTextHelper getTitleLeftViewColor];
    [self addSubview:_leftView];
    
    _titleTextView = [[SETextView alloc] initWithFrame:CGRectMake(20, 30, 300, 20)];
    
    [PTImageTextHelper setDefaultPropertiesWithTextView:_titleTextView];
    
    _titleTextView.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self addSubview:_titleTextView];
}

- (void)updateInfo:(NSDictionary *)info
{
    NSString *title = info[@"title"];
    
    [_titleTextView setAttributedText:[PTImageTextHelper attributedStringWithTitle:title]];
    
}

@end
