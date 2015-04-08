//
//  dreamDetailViewController.m
//  dream list
//
//  Created by 光明 徐 on 15/3/11.
//  Copyright (c) 2015年 Guangming Xu. All rights reserved.
//

#import "dreamDetailViewController.h"

@interface dreamDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailView;

@end

@implementation dreamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailView.text = @"hello world";
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
