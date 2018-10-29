
# 设计初衷: 
快速一站式sqlite数据库搭建. 调用更轻.快. 无需关注细节 .

# 更多优势:
* 无基类, 无入侵性. 可直接在第三方类上建表 .
* 直接脱离项目中控制表的繁杂代码, Model直接进入CURD操作.脱离sql语句.  
* 自带默认字段pkid, xt_createTime, xt_updateTime, xt_isDel. 无需关注主键和创建更新时间变化处理 .
* 自动建表 .
* 主键自增. 插入不需设主键. 默认pkid .
* 任何操作. 线程安全 .
* 批量操作默认实务.以及失败回滚  .
* 支持各容器类存储. NSArray, NSDictionary. 以及容器中带有自定义类等. 能处理任意嵌套组合.
* 数据库升级简单, 一行代码完成数据库多表升级. 只需设置一个新的数据库版本号 .
* 每个字段可自定义设置关键字. 已经集成默认关键字, 无需再写非空和默认值( NOT NULL, DEFAULT''字符类型默认值,DEFAULT'0'数字类型默认值 ) .
* 支持忽略属性, 比如ViewModel 可指定哪些字段不参与CURD操作 .  
* 常规函数,数量,求和,最值等 .
* 支持NSData类型 .
* 支持UIImage类型 .

# 设计思路:
运用 iOS Runtime 在目前最权威的sqlite开源库FMDB之上增加ORM模型关系映射,  并使用Category的方式脱离基类, 并动态加入默认字段. 使任何类都能建表.

![图片](https://images-cdn.shimo.im/CfG7jytREwoQhB8N/SHMDatabase.png!thumbnail)



---
# 接入方式:
cocoapod私有库
增加spec源
```
source 'https://git.shimo.im/ios/Specs'
source 'https://github.com/CocoaPods/Specs.git'
```
加入pod
```
pod 'SHMDatabase', :git => 'git@git.shimo.im:ios/SHMDatabase.git'
```
# 如何使用:
导入头文件  #import <SHMDatabase.h>


1. 启动时配置

在AppDelegate didFinishLaunchingWithOptions中完成配置
```
[SHMDatabaseSDK sharedInstance].isDebugMode = YES; //是否打印内部log
NSString *yourDbPath = @".../shimoDB"; 
[[SHMDatabaseSDK sharedInstance] configureDBWithPath:yourDbPath];

```

1. 插入
```
// insert
- (BOOL)shmdb_insert;
+ (BOOL)shmdb_insertList:(NSArray *)modelList;

// insert or ignore
- (BOOL)shmdb_insertOrIgnore;
+ (BOOL)shmdb_insertOrIgnoreWithList:(NSArray *)modelList;

// insert or replace
- (BOOL)shmdb_insertOrReplace;
+ (BOOL)shmdb_insertOrReplaceWithList:(NSArray *)modelList;

// upsert
- (BOOL)shmdb_upsertWhereByProp:(NSString *)propName;
```
以下m1代表AnyModel.class下的实例.
```
[m1 shmdb_insert];//单个
[AnyModel shmdb_insertList:list];//批量

[m1 shmdb_insertOrIgnore]; //如果存在则忽略, 单个
[AnyModel shmdb_insertOrIgnoreWithList:list]; //如果存在则忽略, 批量

[m1 shmdb_insertOrReplace]; //如果存在则替换, 单个
[AnyModel shmdb_insertOrReplaceWithList:list]; //如果存在则替换, 批量

  [m1 shmdb_upsertWhereByProp:@"name"];//存在则更新,不存在则插入.    
  
  ```
  
  2. 更新
  ```
  // update by pkid .
  - (BOOL)shmdb_update; // Update default update by pkid. if pkid nil, update by a
  // unique prop if has .
  + (BOOL)shmdb_updateListByPkid:(NSArray *)modelList;
  
  // update by custom key .
  - (BOOL)shmdb_updateWhereByProp:(NSString *)propName;
  + (BOOL)shmdb_updateList:(NSArray *)modelList whereByProp:(NSString *)propName;
  ```
  e.g.
  ```
  [m1 shmdb_update];//更新此对象(条件按pkid)
  [m1 shmdb_updateWhereByProp:@"name"];//更新此对象(条件按指定字段)
  
  //批量
  [AnyModel shmdb_updateListByPkid:list];
  [AnyModel shmdb_updateList:list whereByProp:@"name"];    
  
  ```
  
  3. 查询
  ```
  + (NSArray *)shmdb_findAll;
  + (NSArray *)shmdb_findWhere:(NSString *)strWhere; // param e.g. @" pkid = '1' "
  
  + (instancetype)shmdb_findFirstWhere:(NSString *)strWhere;
  + (instancetype)shmdb_findFirst;
  + (BOOL)shmdb_hasModelWhere:(NSString *)strWhere;
  
  // any sql execute Query
  + (NSArray *)shmdb_findWithSql:(NSString *)sql;
  + (instancetype)shmdb_findFirstWithSql:(NSString *)sql;
  ```
  e.g.
  ```
  list = [AnyModel shmdb_findAll]; //查询此表所有记录
  list = [AnyModel shmdb_findWhere:@"name == 'mamba'"];//条件查询
  
  item = [AnyModel shmdb_findFirstWhere:@"name == 'mamba'"];//查询单个
  item = [AnyModel shmdb_findFirst];
  
  bool has = [AnyModel shmdb_hasModelWhere:@"age < 4"] ; //是否存在满足条件的数据
  
  list = [AnyModel shmdb_findWithSql:@"select * from AnyModel"] ;//自定义sql语句, 查询列表
  item = [AnyModel shmdb_findFirstWithSql:@"select * from AnyModel where age == 111"] ;//自定义sql语句, 查询单个
  
  ```
  
  4. 删除
  ```
  [m1 shmdb_deleteModel];//删除记录
  [AnyModel shmdb_deleteModelWhere:@"name == 'peter'"];
  [AnyModel shmdb_dropTable]; //删除表
  
  ```
  
  5. 常用函数
  ```
  // func execute Statements
  + (id)shmdb_anyFuncWithSql:(NSString *)sql;
  + (BOOL)shmdb_isEmptyTable;
  + (int)shmdb_count;
  + (int)shmdb_countWhere:(NSString *)whereStr;
  + (double)shmdb_maxOf:(NSString *)property;
  + (double)shmdb_maxOf:(NSString *)property where:(NSString *)whereStr;
  + (double)shmdb_minOf:(NSString *)property;
  + (double)shmdb_minOf:(NSString *)property where:(NSString *)whereStr;
  + (double)shmdb_sumOf:(NSString *)property;
  + (double)shmdb_sumOf:(NSString *)property where:(NSString *)whereStr;
  + (double)shmdb_avgOf:(NSString *)property;
  + (double)shmdb_avgOf:(NSString *)property where:(NSString *)whereStr;
  ```
  e.g.
  ```
  int count = [AnyModel shmdb_count] ;
  int count = [AnyModel shmdb_countWhere:@"age < 10"] ;
  
  double max = [AnyModel shmdb_maxOf:@"age"] ;
  double max = [AnyModel shmdb_maxOf:@"age" where:@"location == 'shanghai'"] ;
  
  ```
  
  6. 配置约束
  
  需要更深入的配置建表, 在AnyModel类中重载三个方法
  ```
  // props Sqlite Keywords
  + (NSDictionary *)modelPropertiesSqliteKeywords; // set sqlite Constraints of property
  
  // ignore Properties . these properties will not join db CURD .
  + (NSArray *)ignoreProperties;
  
  // Container property , value should be Class or Class name. Same as YYmodel .
  + (NSDictionary *)modelContainerPropertyGenericClass;
  ```
  modelPropertiesSqliteKeywords , 配置属性约束, 非空与默认值已经加入无需配置, 例如在这里可以指定某字段的唯一性
  ```
  + (NSDictionary *)modelPropertiesSqliteKeywords {
  return @{@"name":@"UNIQUE"} ;
  }
  ```
  ignoreProperties, 配置不想参加建表的字段. 例如ViewModel相关的属性等.
  ```
  + (NSArray *)ignoreProperties {
  return @[@"a1",@"a2"] ;
  }
  ```
  modelContainerPropertyGenericClass, 处理在容器类型中嵌套有其他类.
  ```
  @class Shadow, Border, Attachment;
  
  @interface Attributes
  @property NSString *name;
  @property NSArray *shadows; //Array<Shadow>
  @property NSSet *borders; //Set<Border>
  @property NSMutableDictionary *attachments; //Dict<NSString,Attachment>
  @end
  
  @implementation Attributes
  // 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
  + (NSDictionary *)modelContainerPropertyGenericClass {
  return @{@"shadows" : [Shadow class],
  @"borders" : Border.class,
  @"attachments" : @"Attachment" };
  }
  @end
  ```
  
  1. 升级
  ```
  /**
   DB Version Upgrade
    @param tableCls    Class
     @param paramsAdd   @[propName1 ,propName2 ,... ,]
      @param version (int) start from 1
       */
       - (void)dbUpgradeTable:(Class)tableCls
                    paramsAdd:(NSArray *)paramsAdd
                                   version:(int)version;
                                   ```
                                   e.g.
                                   ```
                                   [[SHMDatabaseSDK sharedInstance] dbUpgradeTable:AnyModel.class
                                                                         paramsAdd:@[ @"b1",@"b2",@"b3" ]
                                                                                                                 version:2];
                                                                                                                 //只需传入对应表,新增字段数组,和对应数据库版本号.版本号默认从1开始.
                                                                                                                 ```
                                                                                                                 
                                                                                                                 end
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 附:
                                                                                                                 * demo地址 [https://git.shimo.im/ios/SHMDatabase](https://git.shimo.im/ios/SHMDatabase)
                                                                                                                 * mac上的sqlite可视化工具推荐 SQLite Professional
                                                                                                                 
                                                                                                                 使用中如有任何疑问,请微信或钉钉于我 ﻿xietianchen@shimo.im 
                                                                                                                 

