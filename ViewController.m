//
//  ViewController.m
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
#import "AFNetworkingExtentionVC.h"
#import "ZdlModel.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[FMDBManager shareManager] creatTableWithName:@"userInfo(id integer primary key autoincrement,name varchar(256),age integer default 0,image blob)"];
    
    _dataArr=[[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    [[AFNetworkingExtentionVC sharedManager] get:@"http://lib.wap.zol.com.cn/ipj/tip_fruit/tip_fruit_selected/index.php?page=0&v=1.0&vs=iph100" params:nil success:^(id responseObj) {
        
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
        NSDictionary *dict1=[dict objectForKey:@"news"];
        for (NSDictionary *dict in dict1) {
            ZdlModel *model=[[ZdlModel alloc]initWithJson:dict];
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
        NSLog(@"网络请求成功");
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"zz"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"zz"];
    }
    ZdlModel *model=[_dataArr objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    cell.textLabel.text=model.userName;
    cell.detailTextLabel.text=model.text;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
