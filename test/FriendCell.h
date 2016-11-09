//
//  FriendCell.h
//  FriendsList
//
//  Created by mac1 on 16/10/3.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell
@property (nonatomic, assign) BOOL isEditing;
-(void)changeSelectState;
-(void)clear;
@end
