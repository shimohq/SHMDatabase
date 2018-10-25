//
//  DisplayViewController.m
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "DisplayViewController.h"
#import "AnyModel.h"
#import "DisplayCell.h"
#import "SHMDatabase.h"

@interface DisplayViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, copy) NSArray *             list;
@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.list = ({
        NSArray *list = [AnyModel shmdb_findAll];
        list;
    });
    
    self.table.dataSource = self;
    self.table.delegate   = self;
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DisplayCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"DisplayCell"];
    cell.model = self.list[indexPath.row] ;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 521;
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
