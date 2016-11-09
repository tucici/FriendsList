//
//  AViewController.m
//  test
//
//  Created by mac1 on 16/10/1.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
#import "ViewController.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 60)];
    [button setTitle:@"Vchat" forState:UIControlStateNormal];
   [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(Vchat:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2  = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 110.0, 100, 100, 60)];
    [button2 setTitle:@"Group" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor yellowColor]];
    [button2 addTarget:self action:@selector(Group:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    // Do any additional setup after loading the view.
}
-(void)Vchat:(UIButton *)sender{
    ViewController *avc = [[ViewController alloc]init];
//    avc.type = InviteTypeVchat;
    [self presentViewController:avc animated:NO completion:nil];
    
    
}
-(void)Group:(UIButton *)sender{
BViewController *bvc= [[BViewController  alloc]init];
    [self presentViewController:bvc animated:NO completion:nil];
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
