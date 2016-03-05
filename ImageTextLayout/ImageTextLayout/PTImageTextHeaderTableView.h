//
//  PTImageTextHeaderTableView.h
//  FontText
//
//  Created by Peter on 16/3/3.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTImageTextHeaderTableView : UITableView

@property (nonatomic, strong, readonly) UIScrollView *headerScrollView;

@property (nonatomic, strong) UIImage *headerImage;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerHeight:(CGFloat)height;

@end
