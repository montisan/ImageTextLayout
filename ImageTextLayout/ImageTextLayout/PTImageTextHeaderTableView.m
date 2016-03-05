//
//  PTImageTextHeaderTableView.m
//  FontText
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextHeaderTableView.h"
#import "UIImage+ImageEffects.h"

@interface PTImageTextHeaderTableView()

@property (nonatomic, strong) UIView *headerContainer;
@property (nonatomic, strong, readwrite) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *bluredImageView;

@end


@implementation PTImageTextHeaderTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerHeight:(CGFloat)height
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self loadImageHeader:CGSizeMake(frame.size.width, height)];
    }
    
    return self;
}

- (void)loadImageHeader:(CGSize)size
{
    _headerContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:_headerContainer.bounds];
    _headerScrollView = scrollView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                            | UIViewAutoresizingFlexibleRightMargin
                            | UIViewAutoresizingFlexibleTopMargin
                            | UIViewAutoresizingFlexibleBottomMargin
                            | UIViewAutoresizingFlexibleHeight
                            | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView = imageView;
    [_headerScrollView addSubview:imageView];
    
    _bluredImageView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    _bluredImageView.autoresizingMask = self.imageView.autoresizingMask;
    _bluredImageView.alpha = 0.0f;
    [_headerScrollView addSubview:_bluredImageView];
    
    [_headerContainer addSubview:_headerScrollView];
    
    [self setTableHeaderView:_headerContainer];
    
}

- (void)layoutHeaderScrollViewForOffset:(CGPoint)offset
{
    CGRect frame = _headerScrollView.frame;
    
    if (offset.y > 0)
    {
        frame.origin.y = MAX(offset.y * 0.5f, 0);
        _headerScrollView.frame = frame;
        self.bluredImageView.alpha = 1 / _headerContainer.frame.size.height * offset.y * 1.2;
        _headerContainer.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = _headerContainer.frame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        _headerScrollView.frame = rect;
        _headerContainer.clipsToBounds = NO;
    }
}

- (void)setHeaderImage:(UIImage *)headerImage
{
    if (headerImage != nil)
    {
        _imageView.image = headerImage;
        _bluredImageView.image = [headerImage applyLightEffect];
    }
    
}

- (UIImage *)headerImage
{
    return _imageView.image;
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    [self layoutHeaderScrollViewForOffset:contentOffset];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated
{
    [super setContentOffset:contentOffset animated:animated];
    
    [self layoutHeaderScrollViewForOffset:contentOffset];
}

@end
