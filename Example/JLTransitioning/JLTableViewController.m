//
//  JLTableViewController.m
//  JLTransitioning
//
//  Created by Julian.Song on 16/7/21.
//  Copyright © 2016年 junliang.song. All rights reserved.
//

#import "JLTableViewController.h"
#import "JLViewController.h"
@interface JLTableViewController ()
@property NSArray *transionings;
@end

@implementation JLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transionings = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TransitioningList" ofType:@"plist"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transionings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseIdentifier"];
    }
    NSDictionary *item = [self.transionings objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"Name"];
    cell.detailTextLabel.text = [item objectForKey:@"Description"];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = [self.transionings objectAtIndex:indexPath.row];
    NSString *name = [item objectForKey:@"Name"];
    Class trans = NSClassFromString(name);
    JLViewController *jlVC = [[JLViewController alloc] init];
    jlVC.transitioning = [[trans alloc] init];
    jlVC.transitioningDelegate = jlVC.transitioning;
    jlVC.modalTransitionStyle = UIModalPresentationCustom;
    jlVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:jlVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
