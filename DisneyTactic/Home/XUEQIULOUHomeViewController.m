//
//  XUEQIULOUHomeViewController.m
//  DisneyTactic
//
//  Created by XQL on 2018/5/1.
//  Copyright © 2018年 XQL. All rights reserved.
//

#import "XUEQIULOUHomeViewController.h"
#import "XUEQIULOUWebViewController.h"
#import "XUEQIULOUCell1PushViewController.h"
#import "XUEQIULOUHTTPManager.h"
#import <SDCycleScrollView.h>

#import "XUEQIULOUHomeCell1.h"
#import "XUEQIULOUHomeCell2.h"

@interface XUEQIULOUHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *bannerView;


@property (nonatomic,strong) SDCycleScrollView    *scrollView;

@property (nonatomic,strong) NSMutableArray    *dataArr;

@property (nonatomic,strong) NSMutableArray    *images;

@end

@implementation XUEQIULOUHomeViewController
{
    NSArray *banners;
    NSArray *videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self setupSubviews];
    
    self.images = @[].mutableCopy;
    
    [XUEQIULOUHTTPManager requestMethodWithURL:@"https://g2p.gn.youyizhidao.com/matrix_common/api/recipe/firstpage?appname=zhangspdishinigonglve&os=ios&version=5.5.0&udid=5034dcac1e4102ffbfc8d482ae48c2a7b25da748&hardware=iphone&newstyle=1&info_flow_ad=true&new_style=1&is_home=1" Success:^(id responseObject) {
        
        banners = responseObject[@"data"][@"sliding_window"];
        videos = responseObject[@"data"][@"video_recommend"][@"list"];
        for (NSDictionary *dic in banners) {
            [self.images addObject:dic[@"img_url"]];
        }
        self.scrollView.imageURLStringsGroup = self.images;
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)setupSubviews
{
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bannerView.frame.size.width, self.bannerView.frame.size.height) delegate:self placeholderImage:nil];
    
    scrollView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    scrollView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    scrollView.showPageControl = YES;
    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.bannerView addSubview:scrollView];
    self.scrollView = scrollView;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.bannerView.bounds;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 106;
    }else{
        return 270;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return videos.count+1;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.row == 0) {
       XUEQIULOUHomeCell1* cell = [XUEQIULOUHomeCell1 cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        XUEQIULOUHomeCell2* cell = [XUEQIULOUHomeCell2 cellWithTableView:tableView];
        cell.dic = videos[indexPath.row-1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return cell;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    XUEQIULOUWebViewController *webVC = [[XUEQIULOUWebViewController alloc] init];
    webVC.url = banners[index][@"page_url"];
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)cell1Click:(UIButton *)sender {
    
    XUEQIULOUCell1PushViewController *listVC = [[XUEQIULOUCell1PushViewController alloc] init];
    if (sender.tag == 100) {//左边按钮
        listVC.url = @"https://g2p.gn.youyizhidao.com/matrix_common/api/recipe/detailsbook?appname=zhangspdishinigonglve&hardware=iphone&mainId=114&os=ios&page=1&udid=5034dcac1e4102ffbfc8d482ae48c2a7b25da748&version=5.5.0";
        listVC.navigationItem.title = @"演出指南";
    }else if (sender.tag == 101){//中间按钮
        
        listVC.url = @"https://g2p.gn.youyizhidao.com/matrix_common/api/recipe/detailsbook?appname=zhangspdishinigonglve&hardware=iphone&mainId=115&os=ios&page=1&udid=5034dcac1e4102ffbfc8d482ae48c2a7b25da748&version=5.5.0";
        listVC.navigationItem.title = @"轻松游记";
        
    }else if (sender.tag == 102){//右边按钮
        listVC.url = @"https://g2p.gn.youyizhidao.com/matrix_common/api/recipe/detailsbook?appname=zhangspdishinigonglve&hardware=iphone&mainId=116&os=ios&page=1&udid=5034dcac1e4102ffbfc8d482ae48c2a7b25da748&version=5.5.0";
        listVC.navigationItem.title = @"人物故事";
    }
    
    [self.navigationController pushViewController:listVC animated:YES];
    
}

@end
