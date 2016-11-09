//
//  BViewController.m
//  FriendsList
//
//  Created by mac1 on 16/10/2.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "BViewController.h"
#import "search.h"
#import "FriendsList.h"
#import "FriendCell.h"
@interface BViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) int number;                       /**/
@property (nonatomic, strong) FriendsList *friendsList; /*已经选中的好友列表*/
@property (nonatomic, strong) search * searchview;              /*搜索框*/
@property (nonatomic, strong) UIButton *button;                 /*返回按钮*/
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL selected;
@end

@implementation BViewController
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _number = 10000;
    _selected = NO;
    /*initializeBackButton*/
    [self initializeBack];
    
    [self initializeTextField];
    
    [self initializeTableView];
    
    [self initFriendsList];
    
    // Do any additional setup after loading the view.
}
-(void)initFriendsList{
    _friendsList  = [[FriendsList alloc]init];
    
}

-(void)initializeBack{
    _button =[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 60, 50)];
    [_button setTitle:@"back" forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button addTarget:self action:@selector(backToAVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void)initializeTextField{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10 + CGRectGetMaxY(_button.frame), self.view.frame.size.width - 20.0, 50.0)];
    _textField.placeholder = @"请输入。。。。。。";
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeAlways;/*清除输入框的按钮，一直出现*/
    //    [self.view addSubview:_textField];
    
    _searchview = [[search alloc]initWithFrame:CGRectMake(10, 10 + CGRectGetMaxY(_button.frame), self.view.frame.size.width - 20.0, 50.0)];
    _searchview.delegate = self;
    _searchview.placeholder = @"请输入00000000";
    [self.view addSubview:_searchview];
    
    
}

-(void)initializeTableView{
    self.number = 10000;
    CGFloat y = CGRectGetMaxY(_searchview.frame) + 10;
    _tableview= [[UITableView alloc]initWithFrame:CGRectMake(0.0, y, self.view.frame.size.width, self.view.frame.size.height - y) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}
-(void)backToAVC:(UIButton*)sender{
    [_textField resignFirstResponder];
    [_searchview resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)searchSelectedCell:(NSString *)string{
    
    [_friendsList.visibleArray removeAllObjects];
    for (int i = 0; i < _friendsList.allArray.count; i++) {
        if ([_friendsList.allArray[i] containsString:string]) {
            [_friendsList.visibleArray addObject:_friendsList.allArray[i]];
            
        }
        
    }
    [_tableview reloadData];
}
#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"didBeginEditing");
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchview resignFirstResponder];
    [self searchSelectedCell:_searchview.text];
    NSLog(@"searchButton");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"cancelButton");
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self searchSelectedCell:_searchview.text];
    NSLog(@"changing~~~~~~~~~~~~  ");
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self searchSelectedCell:_textField.text];
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return NO;
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (![_friendsList.visibleArray count] && ![_searchview.text isEqualToString:@""]) {
        return 0;
    }
    
    return [_friendsList.visibleArray count]?_friendsList.visibleArray.count:_friendsList.allArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"FriendCell%ld",(long)indexPath.row];
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    //    NSIndexPath *path =[NSIndexPath indexPathForRow:_number inSection:0];
    //    FriendCell *cell2 = [tableView cellForRowAtIndexPath:path];
    if (!cell) {
        cell = [[FriendCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    else{
        while (![cell.detailTextLabel.text isEqualToString:@""] && cell.isEditing == YES) {
            
            [cell changeSelectState];    //删除并进行重新分配
        }
    }
    if ([_friendsList.visibleArray count] && ![_searchview.text isEqualToString:@""]) {
        for (int i = 0; i <= _friendsList.visibleArray.count; i++) {
            if (indexPath.row == i ) {
                cell.textLabel.text = _friendsList.visibleArray[i];
            }
        }
        return cell;
    }
    if ([_friendsList.allArray count]) {
        
        for (int j = 0; j <= _friendsList.allArray.count; j++) {
            if (indexPath.row == j) {
                cell.textLabel.text = _friendsList.allArray[j];
                for (NSString *str in _friendsList.selectedArray) {
                    if ([cell.textLabel.text isEqualToString:str]) {
                        cell.detailTextLabel.text = @"已经选中";
                    }
                    
                }
            }
        }
        return cell;
    }
    
    return cell;
}
#pragma mark UITableViewDelegate
/*cell选中高亮后,恢复原来状态*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [_textField resignFirstResponder];
    [_searchview resignFirstResponder];
    
    
    FriendCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"isediting   ~~~~~  %d   ~~~~~~~ %ld",cell.isEditing, (long)indexPath.row);
    
    [cell changeSelectState];
    
    [_friendsList addNewObject:cell.textLabel.text toArray:_friendsList.selectedArray];
    
//    if (_number != (int)indexPath.row && _number != 10000) {
    
//        NSIndexPath *path =[NSIndexPath indexPathForRow:_number inSection:0];
//        FriendCell *cell = [tableView cellForRowAtIndexPath:path];
//        
//        [cell changeSelectState];
//        NSLog(@"_number    %d    %@      " ,_number,cell.textLabel.text);
//        [_friendsList removeOldObjectfromArray:_friendsList.selectedArray];
//    }
//    self.number = (int)indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"  >>>>  %lu  %@",(unsigned long)_friendsList.selectedArray.count , _friendsList.selectedArray);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
