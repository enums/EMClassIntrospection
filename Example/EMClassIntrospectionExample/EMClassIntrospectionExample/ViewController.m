//
//  ViewController.m
//  EMClassIntrospectionExample
//
//  Created by 郑宇琦 on 2016/10/20.
//  Copyright © 2016年 郑宇琦. All rights reserved.
//

#import "ViewController.h"
@import EMClassIntrospection;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    //Print all subclass of UIViewController
    //The same as:
    //[EMCI pSubclass:@"UIViewCOntroller"];
    [EMCI PS:@"UIViewController"];
    
    //Set the class of self to be target
    //The same as:
    //[EMCI sObject:self];
    [EMCI SO:self];
    
    //Print Inherit relationship of self
    //The same as:
    //[EMCI pInherit];
    [EMCI PI];
    
    //Print all instance methods of self
    //The same as:
    //[EMCI pInstanceMethod];
    [EMCI PIM];
    
    //Print the detail of the 2-nd instance method
    //The same as:
    //[EMCI pInstanceMethodDetail:2];
    [EMCI PIMD:2];
    
    //Cancel the target
    //The same as:
    //[EMCI sBack];
    [EMCI SB];
}


@end
