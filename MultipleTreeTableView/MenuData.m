//
//  MenuData.m
//  MultipleTreeTableView
//
//  Created by admin on 15/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import "MenuData.h"
#import <UIKit/UIKit.h>

@interface MenuData ()

@end

@implementation MenuData

- (id)init{
    if (self = [super init]) {
        self.tableViewDataArr = [NSMutableArray array];
        self.itemsToInsertArr = [NSMutableArray array];
        self.itemsToRemoveArr = [NSMutableArray array];
        [self initModelData];
    }
    return self;
}

- (void)initModelData{
    self.rootItem = [[NodeItem alloc] init];
    _rootItem.title = @"根菜单";
    _rootItem.subItems = [NSMutableArray array];
    _rootItem.level = 0;
    
    NSArray *firstMenuData = @[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单五"];
    NSArray *secondMenuData0 = @[@"子项一",@"子项二",@"子项三"];
    NSArray *secondMenuData1 = @[@"选择一",@"选择二",@"选择三",@"选择四",@"选择五"];
    NSArray *thirdMenuData = @[@"内容一",@"内容二",@"哈哈哈",@"呵呵呵"];
    
    for (int i = 0; i < firstMenuData.count; i++) {
        NodeItem *firstItem = [[NodeItem alloc] init];
        firstItem.title = firstMenuData[i];
        firstItem.level = 1;
        firstItem.subItems = [NSMutableArray array];
        if (i == 0) {
            for (int i = 0; i < secondMenuData0.count; i++) {
                NodeItem *secondItem = [[NodeItem alloc] init];
                secondItem.title = secondMenuData0[i];
                secondItem.level = 2;
                secondItem.subItems = [NSMutableArray array];
                if (i == 1) {
                    for (int i = 0; i < thirdMenuData.count; i++) {
                        NodeItem *thirdItem = [[NodeItem alloc] init];
                        thirdItem.title = thirdMenuData[i];
                        thirdItem.level = 3;
                        thirdItem.subItems = [NSMutableArray array];
                        [secondItem.subItems addObject:thirdItem];
                    }
                }
                [firstItem.subItems addObject:secondItem];
            }
        }
        if (i == 3) {
            for (int i = 0; i < secondMenuData1.count; i++) {
                NodeItem *secondItem = [[NodeItem alloc] init];
                secondItem.title = secondMenuData1[i];
                secondItem.level = 2;
                secondItem.subItems = [NSMutableArray array];
                [firstItem.subItems addObject:secondItem];
            }
        }
        [_rootItem.subItems addObject:firstItem];
    }
    [_tableViewDataArr addObject:_rootItem];

}

#pragma mark - delete
- (NSArray *)deleteMenuIndexPaths:(NodeItem *)item{
    [_itemsToRemoveArr removeAllObjects];
    [self deleteMenuObject:item];
    NSArray *removeArr = [self deleteIndexOfMenuObject:_itemsToRemoveArr];
    return removeArr;
}

- (void)deleteMenuObject:(NodeItem *)item{
    if (!item) {
        return;
    }
    for (int i = 0; i < item.subItems.count && item.isSubItemOpen; i++) {
        NodeItem *childItem = item.subItems[i];
        [_itemsToRemoveArr addObject:childItem];
        [self deleteMenuObject:childItem];
    }
    item.isSubItemOpen = NO;
//    return;
}

- (NSArray *)deleteIndexOfMenuObject:(NSMutableArray *)removeArr{
    NSMutableArray *pathArr = [NSMutableArray array];
    NSMutableIndexSet *pathSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < removeArr.count; i++) {
        NodeItem *item = removeArr[i];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[_tableViewDataArr indexOfObject:item] inSection:0];
        [pathArr addObject:path];
        [pathSet addIndex:path.row];//此处应该是删除相同的元素
    }
    [_tableViewDataArr removeObjectsAtIndexes:pathSet];
    return pathArr;
}


#pragma mark - insert
- (NSArray *)insertMenuIndexPaths:(NodeItem *)item{
    [_itemsToInsertArr removeAllObjects];
    [self insertMenuObject:item];
    NSArray *insertArr = [self insertIndexesOfMenuObject:_itemsToInsertArr];
    return insertArr;
}

- (void)insertMenuObject:(NodeItem *)item{
    if (!item) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_tableViewDataArr indexOfObject:item] inSection:0];
    for (int i = 0; i < item.subItems.count; i++) {
        NodeItem *childItem = item.subItems[i];
        [_tableViewDataArr insertObject:childItem atIndex:indexPath.row+i+1];
        [_itemsToInsertArr addObject:childItem];
        item.isSubItemOpen = YES;
    }
    for (int i = 0; i < item.subItems.count; i++) {
        NodeItem *childItem = item.subItems[i];
        if (childItem.isSubCascadeOpen) {
            [self insertMenuObject:childItem];
        }
    }
}

- (NSArray *)insertIndexesOfMenuObject:(NSMutableArray *)insertArr{
    NSMutableArray *arr = [NSMutableArray array];
    for (NodeItem *item in insertArr) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_tableViewDataArr indexOfObject:item] inSection:0];
        [arr addObject:indexPath];
    }
    return arr;
}


@end
