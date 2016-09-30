//
//  DetailViewController.h
//  test
//
//  Created by mac1 on 16/9/30.
//  Copyright © 2016年 Tucici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

