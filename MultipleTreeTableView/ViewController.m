//
//  ViewController.m
//  MultipleTreeTableView
//
//  Created by admin on 15/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import "ViewController.h"
#import "XItemCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** <##> */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TreeTableView";
    self.menuData = [[MenuData alloc] init];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    _tableView = tableView;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menuData.tableViewDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    XItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[XItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.item = _menuData.tableViewDataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.item.isSubItemOpen) {
        //remove
        NSArray *arr = [_menuData deleteMenuIndexPaths:cell.item];
        if (arr.count > 0) {
            [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        }
    }else{
        //insert
        NSArray *arr = [_menuData insertMenuIndexPaths:cell.item];
        if (arr.count > 0) {
            [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        }
    
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
