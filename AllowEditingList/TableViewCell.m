//
//  TableViewCell.m
//  可编辑的列表
//
//  Created by macbook on 16/8/6.
//  Copyright © 2016年 郑卓青. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

+(instancetype)createWithTableView:(UITableView *)tableView{
    static NSString *ID=@"Cell";
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;//有这个方法不能选中
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.editing) {
        if (selected) {
            // 编辑状态去掉渲染
            self.contentView.backgroundColor = [UIColor whiteColor];
            self.backgroundView.backgroundColor = [UIColor whiteColor];
            // 左边选择按钮去掉渲染背景
            UIView *view = [[UIView alloc] initWithFrame:self.multipleSelectionBackgroundView.bounds];
            view.backgroundColor = [UIColor whiteColor];
            self.selectedBackgroundView = view;
            
        }
    }

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 100, 20)];
        [self.contentView addSubview:_numLabel];
        _textLabels=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 20)];
        [self.contentView addSubview:_textLabels];
        
    }
    
    return self;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (editing) {
        for (UIControl *control in self.subviews){
            if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
                for (UIView *v in control.subviews)
                {


                    if ([v isKindOfClass: [UIImageView class]]) {
                        UIImageView *img=(UIImageView *)v;
                        img.image = [UIImage imageNamed:@"btn1-choose"];
                    }


                }
            }
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"btn1-choose-1"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"btn1-choose"];
                    }
                }
            }
        }
    }
    
}

@end
