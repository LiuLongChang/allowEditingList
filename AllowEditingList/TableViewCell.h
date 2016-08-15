//
//  TableViewCell.h
//  可编辑的列表
//
//  Created by macbook on 16/8/6.
//  Copyright © 2016年 郑卓青. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *numLabel;
@property (strong, nonatomic)  UILabel *textLabels;
+(instancetype)createWithTableView:(UITableView *)tableView;
@end
