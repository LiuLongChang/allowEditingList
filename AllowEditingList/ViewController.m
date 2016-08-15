//
//  ViewController.m
//  AllowEditingList
//
//  Created by langyue on 16/8/15.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define AppColor [UIColor colorWithRed:101/255 green:163/255 blue:57/255 alpha:1]

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * myTabView;
//
@property(nonatomic,strong)UIView * footerView;
@property(nonatomic,strong)UIButton * allDelBtn;
@property(nonatomic,strong)UIButton * delButton;
//
@property(nonatomic,assign)BOOL isSelected;



@end

@implementation ViewController


-(NSMutableArray*)dataArray{

    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"数据1",@"数据2",@"数据3",@"数据4",@"数据5",@"数据6",@"数据7",@"数据8",@"数据9",@"数据10",@"数据11",@"数据12",@"数据13",@"数据14",@"数据15",@"数据16",@"数据17",@"数据18",@"数据19",@"数据20",@"数据21",@"数据22",@"数据23",@"数据24",@"数据25",@"数据26",@"数据27",@"数据28",@"数据29",@"数据30"]];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.title = @"编辑列表";
    self.myTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.myTabView.delegate = self;
    self.myTabView.dataSource = self;
    self.myTabView.backgroundColor = [UIColor whiteColor];
    self.myTabView.showsVerticalScrollIndicator = NO;
    self.myTabView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.myTabView];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editList)];

    CGFloat footH = 64;
    CGFloat footY = ScreenHeight - footH;
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, footY, ScreenWidth,footH)];
    _footerView.alpha = 0;
    _footerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_footerView];


    _allDelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allDelBtn.frame = CGRectMake(0, 0, _footerView.frame.size.width*0.25,64);
    [_allDelBtn setTitle:@"全选" forState:UIControlStateNormal];
    [_allDelBtn addTarget:self action:@selector(allDelButton) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_allDelBtn];


    _delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _delButton.frame = CGRectMake(_footerView.frame.size.width*0.4, 0, 110, 64);
    [_delButton setTitle:@"删除" forState:UIControlStateNormal];
    [_delButton setBackgroundColor: AppColor];
    [_delButton addTarget:self action:@selector(deltButn) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:_delButton];

}




-(void)allDelButton{

    self.isSelected = !self.isSelected;

    for (int i = 0; i<self.dataArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        if (self.isSelected) {
            [self.myTabView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }else{//反选
            [self.myTabView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }

}

-(void)deltButn{

    NSMutableArray *deleteArrarys = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.myTabView.indexPathsForSelectedRows) {
        [deleteArrarys addObject:self.dataArray[indexPath.row]];
    }
    [UIView animateWithDuration:0 animations:^{
        [self.dataArray removeObjectsInArray:deleteArrarys];
        [self.myTabView reloadData];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            if (!self.dataArray.count)
            {
                self.footerView.alpha=1;
            }
        } completion:^(BOOL finished) {
            self.isSelected = NO;//全选之后又去掉几个选中状态
        }];
    }];

}



-(void)editList{
    self.isSelected = NO;//全选状态的切换
    NSString *string = !self.myTabView.editing?@"完成":@"编辑";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:string style:UIBarButtonItemStyleDone target:self action:@selector(editList)];
    if (self.dataArray.count) {
        [UIView animateWithDuration:0.25 animations:^{
            _footerView.alpha=!self.myTabView.editing?1:0;
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            self.footerView.alpha=0;
        }];
    }

    [self.myTabView setEditing:!self.myTabView.editing animated:YES];

    //self.myTabView.editing = !self.myTabView.editing;
}



#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell * cell = [TableViewCell createWithTableView:tableView];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


#pragma mark - 左滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{


    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.myTabView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
