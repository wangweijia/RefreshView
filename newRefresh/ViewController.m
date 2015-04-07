//
//  ViewController.m
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "ViewController.h"
#import "RefreshView.h"

@interface ViewController ()<UITableViewDataSource,FooterRefreshViewDelegate,HearderRefreshDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) FooterRefreshView *FootRefresh;
@property (nonatomic, strong) HeaderRefreshView *headRefresh;

@property (nonatomic, strong) NSMutableArray *aArray;
@property (nonatomic, strong) NSArray *aaArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.dataSource = self;
    self.view.backgroundColor = [UIColor blackColor];
    
    _FootRefresh = [[FooterRefreshView alloc] init];
    _FootRefresh.delegate = self;
    _FootRefresh.baseTableView = _mainTableView;
    
    _headRefresh = [[HeaderRefreshView alloc] init];
    _headRefresh.delegate = self;
    _headRefresh.baseTableView = _mainTableView;
    
    _aaArray = @[@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss",@"ssssss"];
    _aArray = [NSMutableArray arrayWithArray:@[@"fsf",@"fsf",@"fsf"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _aArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *title = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:title];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = _aArray[indexPath.row];
    }
    return cell;
}

-(void)refreshViewStart:(RefreshViewType)refreshViewType{
    if (refreshViewType == RefreshViewTypeFooter) {
        [self performSelector:@selector(fsd) withObject:nil afterDelay:4];
    }
    else{
        [self performSelector:@selector(abc) withObject:nil afterDelay:3];
    }
}

- (void)abc{
    [self.aArray insertObject:@"wwj0" atIndex:0];
    [self.aArray insertObject:@"wwj1" atIndex:0];
    [self.aArray insertObject:@"wwj2" atIndex:0];
    [self.aArray insertObject:@"wwj3" atIndex:0];
    [self.mainTableView reloadData];
    [_headRefresh stopRefresh] ;
}

- (void)fsd{
    [_aArray addObjectsFromArray:_aaArray];
    [self.mainTableView reloadData];
    [_FootRefresh stopRefresh] ;
}

- (IBAction)stopRefresh:(id)sender {
    [_headRefresh stopRefresh];
    [_FootRefresh stopRefresh];
}

@end
