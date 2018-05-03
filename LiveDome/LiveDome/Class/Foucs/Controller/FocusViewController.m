//
//  FocusViewController.m
//  LiveDome
//
//  Created by zbwx on 2018/5/2.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "FocusViewController.h"
#define Ratio 708/550
@interface FocusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, assign) NSInteger page;

@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidTableView];
    // 添加下拉刷新
    [self addRefresh];
}

- (void)bulidTableView{
    _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _contentTableView.delegate = self;
    _contentTableView.dataSource = self;
    _contentTableView.rowHeight = [UIScreen mainScreen].bounds.size.width * Ratio + 1;
    _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_contentTableView];
    [_contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT-64-49);
    }];
}

#pragma mrak - 刷新
-(void)addRefresh{
    __weak typeof(self) tempSelf = self;
    _contentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [tempSelf refreshData];
    }];
    [_contentTableView.mj_header beginRefreshing];
    
    _contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    // 格式
    __weak typeof(self) tempSelf = self;
    NSDictionary *dic = @{@"format":@"json"};
    [NetWorkTools GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%zd", self.page] parameters:dic success:^(id  _Nonnull json) {
        
        if (json&&([[json objectForKey:@"code"] integerValue]==100)) {
            NSDictionary *datadic =[json objectForKey:@"data"];
            
            [FocusListModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{@"list":@"FocusModel"};
            }];
            
            FocusListModel * model = [FocusListModel mj_objectWithKeyValues:datadic];
            
            if (tempSelf.page == 1) {
                [tempSelf.dataList removeAllObjects];
            }
            [tempSelf.dataList addObjectsFromArray:model.list];
        }
        [tempSelf.contentTableView.mj_header endRefreshing];
        [tempSelf.contentTableView.mj_footer endRefreshing];
        [tempSelf.contentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [tempSelf.contentTableView.mj_header endRefreshing];
        [tempSelf.contentTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - ---| UITableViewDataSource |---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FocusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.playerModel = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerViewController * playerVc = [[PlayerViewController alloc] init];
    FocusModel * PlayerModel = self.dataList[indexPath.row];
    playerVc.liveUrl = PlayerModel.flv;
    playerVc.imageUrl = PlayerModel.photo;
    [self.navigationController pushViewController:playerVc animated:true];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
