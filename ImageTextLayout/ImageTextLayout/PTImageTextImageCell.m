//
//  PTImageTextImageCell.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextImageCell.h"
#import "PTImageTextHelper.h"

@interface PTImageTextImageCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation PTImageTextImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self loadImageView];
        
         self.backgroundColor = [PTImageTextHelper getBackgroundColor];
    }
    
    return self;
}

- (void)loadImageView
{
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height - 20)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    
    [self addSubview:_imgView];
}

- (void)updateInfo:(NSDictionary *)info
{
    NSString *imagePath = info[@"image"];
    
    _imgView.image = [UIImage imageNamed:imagePath];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(10, 20, self.frame.size.width - 20, self.frame.size.height - 20);
}

@end
