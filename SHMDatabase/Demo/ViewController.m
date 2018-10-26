//
//  ViewController.m
//  SHMDatabase
//
//  Created by teason23 on 2018/10/25.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "ViewController.h"
#import "AccessObj.h"
#import "AnyModel.h"
#import "DisplayViewController.h"
#import "Masonry.h"
#import "SomeInfo.h"
#import "SHMDatabase.h"
#import "YYModel.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (copy, nonatomic) NSArray *             datasource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title                  = @"SHMDatabase";
    self.datasource             = @[
                                    @"create",
                                    @"find",
                                    @"findWhere",
                                    @"insert",
                                    @"insertOrIgnore",
                                    @"insertOrReplace",
                                    @"update",
                                    @"upsert",
                                    @"delete",
                                    @"drop",
                                    @"insertList",
                                    @"updateList",
                                    @"findFirst",
                                    @"AlterAdd",
                                    @"sum",
                                    @"orderBy",
                                    ];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainVCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainVCell"] ;
    }
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strButtonName =
    [self.datasource[indexPath.row] stringByAppendingString:@"Action"];
    SEL methodSel = NSSelectorFromString(strButtonName);
    ((void (*)(id, SEL, id))objc_msgSend)(self, methodSel, nil);
}

#pragma mark - actions

- (void)createAction {
    [AnyModel shmdb_createTable];
}

- (void)findAction {
    NSArray *list = [AnyModel shmdb_findAll];
    for (AnyModel *model in list) {
        NSLog(@"%d", model.pkid);
    }
    
    [self displayJump];
}

- (void)findWhereAction {
    NSArray *list = [AnyModel shmdb_findWhere:@"age > 10 "];
    NSLog(@"list : %@ \ncount:%@", list, @(list.count));
}

- (void)insertAction {
    AnyModel *m1 = [AnyModel customRandomModel];
    [m1 shmdb_insert];
    
    [self displayJump];
}

- (void)insertOrIgnoreAction {
    AnyModel *m1 = [AnyModel customRandomModel];
    m1.title     = @"insert or ignore";
    [m1 shmdb_insertOrIgnore];
    
    [self displayJump];
}

- (void)insertOrReplaceAction {
    AnyModel *m1 = [AnyModel customRandomModel];
    m1.title     = @"insert or replace";
    [m1 shmdb_insertOrReplace];
    
    [self displayJump];
}

- (void)upsertAction {
    AnyModel *m1 = [AnyModel customRandomModel];
    m1.title     = @"upsert 知道么";
    [m1 shmdb_upsertWhereByProp:@"title"];
    
    [self displayJump];
}

- (void)updateAction {
    AnyModel *m1 = [[AnyModel shmdb_findAll] firstObject];
    m1.title     = @"我就改第一个";
    [m1 shmdb_update];
    
    [self displayJump];
}

- (void)deleteAction {
    NSString *titleDel = ((AnyModel *)[[AnyModel shmdb_findAll] lastObject]).title;
    [AnyModel shmdb_deleteModelWhere:[NSString stringWithFormat:@"title == '%@'",
                                   titleDel]];
    [self displayJump];
}

- (void)dropAction {
    [AnyModel shmdb_dropTable];
    [self displayJump];
}

- (void)insertListAction {
    NSMutableArray *list = [@[] mutableCopy];
    for (int i = 0; i < 10; i++) {
        AnyModel *m1 = [AnyModel customRandomModel];
        m1.age       = i + 1;
        m1.floatVal  = i + 0.3;
        m1.title     = [NSString stringWithFormat:@"insert list%d", i];
        [list addObject:m1];
    }
    [AnyModel shmdb_insertList:list];
    
    [self displayJump];
}

- (void)updateListAction {
    NSArray *       getlist = [AnyModel shmdb_findWhere:@"age > 5"];
    NSMutableArray *tmplist = [@[] mutableCopy];
    for (int i = 0; i < getlist.count; i++) {
        AnyModel *model = getlist[i];
        model.title     = [model.title
                           stringByAppendingString:[NSString stringWithFormat:@">5的都改了.+%d",
                                                    model.age]];
        [tmplist addObject:model];
    }
    [AnyModel shmdb_updateListByPkid:tmplist];
    
    [self displayJump];
}

- (void)findFirstAction {
    AnyModel *model = [AnyModel shmdb_findFirstWhere:@"pkid == 1"];
    NSLog(@"m : %@", [model yy_modelToJSONObject]);
}

- (void)AlterAddAction {
    [[SHMDatabaseSDK sharedInstance] dbUpgradeTable:AnyModel.class
                                      paramsAdd:@[ @"lztmjyxjzdzmy" ]
                                        version:2];
}

- (void)sumAction {
    double sumOfAges = [AnyModel shmdb_sumOf:@"age"];
    NSLog(@"sum of ages : %lf", sumOfAges);
}

- (void)orderByAction {
    NSArray *result = [[AnyModel shmdb_findAll] shmdb_orderby:@"age" descOrAsc:YES];
    NSLog(@"order by  ???? \n: %@", [result yy_modelToJSONObject]);
}

#pragma mark -

- (void)displayJump {
    [self performSegueWithIdentifier:@"root2display" sender:nil];
}

@end
