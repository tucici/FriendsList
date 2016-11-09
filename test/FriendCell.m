//
//  FriendCell.m
//  FriendsList
//
//  Created by mac1 on 16/10/3.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isEditing = NO;
    }
    return self;
    
}
-(void)setIsEditing:(BOOL)isEditing{
    
    if (self.isEditing != isEditing) {
        _isEditing = isEditing;
    }
}
- (void)changeSelectState
{
    _isEditing = !_isEditing;
    self.detailTextLabel.text = _isEditing?@"已经选中":@"";
   
    NSLog(@"isediting    %d",_isEditing);
    [self setNeedsDisplay];
}
-(void)clear{
    self.detailTextLabel.text = @"";
    self.isEditing = NO;
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
