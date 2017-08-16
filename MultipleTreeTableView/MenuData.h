//
//  MenuData.h
//  MultipleTreeTableView
//
//  Created by admin on 15/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodeItem.h"

@interface MenuData : NSObject

/** <##> */
@property (nonatomic, strong) NodeItem *rootItem;
/** <##> */
@property (nonatomic, strong) NSMutableArray *itemsToRemoveArr;
/** <##> */
@property (nonatomic, strong) NSMutableArray *itemsToInsertArr;
/** <##> */
@property (nonatomic, strong) NSMutableArray *tableViewDataArr;

- (NSArray *)deleteMenuIndexPaths:(NodeItem *)item;
- (NSArray *)insertMenuIndexPaths:(NodeItem *)item;

@end
