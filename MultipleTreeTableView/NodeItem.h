//
//  NodeItem.h
//  MultipleTreeTableView
//
//  Created by admin on 15/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import <Foundation/Foundation.h>

//结点模型
@interface NodeItem : NSObject

/** <##> */
@property (nonatomic, copy) NSString *title;
/** <##> */
@property (nonatomic, assign) NSInteger level;
/** <##> */
@property (nonatomic, strong) NSMutableArray *subItems;
/** 标记自菜单是否被打开 */
@property (nonatomic, assign) BOOL isSubItemOpen;
/** 标记该子菜单是否要在其父菜单展开时自动展开 */
@property (nonatomic, assign) BOOL isSubCascadeOpen;

@end
