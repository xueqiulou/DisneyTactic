//
//  XUEQIULOUCell1PushViewController.m
//  DisneyTactic
//
//  Created by XQL on 2018/5/3.
//  Copyright © 2018年 XQL. All rights reserved.
//

#import "XUEQIULOUCell1PushViewController.h"
#import "XUEQIULOUWebViewController.h"

#import "XUEQIULOUHTTPManager.h"
#import "XUEQIULOUCell1PushCell.h"

@interface XUEQIULOUCell1PushViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation XUEQIULOUCell1PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 120;
    
    [XUEQIULOUHTTPManager requestMethodWithURL:self.url Success:^(id responseObject) {
        
        self.dataArr = responseObject[@"data"][@"recipes"];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XUEQIULOUCell1PushCell *cell = [XUEQIULOUCell1PushCell cellWithTableView:tableView];
    
    cell.dic = self.dataArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XUEQIULOUWebViewController *webVC = [[XUEQIULOUWebViewController alloc] init];
    webVC.url = self.dataArr[indexPath.row][@"page_url"];
    [self.navigationController pushViewController:webVC animated:nil];
}

@end
