//
//  ViewController.m
//  pullDownView
//
//  Created by Saurav  Mishra on 10/09/16.
//  Copyright © 2016 Saurav  Mishra. All rights reserved.
//

#import "ViewController.h"
#import "PullDownView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[PullDownView pullDownViewSingleton] addSwipeDownGestureToController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
