//
//  JLViewController.m
//  JLTransitioning
//
//  Created by junliang.song on 07/21/2016.
//  Copyright (c) 2016 junliang.song. All rights reserved.
//

#import "JLViewController.h"

@interface JLViewController ()

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:46/255.0f green:204/255.0f  blue:113/255.0f  alpha:1.0f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // Dispose of any resources that can be recreated.
}

@end
