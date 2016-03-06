//
//  PTImageTextHeaderTableView.m
//  FontText
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextHeaderTableView.h"
#import "UIImage+ImageEffects.h"


#define kHeaderImageHiddenHeight    50
#define kYScaleRatio 0.5f


@interface PTImageTextHeaderTableView()

@property (nonatomic, strong) UIView *headerContainer;
@property (nonatomic, strong, readwrite) UIView *headerScaleView;
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
    _headerScaleView = [[UIView alloc] initWithFrame:_headerContainer.bounds];
    _headerScaleView.clipsToBounds = YES;
    
    CGRect frame = _headerContainer.bounds;
    frame.size.height += kHeaderImageHiddenHeight;
    _imageView = [[UIImageView alloc] initWithFrame:frame];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleWidth;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerScaleView addSubview:_imageView];
    
    
    _bluredImageView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
    _bluredImageView.autoresizingMask = self.imageView.autoresizingMask;
    _bluredImageView.alpha = 0.0f;
    _bluredImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerScaleView addSubview:_bluredImageView];
    [_headerContainer addSubview:_headerScaleView];
    
    [self setTableHeaderView:_headerContainer];
    
}

- (void)layoutHeaderScrollViewForOffset:(CGPoint)offset
{
    CGRect frame = _headerContainer.frame;
    
    if (offset.y > 1)
    {
        frame.origin.y = MAX(offset.y * kYScaleRatio, 0);
        _headerScaleView.frame = frame;
        self.bluredImageView.alpha = MIN(offset.y / (_headerContainer.frame.size.height - 64 + self.frame.origin.y),1.0f);
        _headerContainer.clipsToBounds = YES;
    }
    else
    {
        self.bluredImageView.alpha = 0.0;
        CGFloat delta = 0.0f;
        CGRect rect = _headerContainer.frame;
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += (delta * 1);
        _headerScaleView.frame = rect;
        _headerContainer.clipsToBounds = NO;
        
        
        frame.size.height += (kHeaderImageHiddenHeight + delta * kYScaleRatio);
        
        if (rect.size.height > frame.size.height)
        {
            frame.size.height = rect.size.height;
        }
        
        _imageView.frame = frame;
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

- (UIImage *)generateNavigationBarImage
{
    
    CGFloat alpha = _bluredImageView.alpha;
    
    
    _bluredImageView.alpha = 1.0;
    
    UIGraphicsBeginImageContext(_bluredImageView.bounds.size);
    [_bluredImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect rect = CGRectMake(0, _headerContainer.frame.size.height - 64 - (_headerContainer.frame.size.height - 64 + self.frame.origin.y)*kYScaleRatio, _bluredImageView.frame.size.width, 64);
    
    UIImage *navImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, rect)];
    
    _bluredImageView.alpha = alpha;
    
    return navImage;
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
