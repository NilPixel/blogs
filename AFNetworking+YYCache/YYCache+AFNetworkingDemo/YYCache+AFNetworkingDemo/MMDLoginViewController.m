//
//  MMDLoginViewController.m
//  YYCache+AFNetworkingDemo
//
//  Created by Mime97 on 2016/11/16.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "MMDLoginViewController.h"
#import "MMDTestService.h"
#import "MMDLoginModel.h"
#import "MMDMessageListTablesViewController.h"

@interface MMDLoginViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation MMDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    NSDictionary *params = @{@"username":@"yanbei",@"password":[MMDMD5Utils encrypt:@"123456"],@"encrypt":@YES};
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [MMDTestService userLoginWithParams:params callBack:^(MMDResponse *response) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        if (response.isSuccess) {
            MMDLoginModel *loginModel = [MMDLoginModel mj_objectWithKeyValues:response.result];
            [[NSUserDefaults standardUserDefaults] setObject:loginModel.userToken.token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
        [_button setTitle:@"跳转" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor lightGrayColor]];
        [_button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)jump {
    [self presentViewController:[[MMDMessageListTablesViewController alloc]init] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
