//
//  ViewController.m
//  newRefresh
//
//  Created by apple on 15/3/30.
//  Copyright (c) 2015年 com.eku001. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "RefreshView.h"

@interface ViewController ()<UITableViewDataSource,FooterRefreshViewDelegate,HearderRefreshDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) FooterRefreshView *refresh;
@property (nonatomic, strong) HeaderRefreshView *headRefresh;
@property (nonatomic, strong) NSMutableArray *aArray;
@property (nonatomic, strong) NSArray *aaArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.view.backgroundColor = [UIColor blackColor];
    
//    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
//    footer.scrollView = self.mainTableView;
    
    _refresh = [[FooterRefreshView alloc] init];
    _refresh.delegate = self;
    _refresh.baseTableView = _mainTableView;
    
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
//    NSLog(@"%%%%  %d",_aArray.count);
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

-(void)refreshViewStart{
    [self performSelector:@selector(fsd) withObject:nil afterDelay:4];
}

- (void)fsd{
    [_aArray addObjectsFromArray:_aaArray];
    [self.mainTableView reloadData];
    [_refresh stopRefresh] ;
}

- (IBAction)stopRefresh:(id)sender {
    [_headRefresh stopRefresh];
    [_refresh stopRefresh];
}

@end
