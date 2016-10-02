//
//  ViewController.m
//  test
//
//  Created by mac1 on 16/9/30.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "ViewController.h"
#import "search.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) int number;                       /**/
@property (nonatomic, strong) NSMutableArray * containsArray;   /*包含搜索栏内容的好友列表*/
@property (nonatomic, strong) NSMutableArray *friendArray;      /*全部好友列表*/
@property (nonatomic, strong) search * searchview;              /*搜索框*/
@property (nonatomic, strong) UIButton *button;                 /*返回按钮*/
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.number = 10000;
    
    /*initializeBackButton*/
    [self initBack];
    
    [self initTextField];
    
    [self initTableView];
    
    [self initArray];
    
    // Do any additional setup after loading the view.
}

-(void)initArray{
    _containsArray = [NSMutableArray array];
    _friendArray = [NSMutableArray arrayWithObjects:@"31305016406",@"6450684090",@"98016049490",@"160166540",@"99999999",@"888888",@"87777777",@"11111111",@"2222222222", @"66666666",nil];
}

-(void)initBack{
    _button =[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 60, 50)];
    [_button setTitle:@"back" forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void)initTextField{
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

-(void)initTableView{
    self.number = 10000;
    _tableview= [[UITableView alloc]initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_textField.frame) + 10, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
}
-(void)back:(UIButton*)sender{
    [_textField resignFirstResponder];
    [_searchview resignFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)searchSelectedCell:(NSString *)string{
    
    [_containsArray removeAllObjects];
    NSLog(@"string    %@   %lu",string,(unsigned long)_containsArray.count);
    for (int i = 0; i < 10; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [_tableview cellForRowAtIndexPath:path];
        
        if ([_friendArray[i] containsString:string]) {
            [_containsArray addObject:_friendArray[i]];
            NSLog(@"containsArray; %lu  \n %@",(unsigned long)_containsArray.count,_containsArray);
            //            cell.textLabel.text = @"😘😘😘😘😘😘😘😘";
            
        }
        //        else if(![cell.textLabel.text containsString:string]){
        //            cell.textLabel.text = [NSString stringWithFormat:@"%d%d%d%d%d%d%d%d%d%d",i,i,i,i,i,i,i,i,i,i];
        //        }
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
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"should end editing");
//[self searchSelectedCell:_searchview.text];
//    return NO;
//}
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    [self searchSelectedCell:_textField.text];
//    NSLog(@"didEndEditing");
//
//}
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
    if (![_containsArray count] && ![_searchview.text isEqualToString:@""]) {
        return 0;
    }
    
    return [_containsArray count]?_containsArray.count:_friendArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"SettingUITableViewCell";
    UITableViewCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if ([_containsArray count] && ![_searchview.text isEqualToString:@""]) {
        for (int i = 0; i <= _containsArray.count; i++) {
            if (indexPath.row == i ) {
                NSLog(@"  i        %d   cell.text   %@" ,i,_containsArray[i]);
                cell.textLabel.text = _containsArray[i];
            }
        }
        return cell;
    }
    if ([_friendArray count]) {
        
        for (int j = 0; j <= _friendArray.count; j++) {
            if (indexPath.row == j) {
                cell.textLabel.text = _friendArray[j];
            }
        }
        return cell;
    }
    
    return cell;
}

/*cell选中高亮后,恢复原来状态*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indext   %ld",(long)indexPath.row);
    [_textField resignFirstResponder];
    [_searchview resignFirstResponder];
    //
    //   NSIndexPath *index = [_tableview indexPathForSelectedRow];
    //    NSLog(@"index   %ld",(long)index.row);
    NSIndexPath *path=[NSIndexPath indexPathForRow:indexPath.row  inSection:0];
    UITableViewCell *cell = (UITableViewCell *)[_tableview cellForRowAtIndexPath:path];
    cell.textLabel.text =@"已经选中";
    
    if (self.number != (int)indexPath.row) {
        NSIndexPath *path=[NSIndexPath indexPathForRow:self.number  inSection:0];
        UITableViewCell *cell = (UITableViewCell *)[_tableview cellForRowAtIndexPath:path];
        cell.textLabel.text =@"weixuanzhong";
    }
    self.number = (int)indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
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
