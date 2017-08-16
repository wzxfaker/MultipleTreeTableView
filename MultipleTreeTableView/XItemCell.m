//
//  XItemCell.m
//  MultipleTreeTableView
//
//  Created by admin on 15/08/2017.
//  Copyright © 2017 gcg. All rights reserved.
//

#import "XItemCell.h"

@implementation XItemCell{
    UILabel *label;
    UILabel *detailLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 50, 30)];
        
        [self addSubview:label];
        [self addSubview: detailLabel];
    }
    return self;
}



- (void)setItem:(NodeItem *)item{
    _item = item;
    label.text = item.title;
    if (item.subItems.count > 0) {
        detailLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)item.subItems.count];
    }else{
        detailLabel.text = @"-";
    }
    CGRect frame = label.frame;
    frame.origin.x = 20*item.level;
    label.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
