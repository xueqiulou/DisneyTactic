//
//  XUEQIULOUCourseCell.m
//  DisneyTactic
//
//  Created by XQL on 2018/5/8.
//  Copyright © 2018年 XQL. All rights reserved.
//

#import "XUEQIULOUCourseCell.h"


@implementation XUEQIULOUCourseCell
{
    __weak IBOutlet UIImageView *iconView;
    __weak IBOutlet UILabel *titleL;
    __weak IBOutlet UILabel *subTitleL;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
