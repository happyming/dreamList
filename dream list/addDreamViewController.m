//
//  addDreamViewController.m
//  dream list
//
//  Created by 光明 徐 on 15/1/27.
//  Copyright (c) 2015年 Guangming Xu. All rights reserved.
//

#import "addDreamViewController.h"


@interface addDreamViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *anewDreamTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveItem;

@end

@implementation addDreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.anewDreamTextField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.saveItem != sender) {
        return;
    }
    if (self.anewDreamTextField.text.length > 0) {
        self.aNewDream  = [[dreamItem alloc] init];
        self.aNewDream.dreamName = self.anewDreamTextField.text;
        self.aNewDream.completed = NO;
    }
}


@end
