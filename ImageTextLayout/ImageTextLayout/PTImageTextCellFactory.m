//
//  PTImageTextCellFactory.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/5.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "PTImageTextCellFactory.h"

#import "PTImageTextTitleCell.h"
#import "PTImageTextTextCell.h"
#import "PTImageTextImageCell.h"

@implementation PTImageTextCellFactory

+ (UITableViewCell<PTImageTextCellProtocol> *)cellWithTableView:(UITableView *)tableView type:(ImageTextType)type
{
    UITableViewCell<PTImageTextCellProtocol> *cell = nil;
    
    switch (type)
    {
        case ImageTextTypeTitle:
            cell = [[self class] titleCellWithTableView:tableView];
            break;
            
        case ImageTextTypeText:
            cell = [[self class] textCellWithTableView:tableView];
            break;
            
        case ImageTextTypeImage:
            cell = [[self class] imageCellWithTableView:tableView];
            break;
    
    }
    
    
    return cell;
}




+ (UITableViewCell<PTImageTextCellProtocol> *)titleCellWithTableView:(UITableView *)tableView
{
    static NSString *titleCellIdentifier = @"titleCellIdentifier";
    
    UITableViewCell<PTImageTextCellProtocol> *cell = (UITableViewCell<PTImageTextCellProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:titleCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PTImageTextTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

+ (UITableViewCell<PTImageTextCellProtocol> *)textCellWithTableView:(UITableView *)tableView
{
    static NSString *textCellIdentifier = @"textCellIdentifier";
    
    UITableViewCell<PTImageTextCellProtocol> *cell = (UITableViewCell<PTImageTextCellProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:textCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PTImageTextTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

+ (UITableViewCell<PTImageTextCellProtocol> *)imageCellWithTableView:(UITableView *)tableView
{
    static NSString *imageCellIdentifier = @"imageCellIdentifier";
    
    UITableViewCell<PTImageTextCellProtocol> *cell = (UITableViewCell<PTImageTextCellProtocol> *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:imageCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PTImageTextImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
    
}

@end
