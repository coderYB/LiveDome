//
//  RecommendViewController.m
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "RecommendViewController.h"
#define Ratio 708/550
@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, assign) NSInteger page;

@end

@implementation RecommendViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self bulidTableView];
    // 添加下拉刷新
    [self addMJRefresh];
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)bulidTableView{
    _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.rowHeight = SCREEN_WIDTH * Ratio + 1;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTableView.estimatedRowHeight = 0;
    _contentTableView.estimatedSectionHeaderHeight = 0;
    _contentTableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:_contentTableView];
    
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT-64-49);
    }];
    [_contentTableView reloadData];
}

#pragma mrak - 刷新
- (void) addMJRefresh{
    __weak typeof(self) tempSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置header
    self.contentTableView.mj_header = header;
    
    self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [tempSelf loadMoreData];
        
    }];
}

/**
 下拉刷新
 */
- (void) refreshData{
    [_contentTableView.mj_footer resetNoMoreData];
    _page = 1;
    [self loadData];
}

/**
 上拉加载更多
 */
- (void) loadMoreData{
    _page++;
    [self loadData];
}


- (void)loadData{
    __weak typeof(self) tempSelf = self;
    // 格式
    NSDictionary *dic = @{@"format":@"json"};
    [NetWorkTools GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", (long)self.page] parameters:dic success:^(id  _Nonnull json) {
        NSLog(@"data = %@",json);
        if (json&&([[json objectForKey:@"code"] integerValue]==100)) {
            NSDictionary *datadic =[json objectForKey:@"data"];
            
            [RecommendListModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"list":@"RecommendModel"};
            }];
            
            RecommendListModel * model = [RecommendListModel mj_objectWithKeyValues:datadic];
            
            if (tempSelf.page == 1) {
                [tempSelf.dataList removeAllObjects];
            }
            
            [tempSelf.dataList addObjectsFromArray:model.list];
        }
        
        [tempSelf.contentTableView.mj_header endRefreshing];
        [tempSelf.contentTableView.mj_footer endRefreshing];
        [tempSelf.contentTableView reloadData];
        
        if ([json[@"data"][@"list"] isKindOfClass:[NSNull class]] || [(NSArray *)json[@"data"][@"list"] count] == 0 || [json[@"data"]  isEqual: @""] || (json&&([[json objectForKey:@"code"] integerValue]==106))) {//变为没有更多数据的状态
            [tempSelf.contentTableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [tempSelf.contentTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        [tempSelf.contentTableView.mj_header endRefreshing];
        [tempSelf.contentTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - ---| UITableViewDataSource |---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"Cell";
    RecommendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.playerModel = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController * playerVc = [[PlayerViewController alloc] init];
    RecommendModel * PlayerModel = self.dataList[indexPath.row];
    playerVc.liveUrl = PlayerModel.flv;
    playerVc.imageUrl = PlayerModel.smallpic;
    [self.navigationController pushViewController:playerVc animated:true];
}


- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }return _dataList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
