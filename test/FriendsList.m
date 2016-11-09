//
//  FriendsList.m
//  FriendsList
//
//  Created by mac1 on 16/10/2.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "FriendsList.h"

@implementation FriendsList
-(id)init{
    self = [super init];
    if (self) {
        
        [self initializeAllArray];
        
        [self initializeVisibleArray];
        
        [self initializeSelectedFriendsArray];
    }
    
    return self;
    
}
-(void)initializeSelectedFriendsArray{
    _selectedArray = [NSMutableArray array];
}

-(void)initializeVisibleArray{
    _visibleArray = [NSMutableArray array];
    
}

-(void)initializeAllArray{
    _allArray = [NSMutableArray arrayWithObjects:@"31305016406",@"6450684090",@"98016049490",@"160166540",@"99999999",@"888888",@"87777777",@"11111111",@"2222222222", @"66666666",@"6645664536",@"80003336",@"136136136",@"46464646",@"90909090",@"18181818",@"5656565656",@"3636363636",@"14201031",@"333322333",@"19999921",@"2000200",@"33332",@"155550416",@"1507016",nil];
}
-(void)addNewObject:(NSString *)object toArray:(NSMutableArray *)array{
    if (array.count) {
        for (NSString *str  in array) {
            if ([str isEqualToString:object]) {
                [array removeObject:object];
                return;
            }
        }
   }
        [array addObject:object];
   
}
-(void)removeOldObjectfromArray:(NSMutableArray *)array{
    [array removeObjectAtIndex:0];
}
@end
