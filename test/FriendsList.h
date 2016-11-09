//
//  FriendsList.h
//  FriendsList
//
//  Created by mac1 on 16/10/2.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsList : NSObject
@property (nonatomic, strong) NSMutableArray *selectedArray;    /*选中的好友列表*/
@property (nonatomic, strong) NSMutableArray *visibleArray;     /*符合搜索条件的，可视的好友列表*/
@property (nonatomic, strong) NSMutableArray *allArray;         /*全部好友列表*/
-(void)addNewObject:(NSString *)object toArray:(NSMutableArray *)array;
-(void)removeOldObjectfromArray:(NSMutableArray *)array;
@end
