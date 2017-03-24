//
//  ViewController.m
//  GTTextFieldCategoryApp
//
//  Created by zhaoke.hzk on 17/3/24.
//  Copyright © 2017年 zhaoke.hzk. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+keyboard.h"


@interface ViewController ()

@property (nonatomic , strong)UITextView* textField;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView* textField = [[UITextView alloc] initWithFrame:CGRectMake(100, 300, 100, 200)];
    textField.isAutoAdjust = YES;
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 30)];
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    
}

-(void)test:(id)sender{
    [self.textField resignFirstResponder];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
