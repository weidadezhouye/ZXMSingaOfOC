//
//  ZXHomeViewController.m
//  ZXMSinga
//
//  Created by  周学明 on 15/10/18.
//  Copyright © 2015年  周学明. All rights reserved.
//

#import "ZXHomeViewController.h"
#import "ZXOneViewController.h"
#import "ZXTitleBtn.h"
#import "ZXPopController.h"
#import "ZXStatus.h"
#import "ZXUser.h"
#import "ZXFooterView.h"


@interface ZXHomeViewController ()


@property(nonatomic,strong) ZXPopController *popController;

//保存所有的模型数据
@property(nonatomic,strong) NSMutableArray *statues;

//刷新控制器
@property(nonatomic,strong) UIRefreshControl *refVc;

@property(nonatomic,strong)ZXFooterView *footerView;


@end

@implementation ZXHomeViewController

#pragma mark - 懒加载

- (NSMutableArray *)statues
{
    
    if (!_statues)
    {
        _statues = [NSMutableArray array];
        
    }
    return _statues;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
    [ZXAccout shareAccout];
//    导航栏
    [self setupNavtionitem];
//    微博数据
    [self setupStatusWithSinceID:@"0"];
//  刷新
    [self setupRefreshControl];


}

#pragma mark - 设置底部和顶部的刷新视图
- (void)loadFooterView{
//    没有footerView才添加
    if(!self.tableView.tableFooterView)
    {
    //    设置底部下拉刷新
    ZXFooterView *footerView = [ZXFooterView footerView];
    
    self.tableView.tableFooterView = footerView;
    
    self.footerView = footerView;
    }
}

//刷新
- (void)setupRefreshControl{
    
    UIRefreshControl *refVc = [[UIRefreshControl alloc] init];
//    添加事件，监听刷新操作
    [refVc addTarget:self action:@selector(refreshStatus) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refVc];
    self.refVc = refVc;
    
}
//下拉刷新操作
- (void)refreshStatus
{
//    获取当前微博最新的数据
    ZXStatus * newStatus = [self.statues firstObject];
    
    [self setupStatusWithSinceID:newStatus.idstr];
    
    
}


#pragma mark - 上拉刷新和下拉刷新加载微博数据
//设置微博数据
- (void)setupStatusWithSinceID:(NSString*)sinceID
{
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [ZXAccout shareAccout].access_token;
//    防止第一次加载的时候数组里面还没有元素
    if(sinceID)
    {
        parame[@"since_id"] = sinceID;
    }
    
//    parame[@"count"] = @(20);

//    get请求数据
    [manager GET:url parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSArray * statuses = responseObject[@"statuses"];
        
        NSArray * statusesArr = [ZXStatus objectArrayWithKeyValuesArray:statuses];
        
    
////       方法二 将网络获取的数据添加到模型里面
//        for(NSDictionary *dict in statuses)
//        {
//            ZXStatus *status = [ZXStatus objectWithKeyValues:dict];
//            [self.statues addObject:status];
////            NSLog(@"*****%@*****",status.text);
//            [self.tableView reloadData];
//        }
//        
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusesArr.count)];
        
        [self.statues insertObjects:statusesArr atIndexes:set];
        
        [self loadStatusCount:statuses.count];
        
//        微博模型数组里面有元素的的时候才开始添加footerView
        if(self.statues.count > 0)
        {
            //    加载底部
            [self loadFooterView];
        }
        
        [self.tableView reloadData];
//        结束刷新
        [self.refVc endRefreshing];
        
       

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

//加载更多数据
- (void)loadMoreStatus{
    
    //    加载更多数据
    NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"access_token"] = [ZXAccout shareAccout].access_token;
    
    ZXStatus * last = [self.statues lastObject];
    parame[@"max_id"] = @([last.idstr integerValue] - 1);
    
    //    get请求数据
    [manager GET:url parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * statuses = responseObject[@"statuses"];
        
        NSArray * statusesArr = [ZXStatus objectArrayWithKeyValuesArray:statuses];
        
        
        [self.statues addObjectsFromArray:statusesArr];
        
        [self.tableView reloadData];
        //        结束刷新
        self.footerView.loading = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - tableviewDelegate 方法的实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%zd",self.statues.count);
    return self.statues.count;
}




- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"statusCell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    ZXStatus *status = self.statues[indexPath.row];
    
    cell.textLabel.text = status.text;
    cell.detailTextLabel.text = status.user.screen_name;
    
    
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_card_top_background_highlighted"]];
    
    
    return cell;
    
}

#pragma mark - 导航栏的设置
//设置导航栏按钮
- (void)setupNavtionitem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnWithNolImgName:@"navigationbar_friendsearch" selImgName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSecrchBtnClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithNolImgName:@"navigationbar_pop" selImgName:@"navigationbar_pop_highlighted" target:self action:@selector(popBtnClick)];
    //self.title = @"首页";
    //    为了响应首页title的点击，故而title这个位置必须放置button
    //    创建button(使用自定义的)
    ZXTitleBtn *titleBtn = [ZXTitleBtn buttonWithType:UIButtonTypeCustom];
    
    //    将自定义的按钮为标题位置视图赋值
    self.navigationItem.titleView = titleBtn;
    //    为按钮添加点击事件
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


//监听添加朋友按钮的点击事件
- (void)friendSecrchBtnClick
{
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
    
    
}
//监听扫一扫按钮的点击
- (void)popBtnClick
{
    ZXOneViewController *oneVc = [[ZXOneViewController alloc] init];
    [self.navigationController pushViewController:oneVc animated:YES];
}


//今天title按钮的点击事件
- (void)titleBtnClick:(ZXTitleBtn*)btn
{
#warning 如果没有才进行创建，相当于懒加载
    if(!self.popController)
    {
        //    创建一个View
        UIButton *view  = [[UIButton alloc] init];
        view.bounds = CGRectMake(0, 0, 100, 140);
        view.backgroundColor = [UIColor redColor];
        //    添加点击事件
        [view addTarget:self action:@selector(popViewClick) forControlEvents:UIControlEventTouchUpInside];
        
        //    创建popController
        ZXPopController *popController = [[ZXPopController alloc] initWithView:view];
        
        popController.alpha = 0.5;
        
        self.popController = popController;
    }

//    展示popController (可以带有位置)
    [self.popController showInView:btn WithPosition:positionBottonRight];
    
    
    
}

- (void)popViewClick
{
    [self.popController dismiss];
}

#pragma mark - UIScrollViewDelegate代理方法的实现，以滚动就会触发这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    scrollView偏移的y
    CGFloat contentOffY = scrollView.contentOffset.y;
    
    CGFloat contentSizeY = self.tableView.contentSize.height;
    
    CGFloat scrollViewH = scrollView.h;
    
    CGFloat deta = contentSizeY - scrollViewH + 44 +49;
    
    if (deta < 0) return
    
    ZXLog(@"%f",contentOffY-deta);
    if(contentOffY > deta && !self.footerView.loading )
    {
        //    改变菊花的状态
        self.footerView.loading = YES;
//        加载数据
        [self loadMoreStatus];
        ZXLog(@"可以刷新");
    }
    
    
}

#pragma mark - 设置加载数据的label提示框：
- (void)loadStatusCount:(NSInteger)count
{
    NSString * showMsg = @"没有更多数据";
    if(count > 0)
    {
        showMsg = [NSString stringWithFormat:@"加载了%zd条数据",count];
    }
    UILabel *lab = [[UILabel alloc] init];
    lab.text = showMsg;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, 20, self.view.w, 44);
    lab.backgroundColor = [UIColor orangeColor];
    lab.textColor = [UIColor whiteColor];
    
//    [self.view addSubview:lab];
    [self.navigationController.view insertSubview:lab belowSubview:self.navigationController.navigationBar];
    
//    动画弹出提示消息文本框
    [UIView animateWithDuration:1 animations:^{
        lab.y += 44;
    } completion:^(BOOL finished) {
        
//        嵌套两层动画，里面是消失并且移除的动画
        [UIView animateWithDuration:1 animations:^{
            lab.y -= 44;
        } completion:^(BOOL finished) {
           [lab removeFromSuperview];
        }];
        
    }];
    
    
}


@end
