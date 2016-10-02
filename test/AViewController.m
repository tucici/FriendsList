//
//  AViewController.m
//  test
//
//  Created by mac1 on 16/10/1.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import "AViewController.h"
#import "ViewController.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor purpleColor]];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
-(void)click:(UIButton *)sender{
    ViewController *avc = [[ViewController alloc]init];
    [self presentViewController:avc animated:NO completion:nil];
    
    
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
