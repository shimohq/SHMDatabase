//
//  DisplayCell.m
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "DisplayCell.h"
#import "AnyModel.h"
#import <YYModel/YYModel.h>
#import "SHMDatabase.h"

@implementation DisplayCell

- (void)setModel:(AnyModel *)model {
    _model = model ;
    
    self.lbTitle.text =
    [NSString stringWithFormat:@"pkid %d, t:%@, ct:%lld, ut:%lld",model.pkid,model.title,model.shmdb_createTime,model.shmdb_updateTime] ;
    self.img.image = model.image;
    self.lbContent.text = [NSString stringWithFormat:@"%@",[model yy_modelToJSONObject]] ;
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
