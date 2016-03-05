//
//  PTImageTextCellFactory.h
//  ImageTextLayout
//
//  Created by Peter on 16/3/5.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PTImageTextHelper.h"
#import "PTImageTextCellProtocol.h"

@interface PTImageTextCellFactory : NSObject

+ (UITableViewCell<PTImageTextCellProtocol> *)cellWithTableView:(UITableView *)tableView type:(ImageTextType)type;

@end
