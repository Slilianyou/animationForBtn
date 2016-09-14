//
//  ViewController.m
//  animationForBtn
//
//  Created by ss-iOS-LLY on 16/9/9.
//  Copyright © 2016年 lilianyou. All rights reserved.
//

#import "ViewController.h"
#import "EmitterButton.h"


@interface ViewController ()
@property (nonatomic, strong) EmitterButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.btn = [[EmitterButton alloc]initWithFrame:CGRectMake(40, 80, [UIScreen mainScreen].bounds.size.width - 80 , [UIScreen mainScreen].bounds.size.height - 160)];
    [self.btn setImage:[UIImage imageNamed:@"赞icon"] forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"赞icon-点击态"] forState:UIControlStateSelected];
    [self.btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
