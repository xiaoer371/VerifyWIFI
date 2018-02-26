//
//  ViewController.m
//  ZTVerifyWIFIDemo
//
//  Created by XiaoJin on 2018/2/26.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "ViewController.h"
#import "ZTVerifyWIFI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ZTVerifyWIFI *VerifyWIFI = [[ZTVerifyWIFI alloc] init];
    [VerifyWIFI checkWIFIIsAvailable:^(BOOL needVerify) {
        if (needVerify) {
            NSLog(@"需要验证");
        }else{
            NSLog(@"不需要验证");
        }
    } showAlert:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
